<?php
namespace Home\Controller;
use Think\Controller;
use Think\Cache\Driver\Hredis;
class OrderController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;

    public function  _initialize(){
        $this->shopid = 1;
        $this->uid = session('user.id');
        $this->model = D('order');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：个人中心我的订单页面
     */
    public function index(){
        $map['shopid'] = $this->shopid;
        $map['uid'] = $this->uid;

        $data = $this->model->where($map)->field('type,uniqueid,order_state,addressid,orderid,money,carriage,evaluation_state,refund_state,return_status')->relation(true)->order('create_time desc')->select();

        foreach ($data as $k => $v){
            foreach ($data[$k]['snop'] as $k1 => $v1){
                $data[$k]['snop'][$k1]['snopjson'] = json_decode($v1['snopjson'],true);
                $data[$k]['snop'][$k1]['return_status'] = M('order_return_goods')->where(array('snopid'=>$data[$k]['snop'][$k1]['snopid']))->getField('status');
            }
            if($v['order_state'] == "10"){
                $temp[0][] = $data[$k];
            }else if($v['order_state'] == "20"){
                $temp[1][] = $data[$k];
            }else if($v['order_state'] == "30"){
                $temp[2][] = $data[$k];
            }else if($v['order_state'] == "50" && $v['evaluation_state'] == "0"){
                $temp[3][] = $data[$k];
            }
        }

        $this->assign('temp',$temp);//重组各状态订单
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：下单结算页面
     */
    public function jiesuan(){
        $id = I('get.id',0);
        $map['orderid'] = $id;

        $data = $this->model->where($map)->field('addressid,orderid,money,carriage,commercial,orderid,order_state,type,discount')->relation('snop')->find();
        if($data['order_state'] != "10"){
            $this->assign('text',"订单状态异常！");
            $this->display('Public/error');
            exit();
        }

        $data['money'] = sprintf("%.2f", $data['money']) + number_format($data['carriage'],2);

        $data["carriage_money"] = number_format($data['carriage'],2);

        $coupon = D("Cdkey")->get_coupon($this->uid);
        foreach ($coupon as $k=>$v) {
            if($v['type']==2 && $v['condition']>$data['money']){
                unset($coupon[$k]);
                continue;
            }
            $coupon[$k]["data"] = json_encode($v);
        }

        $address = A('address')->get_all();
        if($data['addressid'] != 0){
            foreach ($address as $k => $v){
                if($v['addressid'] == $data['addressid']){
                    $data['address'] = $v;
                    break;
                }
            }
        }else{
            foreach ($address as $k => $v){
                if($v['is_default'] == "1"){
                    $data['address'] = $v;
                    break;
                }
            }
        }

        if(!isset($data['address'])){
            $data['address'] = array(
                'addressid' => "",
                'is_default' => "",
                'uid'   => "",
                'name'  => "",
                'phone' => "",
                'province' => "",
                'city' => "",
                'district' => "",
                'address' => ""
            );
        }

        foreach ($data['snop'] as $k => $v){
            $data['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }
        $this->assign('data',$data);
        $this->assign('address',$address);
        $this->assign('coupon',$coupon);
        $this->display();
    }

    /**
     *方法功能：从结算页下单
     */
    public function set_order_from_jiesuan(){
//        var_dump(I("post."));exit;
        $orderid = I("post.orderid");   //订单id
        $cdkeyid = I("post.cdkey");     //优惠券id
        $money = $this->model->where(["orderid"=>$orderid])->getField("money"); //订单价格
        $cdkey = D("cdkey")->alias("a")
            ->where(["a.id"=>$cdkeyid])
            ->field("a.id,b.type,b.facevalue,b.condition")
            ->join("left join coupon b on a.cid=b.id")
            ->order("b.id desc")
            ->find();
        if(empty($cdkey)){
            $m = $money;
        }
        switch ($cdkey["type"]){//$cdkey['']
            case 1:
                if($cdkey['facevalue'] < $money){       //实际消费大于优惠金额
                    $m = $money - $cdkey['facevalue'];
                    $order['discount'] = $cdkey['facevalue'];
                }else{                                              //实际消费不大于优惠金额（全额抵消）
                    $m = 0.01;
                    $order['discount'] = $money-$m;
                }
                break;
            case 2:
                if($cdkey['condition'] < $money){       //满足优惠条件
                    if($cdkey['facevalue'] < $money){   //实际消费大于优惠金额
                        $m = $money - $cdkey['facevalue'];
                        $order['discount'] = $cdkey['facevalue'];
                    }else{                     //实际消费不大于优惠金额（全额抵消）
                        $m = 0.01;
                        $order['discount'] = $money-$m;
                    }
                }else{                         //不满足优惠条件
                    $m = $money;
                }
                break;
        }
        $order['uniqueid'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $order['money'] = $m;
        $snopjson = M("order_commodity_snop")->where(["orderid"=>$orderid])->getField("snopjson");
        $snopjson = json_decode($snopjson,true);
        $title = $snopjson['title'];
//        var_dump($m);exit;
        $order['commercial'] = A('weixin')->createorder($title,$order['uniqueid'],$order['money']);
        if($order['commercial'] == ""){
            retJson("404","微信下单失败！");
        }
        $money = $this->model->where(["orderid"=>$orderid])->save($order);
        $cdkey = D("cdkey")->where(["id"=>$cdkeyid])->save(array("orderid"=>$orderid));
        $config = A('weixin')->zfjs($order['commercial']);
        echo $config;
    }

    /**
     * 开发者：huangwei
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
     * 开发者：huangwei
     * 方法功能：申请退款接口，状态为20可申请
     */
    public function refund(){
        $model = D('order_refunds');
        $data = I('get.');
        $add['orderid'] = $data['id'];
        $add['shopid'] = $this->shopid;
        $status = $this->model->where($add)->field('order_state,type')->find();

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
     * 开发者：huangwei
     * 方法功能：用户确认收货操作,状态为30可操作。确认收货后将商品可获得积分返给用户
     */
    public function Goods_receipt(){
        $data = I('get.');
        $add['orderid'] = $data['id'];
        $add['shopid'] = $this->shopid;
        $order = $this->model->where($add)->find();
        if($order['order_state'] != "30" || $order['return_status'] != "0"){
            retJson("404","订单状态异常！");
        }

        $this->model->startTrans();
        $save['order_state'] = 50;
        $save['endtime'] = date("Y-m-d H:i:s");
        if($this->model->where($add)->save($save)){
            $snop = M('order_commodity_snop')->where(array('orderid'=>$data['id']))->field('snopjson,snopid,money,nums')->select();//获取商品列表
//            $user = D('user')->get_level($order['uid']);
            $integral = 0;//默认积分0

            $my_notice = D('order_commodity_snop')->cale2($order['orderid'],$order['uid']);  //计算有哪些用户需要微信通知的
//            file_put_contents("a.txt",json_encode($my_notice));
            foreach ($my_notice as $k1 => $v1){//添加分成记录
                if($v1['money'] != 0){
                    $add2['uid'] = $v1['id'];
                    $add2['shopid'] = $order['shopid'];
                    $add2['orderid'] = $order['orderid'];
                    $add2['level'] = $k1+1;
                    $add2['fromuid'] = $order['uid'];
                    $add2['money'] = $v1['money'];
                    if(!D('dividedinto')->add($add2)){//增加用户推广金额
                        $this->model->rollback();
                        retJson("404","操作失败1");
                    }
                    if(!M('user')->where(array('id'=>$v1['id']))->setInc('money',$v1['money'])){
                        $this->model->rollback();
                        retJson("404","操作失败2");
                    }
                }
            }

            foreach ($snop as $k => $v){
                $snop[$k]['snopjson'] = json_decode($v['snopjson'],true);
                if($snop[$k]['snopjson']['type'] != 2){
                    $integral = $integral + $snop[$k]['snopjson']['integral']*$v['money']*$v['nums']*0.01;//计算该订单总积分值
                    //判断是否积分商品,非积分商品执行下面的
                    $add['shopid'] = $this->shopid;
                    $add['uid'] = $this->uid;
                    $add['snopid'] = $v['snopid'];
                    $add['integral'] = round($snop[$k]['snopjson']['integral']*$v['money']*$v['nums']*0.01);
                    if($add['integral']>0){
                        if(!M('integral')->add($add)){
                            $this->model->rollback();
                            retJson("404","操作失败2");
                        }
                    }
                }
            }

            if(!$this->model->where(array('orderid'=>$order['orderid']))->save(array('is_fencheng'=>2))){
                $this->model->rollback();
                retJson("404","操作失败3");
            }

            if($integral != 0 && round($integral) > 0){
                //积分商品订单无需更新用户积分
                if(!D('user')->update_integral($order['uid'],round($integral),1)){
                    $this->model->rollback();
                    retJson("404","操作失败4");
                }//更新用户积分数据
            }

            $this->model->commit();//提交
            retJson("200","操作成功！");
        }else{
            $this->model->rollback();
        }
        retJson("404","操作失败5");
    }


    /**
     * 开发者：huangwei
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
//        var_dump($data);die;
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
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
            if($v != $order['snop'][$k]['snopjson']['commodityid'] && $order['snop'][$k]['is_refunds'] == 0){ //防止模拟提交表单
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
     * 开发者：huangwei
     * 方法功能：查看物流页面
     */
    public function wuliu(){
        $map['orderid'] = I('get.id',0);//传入订单ID
        $data = $this->model->where($map)->relation(array('snop','extend','return'))->find();

        foreach ($data['snop'] as $k => $v){
            $data['snop'][$k]['snopjson'] = json_decode($v['snopjson'],true);
        }

        if($data['return_status']  == "1"){
            $wuliuid = $data['return']['logistics'];
            $data['extend']['express'] = $data['return']['express'];
        }else{
            $wuliuid = $data['extend']['couriernumber'];
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
                $type = "tiantian";
                break;
        }

        $kuaidi = file_get_contents("http://www.kuaidi100.com/query?type=".$type."&postid=".$wuliuid."&id=1&valicode=&temp=0.9179467244822972");
        $kuaidi = json_decode($kuaidi,true);
        if($kuaidi['status'] != "200"){
            $this->assign('error',$kuaidi['message']);
        }

        $this->assign('data',$data);
        $this->assign('wulid',$wuliuid);
        $this->assign('kuaidi',json_encode($kuaidi['data']));
        $this->display();
    }



    /**
     * 开发者：huangwei
     * 方法功能：商品详情页直接下单
     */
    public function set_order_from_detail(){
        $post = I('post.');
        $id = $post['id'];//商品ID
        $sku = $post['sku'];
        $nub = $post['nub'];
        if($nub<=0){
            retJson("404","购买数量必须大于1件！"); 
        }

        $data = D('commodity')->get_goods($id,"",1);                //获取商品数据
        $sku_data = D('commodity')->get_attr($sku,$id);             //获取sku数据
        if($sku_data['stock'] == 0 || $nub > $sku_data['stock']){//判断库存是否充足
            retJson("404","库存不足！");
        }

        $address = A('address')->get_one();
        if($address == 0){
            $order['addressid'] = 0;
        }else{
            $order['addressid'] = $address['addressid'];
        }
        $carriage = D('carriage')->get_money($data['carriageid'],$address);//获取运费价格
        $user = D('user')->get_one($this->uid);

        if($data['type'] == 2){
            //积分商品，判断积分是否充足
            if($data['current']*$nub > session('user.integral')){
                retJson("404","积分余额不足！");
            }
            $order['money'] = $sku_data['attr_money'] * $nub;
            $order['type'] = 2;//积分商品
        }else{
            $redis = new Hredis();
            switch ($user['member']){
                case 0;
                    $zhekou = 1;
                    break;
                case 1:
                    $zhekou = 1;
                    break;
                case 2:
                    $zhekou = 1;
                    break;
                case 3:
                    $zhekou = 1;
                    break;
                case 4:
                    $zhekou = 0.95;
                    break;
            }
            $order['money'] = $sku_data['attr_money'] * $nub * $zhekou;       //订单总价 = 单价 * 数量 * 会员折扣？
            $order['type'] = 1;//普通商品
        }

        $order['uniqueid'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $order['shopid'] = $this->shopid;
        $order['uid'] = $this->uid;

        $order['carriage'] = $carriage;

        $order_money = $order['money']*1+$carriage*1;

//        $order['commercial'] = A('weixin')->createorder($data['title'],$order['uniqueid'],0.01);//生成微信支付订单,这里是金额
//        if($order['commercial'] == ""){
//            retJson("404","微信下单失败！");
//        }

        $orderid = $this->model->add($order);//新增订单

        $snop['orderid'] = $orderid;
        $snop['snopjson'] = json_encode($data);
        if($data['type'] == 2){
            $snop['money'] = $sku_data['attr_money'] * $nub;
        }else{
            $snop['money'] = $sku_data['attr_money']*$zhekou;
        }

        $snop['nums'] = $nub;
        $snop['attr'] = $sku;
        $snop['skuid'] = $sku_data['bianma'];
//        $snop['url'] = session('tuijian') ? session('tuijian') : 0;

        if(M('order_commodity_snop')->add($snop)){
            retJson("200",$orderid);
        }
        retJson("404","下单失败！");
    }

    /**
     * 统一下单
     */
    public function xiadan(){
        $post = I('post.');
        $id = $post['id'];//订单ID

        $order = $this->model->where(array('orderid'=>$id))->find();//获取订单数据
        if($order['type'] == '2'){
//            $order_money = $order['carriage'];
            //积分商品需要支付 1分钱
            $order_money = 0.01;
        }else{
            $order_money = $order['money'] + $order['carriage'];
        }
//        retJson("404",$order_money);
//        $commercial = A('weixin')->createorder($post['title'],$order['uniqueid'],$order_money);//生成微信支付订单,这里是金额

        $commercial = A('weixin')->createorder($post['title'],$order['uniqueid'],$order_money);//生成微信支付订单,这里是金额

//        retJson("404",$commercial);
        if($commercial == ""){
            retJson("404","微信下单失败1！");
        }
        $config = A('weixin')->zfjs($commercial);

        if($this->model->where(array('orderid'=>$id))->setField('commercial',$commercial)){
            retJson("200",$config);
        }else{
            retJson("404","微信下单失败！");
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：从购物车下单
     */
    public function set_order_from_cart(){
        $post = I('post.');
        $map['uid'] = $this->uid;
        $map['shopid'] = $this->shopid;
        $map['cartid']  = array('in',$post['id']);

        $cart = M("cart")->where($map)->select();//获取购物车内商品数据

        $money = 0;//初始化订单价格为0
        foreach ($cart as $k => $v){
            $money = $money + $v['money']*$v['nubs'];
            $sku_data = D('commodity')->get_attr($v['sku'],$v['commodityid']);//获取sku数据,判断库存
            if($sku_data['stock'] < $v['nubs']){
                retJson("404","第".($k+1)."个商品库存不足");
            }
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

        $data = D('commodity')->get_goods($cart[0]['commodityid'],"",1);                //获取商品数据
        $carriage = D('carriage')->get_money($data['carriageid'],$address);             //获取运费价格
        $user = D('user')->get_one($this->uid);

        switch ($user['member']){
            case 0;
                $zhekou = 1;
                break;
            case 1:
                $zhekou = 1.01;
                break;
            case 2:
                $zhekou = 1.02;
                break;
            case 3:
                $zhekou = 1.03;
                break;
            case 4:
                $zhekou = 0.95;
                break;
        }


        $order['money'] = $money*$zhekou;       //订单总价 = 单价 * 数量* 会员折扣？
        $order['carriage'] = $carriage;

        $order_money = $money*$zhekou+$carriage;

//        $order['commercial'] = A('weixin')->createorder($data['title'],$order['uniqueid'],$order_money);//生成微信支付订单,这里是金额
//
//        if($order['commercial'] == ""){
//            retJson("404","微信下单失败！");
//        }

        $type = true;
        if($orderid = $this->model->add($order)){
            foreach ($cart as $k => $v){
                $snop['skuid'] = $v['skuid'];
                $data = D('commodity')->get_goods($v['commodityid'],"",1);
                $snop['snopjson'] = json_encode($data);
                $snop['orderid'] = $orderid;
                $snop['money'] = $cart[$k]['money']*$zhekou;
                $snop['nums'] = $cart[$k]['nubs'];
                $snop['attr'] = $cart[$k]['sku'];
                $snop['url'] = $cart[$k]['url'];
                M('order_commodity_snop')->add($snop);
            }
        }
        M("cart")->where($map)->delete();
        retJson("200",$orderid);
    }

    /**
     * 开发者 ： huangwei
     * 方法功能：修改备注
     */
    public function beizhu(){
        $post = I('post.');
        $this->model->where(array('orderid'=>$post['id']))->setField('beizhu',$post['beizhu']);
    }

}