<?php
namespace Home\Controller;
use Think\Cache\Driver\Hredis;
use Think\Controller;
use EasyWeChat\Foundation\Application;
use EasyWeChat\Payment\Order;
class WeixinController extends Controller {

    protected $options;
    protected $app;
    protected $server;
    protected $user;
    protected $oauth;
    protected $menu;
    protected $shopid;

    public function _initialize(){

        $this->shopid = 1;//1为三弦男装
        $this->options = [
            'oauth'  => [
                'scopes' => ['snsapi_userinfo'],
                'callback' => '/Home/weixin/callback/',
            ],
            'payment' => [
                'cert_path'          => 'Uploads/sanxian/apiclient_cert.pem', // XXX: 绝对路径！！！！
                'key_path'           => 'Uploads/sanxian/apiclient_key.pem',      // XXX: 绝对路径！！！！
            ],
        ];

        $redis = new Hredis();
//        $config = $redis->hmget(C('REDIS_KEY').":config",array('appid','secret','token','key','merchant_id')); //获取配置数据
        $config = D('WeixinConfig')->select();

        $this->options['app_id'] = $config[0]['value'];
        $this->options['secret'] = $config[1]['value'];
        $this->options['token'] = $config[2]['value'];
        $this->options['payment']['key'] = $config[4]['value'];
        $this->options['payment']['merchant_id'] = $config[5]['value'];

        $this->app = new Application($this->options);
        $this->server = $this->app->server;
        $this->oauth = $this->app->oauth;
        $this->menu = $this->app->menu;
    }


