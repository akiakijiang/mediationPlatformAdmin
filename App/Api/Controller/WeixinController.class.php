<?php
namespace Home\Controller;
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
        $map['shopid'] = $this->shopid;
        $config = M('weixin_config')->where($map)->field('shopid',true)->select();//获取当前店铺的配置

        foreach ($config as $k => $v){
            if($v['name'] == "appid"){
                $this->options['app_id'] = $v['value'];
            }elseif($v['name'] == "secret"){
                $this->options['secret'] = $v['value'];
            }elseif($v['name'] == "token"){
                $this->options['token'] = $v['value'];
            }elseif($v['name'] == "key"){
                $this->options['payment']['key'] = $v['value'];
            }elseif($v['name'] == "merchant_id"){
                $this->options['payment']['merchant_id'] = $v['value'];
            }
        }

        $this->app = new Application($this->options);
        $this->server = $this->app->server;
        $this->oauth = $this->app->oauth;
        $this->menu = $this->app->menu;
    }


    /**
     * 企业支付
     */
    public function pay($openid,$orderid,$money){
        $merchantPay = $this->app->merchant_pay;
        $merchantPayData = [
            'partner_trade_no' => $orderid, //随机字符串作为订单号，跟红包和支付一个概念。
            'openid' => $openid, //收款人的openid
            'check_name' => 'NO_CHECK',  //文档中有三种校验实名的方法 NO_CHECK OPTION_CHECK FORCE_CHECK
            're_user_name'=>'张三',     //OPTION_CHECK FORCE_CHECK 校验实名的时候必须提交
            'amount' => $money*100,  //单位为分
            'desc' => '企业付款',
            'spbill_create_ip' => '192.168.0.1',  //发起交易的IP地址
        ];
        $result = $merchantPay->send($merchantPayData);
        if($result['result_code']=="SUCCESS"){//发送成功
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
        $this->user = $this->app->oauth->user();
        $Model = D('user');
        $map['openid'] = $this->user->getId();
        $data = $Model->where($map)->find();
        if($data){//存在用户
            session('user',$data);//登录标识
            session('shopid',$data['shopid']);
        }else{
            $add['openid'] = $map['openid'];
            $add['nickname'] = $this->user->getNickname();
            $add['integral'] = 0;
            $add['shopid'] = 1;
            $add['img'] = $this->user->getAvatar();
            $res = $Model->add($add);//添加新用户
            A('user')->reg($res,$this->user->getNickname());//注册聊天方法
            M('user')->where(array('id'=>$res))->setField('chatid',"sanxian".$res);
            $add['id'] = $res;
            $add['chatid'] = "sanxian".$res;
            session('user',$add);
        }
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
        $payment = $this->app->payment;
        $attributes = [
            'body'             => $title,
            'detail'           => $title,
            'out_trade_no'     => $orderid,
            'total_fee'        => $money,
            'trade_type'       => 'JSAPI',
            'openid'           => session('user.openid'),
            'notify_url'       => 'http://shop.sunday.so/Home/weixin/Notify/', // 支付结果通知网址，如果不设置则会使用配置里的默认地址
        ];

        $order = new Order($attributes);//创建订单
        $result = $payment->prepare($order);
        $prepayId = $result->prepay_id;
        return $prepayId;
    }

    /**
     * 支付回调方法
     */
    public function Notify(){
        $response = $this->app->payment->handleNotify(function($notify, $successful){
            $model = M('order');
            $User = M('user');
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
                $model->where($map)->save($save);//修改订单信息和状态
                D('Commodity')->save_sku($order['orderid']);//修改库存，销量
                D('user')->fenxiao($order);//记录用户第一次购买的推荐人层级关系
            } else { // 用户支付失败
                //支付失败
            }
            return true; // 返回处理完成
        });

        return $response;
    }

    //public function dd(){
    //    dump("模拟付款");
    //    $id = "2016081799565310";
    //    $model = M('order');
    //    $User = M('user');
    //    $order = $model->where(array('uniqueid'=>$id))->find();
    //    if (!$order) { // 如果订单不存在
    //        return 'Order not exist.'; // 告诉微信，我已经处理完了，订单没找到，别再通知我了
    //    }
    //    // 如果订单存在,检查订单是否已经更新过支付状态
    //    if ($order['pay_time'] != "0000-00-00 00:00:00") { // 假设订单字段“支付时间”不为空代表已经支付
    //        return true; // 已经支付成功了就不再更新了
    //    }
    //    // 用户是否支付成功
    //    if ("1") {
    //        // 不是已经支付状态则修改为已经支付状态
    //        $save['pay_time'] = date("Y-m-d H:i:s");
    //        $save['transaction'] = $id;
    //        $save['order_state'] = "20";
    //        $map['uniqueid'] = $id;
    //        $model->where($map)->save($save);//修改订单信息和状态
    //        D('Commodity')->save_sku($order['orderid']);//修改库存，销量
    //        D('user')->fenxiao($order);//记录用户第一次购买的推荐人层级关系
    //    } else { // 用户支付失败
    //        //支付失败
    //    }
    //    return true; // 返回处理完成
    //}

    /**
     * 生产支付JS
     */
    public function zfjs($prepayId){
        $payment = $this->app->payment;
        $json = $payment->configForPayment($prepayId);
        return $json;
    }


}