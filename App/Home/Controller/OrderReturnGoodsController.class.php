<?php
namespace Home\Controller;
use Think\Controller;
class OrderReturnGoodsController extends Controller {

    /**
     * 退货控制器
     * @var
     */
    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;
    static public $treeList = array();

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('order_return_goods');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：商品退货申请
     */
    public function index(){
        $id = I('get.id',0);
        $map['snopid'] = $id;
        $map['uid'] = $this->uid;
        $data = D('order_commodity_snop')->where($map)->field('is_refunds,orderid,snopid')->relation(true)->find();
        //判断该商品是否有权限进行退货(订单状态是否为30，该商品快照退货状态是否为0)
        if($data['order']['order_state'] != 30){
            $this->assign('text',"订单当前状态无退货权限！");
            $this->display('Public/error');
            exit();
        }

        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：商品退货提交物流单号
     */
    public function wuliu(){
        $id = I('get.id',0);
        $map['snopid'] = $id;
        $data = $this->model->where($map)->relation('snop')->find();
        if($data['snop']['is_refunds'] != "2"){
            $this->assign('text',"切勿非法操作数据！");
            $this->display('Public/error');
            exit();
        }

        if(is_null($data)){
            $this->assign('text',"未找到数据，切勿非法操作数据！");
            $this->display('Public/error');
            exit();
        }
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：提交退货申请
     */
    public function handle(){
        $data = I('post.');

        $map['snopid'] = $data['snopid'];
        $map['uid'] = $this->uid;
        $snop = D('order_commodity_snop')->where($map)->field('is_refunds,orderid')->relation(true)->find();

        //判断该商品是否有权限进行退货(订单状态是否为30，该商品快照退货状态是否为0)
        if($snop['order']['order_state'] != 30 || $snop['is_refunds'] != 0 ){
            retJson("404","切勿非法操作数据！");
        }

        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            $this->model->uid = $this->uid;
            $this->model->snopid = $data['snopid'];
            $this->model->orderid = $snop['orderid'];
            $this->model->startTrans();
            if(!$data['id']){
                if ($this->model->add() !== false) {
                    if(D('order_commodity_snop')->where(array('snopid'=>$data['snopid']))->setField('is_refunds',1)){//更新为正在退货中
                        if(M('order')->where(array('orderid'=>$snop['orderid']))->setField('return_status',1) !== false){//只要申请退货，订单设置正在退货中
                            $this->model->commit();
                            retJson("200","添加成功！");
                        }
                    }
                }
            }
        }else{
            retJson("404",$this->model->getError());
        }
        $this->model->rollback();
        retJson("404","添加失败！");
    }

    /**
     * 开发者：huangwei
     * 方法功能：提交退货物流信息
     */
    public function save(){
        $data = I('post.');
        $save['express'] = $data['express'];
        $save['logistics'] = $data['logistics'];
        $save['status'] = 4;

        $map['shopid'] = $this->shopid;
        $map['uid'] = $this->uid;
        $map['snopid'] = $data['snopid'];
        $map['status'] = 2;//卖家同意退货才能执行该操作

        if($this->model->where($map)->save($save)){
            D('order_commodity_snop')->where(array('snopid'=>$data['snopid']))->setField('is_refunds',4);
            retJson("200","操作成功！");
        }else{
            retJson("404","操作失败！");
        }
    }

}