    /**
     * 企业支付
     */
    public function pay($send,$uid,$orderid){
        $merchantPay = $this->app->merchant_pay;
        $merchantPayData = [
            'partner_trade_no' => $orderid, //随机字符串作为订单号，跟红包和支付一个概念。
            'openid' => $send['openid'], //收款人的openid
            'check_name' => 'NO_CHECK',  //文档中有三种校验实名的方法 NO_CHECK OPTION_CHECK FORCE_CHECK
            're_user_name'=>'张三',     //OPTION_CHECK FORCE_CHECK 校验实名的时候必须提交
            'amount' => $send['money']*100,  //单位为分
            'desc' => '企业付款',
            'spbill_create_ip' => '192.168.0.1',  //发起交易的IP地址
        ];
        $result = $merchantPay->send($merchantPayData);
        if($result['result_code']=="SUCCESS"){//发送成功
            $send['adminid'] = session('admin.id');
            $send['uid'] = $uid;
            M('Dividedinto_history')->add($send);
            return "200";
        }else{
            return $result['err_code_des'];
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：与微信服务器连通接口
     */
    public function index(){
        $server = $this->app->server;
        $server->setMessageHandler(function ($message) {
            return "您好！欢迎关注我!";
        });
        $response = $server->serve();
        $response->send(); // Laravel 里请使用：return $response;
    }


    /**
     * 微信登录页
     * @param string $url
     */
    public function login($url){

        if (empty(session('user.id'))) {//判断是否已经登录
            session('target_url',$url);//缓存入口页面
            $this->oauth->redirect()->send();//跳转到回调页面
        }else{
            redirect(urldecode($url));
        }
    }

    /**
     * 授权回调页面
     */
    public function callback(){
        $redis = new Hredis();
        $this->user = $this->app->oauth->user();
        $Model = D('user');
        $map['openid'] = $this->user->getId();
        $data = $Model->where($map)->find();
        if($data['is_delete'] == 2){
            $this->assign('text',"您的帐号已经被禁止登录！");
            $this->display('Public/error');
            exit();
        }
        if($data){//存在用户
            session('user',$data);//登录标识
            session('shopid',$data['shopid']);
            $redis->hmset(C('REDIS_KEY').":user:".$data['id'],$data);
            $redis->expire(C('REDIS_KEY').":user:".$data['id']);
        }else{
            $add['openid'] = $map['openid'];
            $add['nickname'] = $this->user->getNickname();
            $add['integral'] = 0;
            $add['shopid'] = 1;
            $add['img'] = $this->user->getAvatar();
            $res = $Model->add($add);//添加新用户


            A('user')->reg($res,$this->user->getNickname());//注册聊天方法


            M('user')->where(array('id'=>$res))->setField('chatid',C('KEFU').$res);
            $add['id'] = $res;
            $add['chatid'] = C('KEFU').$res;
            session('user',$add);
            $redis->hmset(C('REDIS_KEY').":user:".$add['id'],$add);
            $redis->expire(C('REDIS_KEY').":user:".$add['id']);
        }

        A('user')->save_img(session('user.img'),session('user.id'));
        redirect(urldecode(session('target_url')));
    }

    /**
     * 获取jssdk值
     * @return mixed
     */
    public function getjs(){
        return $this->app->js;
    }

    /**
     * 统一下单
     */
    public function createorder($title="",$orderid="",$money=""){
//        $money = 1;

        $payment = $this->app->payment;
        $attributes = [
            'body'             => $title,
            'detail'           => $title,
            'out_trade_no'     => $orderid,
            'total_fee'        => $money*100,
            'trade_type'       => 'JSAPI',
            'openid'           => session('user.openid'),
            'notify_url'       => C('SITE_PATH').'Home/weixin/Notify/', // 支付结果通知网址，如果不设置则会使用配置里的默认地址
        ];

        $order = new Order($attributes);//创建订单
        $result = $payment->prepare($order);
//        return $result->prepay_id;
//        return $result->result_code ;
        $prepayId = $result->prepay_id;
        return $prepayId;
    }

    /**
     * 支付回调方法
     */
    public function Notify(){
        $response = $this->app->payment->handleNotify(function($notify, $successful){
            $model = M('order');
            $order = $model->where(array('uniqueid'=>$notify->out_trade_no))->find();
            if (!$order) { // 如果订单不存在
                return 'Order not exist.'; // 告诉微信，我已经处理完了，订单没找到，别再通知我了
            }
            // 如果订单存在,检查订单是否已经更新过支付状态
            if ($order['pay_time'] != "0000-00-00 00:00:00") { // 假设订单字段“支付时间”不为空代表已经支付
                return true; // 已经支付成功了就不再更新了
            }
            // 用户是否支付成功
            if ($successful == "1") {
                // 不是已经支付状态则修改为已经支付状态
                $save['pay_time'] = date("Y-m-d H:i:s");
                $save['transaction'] = $notify->transaction_id;
                $save['order_state'] = "20";
                $map['uniqueid'] = $notify->out_trade_no;
                //根据该用户订单总额，判断是否成为会员
                $c_map['uid'] =  $order['uid'];
                $c_map['order_state'] = array('EGT',20);
                $redis = new Hredis();
                $config = $redis->hmget(C('REDIS_KEY').":config",array('silver','gold','extreme')); //获取配置数据

                $model->where($map)->save($save);//修改订单信息和状态
                $allmoney = D('Order')->where($c_map)->sum('money');//获取总金额
                D('Commodity')->save_sku($order['orderid'],$order['uid']);                      //修改库存，销量
                D('user')->fenxiao($order);                                                     //记录用户第一次购买的推荐人层级关系
                $type = 0;//默认值

                /*if($allmoney > $config['extreme'] || $order['money'] >= 200000000){
                    //升级为至尊
                    $type = 3;
                }elseif($allmoney > $config['gold'] || $order['money'] >= 200000000){
                    //升级为金卡
                    $type = 2;
                }elseif($allmoney > $config['silver'] || $order['money'] >= 200000000){
                    //升级为银卡
                    $type = 1;
                }else{
                    //第二次消费
                    $type = 4;
                }*/
                $type = 4;
                $user_save = array();
                if($order['type'] == 2){
                    $user_save['integral'] = array('exp','integral-'.$order['money']);
                }

                if($type != 0){
                    $user_save['member'] = $type;
                }
                if(count($user_save) > 0){
                    M('user')->where(array('id'=>$order['uid']))->save($user_save);
                }

                $my_notice = D('order_commodity_snop')->cale($order['orderid'],$order['uid']);  //计算有哪些用户需要微信通知的
                $redis->del(C('REDIS_KEY').":user:".$order['uid']);
                if($order['type'] == 1){
                    foreach ($my_notice as $k => $v){
                        $this->send_message_buy($v,$order['money']);
                    }
                }
            } else { // 用户支付失败
                //支付失败
            }
            return true; // 返回处理完成
        });

        return $response;
    }

    /**
     * 生产支付JS
     */
    public function zfjs($prepayId){
        $payment = $this->app->payment;
        $json = $payment->configForPayment($prepayId);
        return $json;
    }

    /**
     * 开发者：huangwei
     * 方法功能：物流状态更新通知
     * 编号：OPENTM201605400
     * @param $order
     */
    public function send_message_fahuo($order){
        $accessToken = $this->app->access_token;
        $token = $accessToken->getToken();

        $url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=".$token."&openid=".$order['user']['openid'];
        $data = json_decode(file_get_contents($url),true);

        if($data['subscribe'] == 0){//未关注不做提醒
            return;
        }
        $notice = $this->app->notice;
        $userId = $order['user']['openid'];
        $templateId = 'K2Mc2rm6khQByvn3FDTcYGSo2qnQCHO6etdi5ADaZo4';
        $url = C('SITE_PATH')."Home/order/wuliu/?id=".$order['orderid'];
        $color = '#FF0000';
        $data = array(
            "first"  => "您购买的【".$order['snop'][0]['snopjson']['title']."】已经发货",
            "keyword1"   => "".$order['snop'][0]['snopjson']['title']."",
            "keyword2"  => $order['extend']['couriernumber'],
            "keyword3" => $order['extend']['express'],
            "remark" => "点击查看该订单物流跟踪",
        );
        $messageId = $notice->uses($templateId)->withUrl($url)->andData($data)->andReceiver($userId)->send();
    }

    /**
     * 开发者：huangwei
     * 方法功能：提现审核结果通知
     * 编号：OPENTM202425107
     * @param $openid
     * @param $data1
     */
    public function send_message_money($send){
        $accessToken = $this->app->access_token; // EasyWeChat\Core\AccessToken 实例
        $token = $accessToken->getToken();

        $url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=".$token."&openid=".$send['openid'];
        $data = json_decode(file_get_contents($url),true);

        if($data['subscribe'] == 0){//未关注不做提醒
            return;
        }

        $notice = $this->app->notice;
        $userId = $send['openid'];
        $templateId = 'Uj8hJbGkE-cq_KjFj5hFITh6NNTRluJTTwH_IjAS4fY';
        $url = '';
        $color = '#FF0000';
        $data = array(
            "first"  => "您的收益已经到账！",
            "keyword1"   => $send['money']."元",
            "keyword2"  => "存入微信零钱",
            "keyword3" => $send['time'],
            "keyword4" => "审核通过，并存入零钱",
            "keyword5" => date("Y-m-d H:i:s"),
            "remark" => "",
        );
        $messageId = $notice->uses($templateId)->withUrl($url)->andData($data)->andReceiver($userId)->send();
    }

    /**
     * 开发者：huangwei
     * 方法功能：购买成功通知
     * 编号：OPENTM402058423
     * @param $data
     * @param $money
     */
    public function send_message_buy($array,$money){
        $accessToken = $this->app->access_token; // EasyWeChat\Core\AccessToken 实例
        $token = $accessToken->getToken();
        $url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=".$token."&openid=".$array['openid'];
        $data = json_decode(file_get_contents($url),true);

        if($data['subscribe'] == 0){//未关注不做提醒
            return;
        }
        $notice = $this->app->notice;
        $userId = $array['openid'];
        $templateId = 'xjQh62rSmAjkEdftBPHjP2VrVWK67DJAzwW0d6achSs';
        $url = '';
        $color = '#FF0000';
        $data = array(
            "first"  => "您好，您的朋友【".$array['nickname']."】通过您的推广链接购买了套餐",
            "keyword1"   => "".$array['title']."",
            "keyword2"  => $money."元",
            "keyword3" => date("Y-m-d H:i:s"),
            "remark" => "您的收益预计为:".$array['money']."元，收益在管理员审核后发送至您的微信零钱！",
        );
        $messageId = $notice->uses($templateId)->withUrl($url)->andData($data)->andReceiver($userId)->send();
    }

    /**
     * 开发者：huangwei
     * 方法功能：申请退款接口
     */
    public function refund($transactionId,$refundNo,$money,$money2){
        $payment = $this->app->payment;
        $result = $payment->refundByTransactionId($transactionId, $refundNo, $money, $money2);
        file_put_contents("a.txt",json_encode($result));
    }

}