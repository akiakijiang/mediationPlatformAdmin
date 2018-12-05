<?php
namespace Home\Controller;
use Think\Controller;
class OrderController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('order');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：个人中心我的订单页面
     */
    public function index(){
        $status = I('get.id',0);
        $map['shopid'] = $this->shopid;
        $map['uid'] = $this->uid;
        if($status != 0){
            $map['order_state'] = $status;
        }
        if($status == "50"){
            $map['evaluation_state'] = 0;
        }

        $data = $this->model->where($map)->field('uniqueid,order_state,addressid,orderid,money,carriage,evaluation_state,refund_state,return_status')->relation(true)->order('create_time desc')->select();

        foreach ($data as $k => $v){
            foreach ($data[$k]['snop'] as $k1 => $v1){
                $data[$k]['snop'][$k1]['snopjson'] = json_decode($v1['snopjson'],true);
                $data[$k]['snop'][$k1]['return_status'] = M('order_return_goods')->where(array('snopid'=>$data[$k]['snop'][$k1]['snopid']))->getField('status');
            }
        }
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：下单结算页面
     */
    public function jiesuan(){
        $id = I('get.id',0);
        $map['orderid'] = $id;

        $data = $this->model->where($map)->field('addressid,orderid,money,carriage,commercial')->relation(true)->find();

        foreach ($data['snop'] as $k => $v){
            $data['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }

        $config = A('weixin')->zfjs($data['commercial']);
        $this->assign('config',$config);
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：取消订单    只有在待付款下可以直接取消订单
     */
    public function cancle(){
        $id = I('get.id',0);
        $map['orderid'] = $id;
        $map['uid'] = $this->uid;
        $map['shopid'] = $this->shopid;
        $status =$this->model->where($map)->getField('order_state');//获取当前订单状态

        if($status != "10"){
            retJson("404","切勿非法操作数据！");
        }

        if($this->model->where($map)->setField('order_state',0)){
            retJson("200","取消成功！");
        }else{
            retJson("404","取消失败！");
        }

    }

    /**
     * 开发者：akiaki
     * 方法功能：申请退款接口，状态为20可申请
     */
    public function refund(){
        $model = D('order_refunds');
        $data = I('get.');
        $add['orderid'] = $data['id'];
        $add['shopid'] = $this->shopid;
        $status = $this->model->where($add)->field('order_state,type')->find();

        if($status['type'] == "2"){
            retJson("404","积分商品不支持退货退款！");
        }

        if($status['order_state'] != "20"){
            retJson("404","订单状态异常！");
        }

        if($model->add($add)){
            $this->model->where($add)->setField('order_state',60);
            retJson("200","申请成功，请耐心等待");
        }else{
            retJson("404","申请失败");
        }
    }

    /**
     * 开发者：akiaki
     * 方法功能：用户确认收货操作,状态为30可操作。确认收货后将商品可获得积分返给用户
     */
    public function Goods_receipt(){
        $data = I('get.');
        $add['orderid'] = $data['id'];
        $add['shopid'] = $this->shopid;
        $order = $this->model->where($add)->field('uid,order_state,return_status')->find();
        if($order['order_state'] != "30" || $order['return_status'] != "0"){
            retJson("404","订单状态异常！");
        }

        $this->model->startTrans();
        $save['order_state'] = 50;
        $save['endtime'] = date("Y-m-d H:i:s");
        if($this->model->where($add)->save($save)){
            $snop = M('order_commodity_snop')->where(array('orderid'=>$data['id']))->field('snopjson,snopid')->select();//获取商品列表
            $integral = 0;//默认积分0
            foreach ($snop as $k => $v){
                $snop[$k]['snopjson'] = json_decode($v['snopjson'],true);
                $integral = $integral + $snop[$k]['snopjson']['integral'];//计算该订单总积分值
                if($snop[$k]['snopjson']['type'] != 2){
                    //判断是否积分商品,非积分商品执行下面的
                    $add['shopid'] = $this->shopid;
                    $add['uid'] = $this->uid;
                    $add['snopid'] = $v['snopid'];
                    $add['integral'] = $snop[$k]['snopjson']['integral'];
                    if(!M('integral')->add($add)){
                        $this->model->rollback();
                    }
                }
            }

            if($integral != 0){
                //积分商品订单无需更新用户积分
                if(D('user')->update_integral($order['uid'],$integral)){
                    $this->model->commit();//提交
                    retJson("200","操作成功！");
                }else{
                    $this->model->rollback();
                };//更新用户积分数据
            }else{
                $this->model->commit();//提交
                retJson("200","操作成功！");
            }
        }else{
            $this->model->rollback();
        }
        retJson("404","操作失败");
    }

    /**
     * 开发者：akiaki
     * 方法功能：订单评价界面
     */
    public function evaluate(){
        $id = I('get.id',0);//传入订单ID
        $map['orderid'] = $id;
        $data = $this->model->where($map)->field('uniqueid,order_state,addressid,orderid,money,carriage,evaluation_state,type')->relation('snop')->find();

        foreach ($data['snop'] as $k => $v){
            $data['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }

        if($data['type'] == "2"){
            $this->assign('text',"积分商品不支持评价!");
            $this->display('Public/error');
            exit();
        }

        if($data['evaluation_state'] == 1){//判断订单是否已经评价过
            $this->assign('text',"该订单已经评价过了");
            $this->display('Public/error');
            exit();
        }

        if($data['evaluation_state'] == 2){//判断订单是否已经评价过
            $this->assign('text',"退货订单不允许评价");
            $this->display('Public/error');
            exit();
        }

        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：评价主方法
     */
    public function evaluate_handle(){
        $post = I('post.');
        //先判断是否有权限对该订单进行评价
        $map['orderid'] = $post['id'];//传入订单ID
        $map['uid'] = $this->uid;
        $order = $this->model->where($map)->field('order_state,orderid,evaluation_state')->relation('snop')->find();
        if($order['order_state'] != "50" || $order['evaluation_state'] != 0){
            retJson("404","订单数据异常！");
        }

        foreach ($order['snop'] as $k => $v){
            $order['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }

        $model = D('commodity_comment');
        $model->startTrans();
        foreach ($post['commodityid'] as $k => $v){
            if($v != $order['snop'][$k]['snopjson']['commodityid']){ //防止模拟提交表单
                $model->rollback();
                retJson("404","切勿非法操作！");
            }
            $add['commodityid'] = $v;
            $add['uid'] = $this->uid;
            $add['content'] = $post['content'][$k];
            $add['sku_value'] = $order['snop'][$k]['attr'];
            if(!$model->add($add)){
                $model->rollback();
            }
        }

        if(!$this->model->where($map)->setField('evaluation_state',1)){
            $model->rollback();
        }

        $model->commit();//提交事务

        retJson("200","评价成功！");

    }

    /**
     * 开发者：akiaki
     * 方法功能：查看物流页面
     */
    public function wuliu(){
        $map['orderid'] = I('get.id',0);//传入订单ID
        $data = $this->model->where($map)->relation(array('snop','extend'))->find();

        foreach ($data['snop'] as $k => $v){
            $data['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }

        switch ($data['extend']['express']){
            case "顺丰快递":
                $type = "shunfeng";
                break;
            case  "圆通快递":
                $type = "yuantong";
                break;
            case  "韵达快递":
                $type = "yunda";
                break;
            case  "中通快递":
                $type = "zhongtong";
                break;
            case  "传喜物流":
                $type = "chuanxiwuliu";
                break;
            case  "德邦物流":
                $type = "debangwuliu";
                break;
            case  "EMS":
                $type = "ems";
                break;
            case  "全峰快递":
                $type = "qfkd";
                break;
            case  "申通快递":
                $type = "shentong";
                break;
            case  "天天快递":
                $type = "tt";
                break;
        }

        $kuaidi = file_get_contents("http://www.kuaidi100.com/query?type=".$type."&postid=".$data['extend']['couriernumber']."&id=1&valicode=&temp=0.9179467244822972");
        $kuaidi = json_decode($kuaidi,true);
        if($kuaidi['status'] != "200"){
            $this->assign('error',$kuaidi['message']);
        }

        $this->assign('data',$data);
        $this->assign('kuaidi',json_encode($kuaidi['data']));
        $this->display();
    }


    /**
     * 开发者：akiaki
     * 方法功能：商品详情页直接下单
     */
    public function set_order_from_detail(){
        $post = I('post.');
        $id = $post['id'];//商品ID
        $sku = $post['sku'];
        $nub = $post['nub'];

        $data = D('commodity')->get_goods($id,"",1);                //获取商品数据
        $sku_data = D('commodity')->get_attr($sku,$id);             //获取sku数据
        if($data['type'] == 2){
            //积分商品，判断积分是否充足
            if($data['current']*$nub > session('user.integral')){
                retJson("404","积分余额不足！");
            }
            $order['money'] = 0 + 5;       //订单总价 = 单价 * 数量 + 运费
        }else{
            $order['money'] = $sku_data['attr_money'] * $nub + 5;       //订单总价 = 单价 * 数量 + 运费
        }

        $order['uniqueid'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $order['shopid'] = $this->shopid;
        $order['uid'] = $this->uid;

        $address = A('address')->get_one();
        if($address == 0){
            $order['addressid'] = 0;
        }else{
            $order['addressid'] = $address['addressid'];
        }

        $order['carriage'] = 5;                                     //暂时固定
        $order['commercial'] = A('weixin')->createorder($data['title'],$order['uniqueid'],1);//生成微信支付订单,这里是金额

        $orderid = $this->model->add($order);//新增订单

        $snop['orderid'] = $orderid;
        $snop['snopjson'] = json_encode($data);
        $snop['money'] = $sku_data['attr_money'];
        $snop['nums'] = $nub;
        $snop['attr'] = $sku;
        $snop['skuid'] = $sku_data['bianma'];
        $snop['url'] = session('tuijian') ? session('tuijian') : 0;

        if(M('order_commodity_snop')->add($snop)){
            retJson("200",$orderid);
        }
        retJson("404","下单失败！");
    }

    /**
     * 开发者：akiaki
     * 方法功能：从购物车下单
     */
    public function set_order_from_cart(){
        $map['uid'] = $this->uid;
        $map['shopid'] = $this->shopid;

        $cart = M("cart")->where($map)->select();//获取购物车内商品数据

        $order['uniqueid'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $order['shopid'] = $this->shopid;
        $order['uid'] = $this->uid;

        $address = A('address')->get_one();
        if($address == 0){
            $order['addressid'] = 0;
        }else{
            $order['addressid'] = $address['addressid'];
        }

        $money = 0;//初始化订单价格为0
        foreach ($cart as $k => $v){
            $money = $money + $v['money']*$v['nubs'];
        }

        $data = D('commodity')->get_goods($cart[0]['commodityid'],"",1);                //获取商品数据

        $order['money'] = $money + 5;       //订单总价 = 单价 * 数量 + 运费
        $order['carriage'] = 5;                                     //暂时固定
        $order['commercial'] = A('weixin')->createorder($data['title'],$order['uniqueid'],1);//生成微信支付订单,这里是金额

        $type = true;
        if($orderid = $this->model->add($order)){
            foreach ($cart as $k => $v){
                $snop['skuid'] = $v['skuid'];
                $data = D('commodity')->get_goods($v['commodityid'],"",1);
                $snop['snopjson'] = json_encode($data);
                $snop['orderid'] = $orderid;
                $snop['money'] = $cart[$k]['money'];
                $snop['nums'] = $cart[$k]['nubs'];
                $snop['attr'] = $cart[$k]['sku'];
                $snop['url'] = $cart[$k]['url'];
                M('order_commodity_snop')->add($snop);
            }
        }
        M("cart")->where($map)->delete();
        retJson("200",$orderid);
    }


}