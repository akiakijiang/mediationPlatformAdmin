<?php
namespace Home\Controller;
use Think\Cache\Driver\Hredis;
use Think\Controller;
class AddressController extends Controller {

    /**
     * hash  键值  sx:address:shopid:uid
     */

    protected $uid;
    protected $model;
    protected $shopid;
    protected $pk;

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('address');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：获取某一用户默认收货地址
     */
    public function get_one(){
        $map['uid'] = $this->uid;
        $map['is_default'] = "1";
        $key = C('REDIS_KEY').":address:".$this->shopid.":".$this->uid;
        $redis = new Hredis();
        if($redis->exists($key)){
            $data = $redis->hGetAll($key);
        }else{
            $data = $this->model->where($map)->find();
            if($data){
                $redis->hmset($key,$data);
                $redis->expire($key);
            }else{
                $data = 0;
            }
        }
        return $data;
    }

    /**
     * 开发者：huangwei
     * 方法功能：获取用户所有收货地址列表
     * @return array|int
     */
    public function get_all(){
        $map['uid'] = $this->uid;
//        $key = C('REDIS_KEY').":address:all:".$this->shopid.":".$this->uid;
        $data = $this->model->where($map)->select();
        return $data;
    }

    /**
     * 开发者：huangwei
     * 方法功能：新增用户收货地址
     */
    public function add(){
        $id = I('get.id');
        $data = I('post.');
        if ($this->model->create($data)) {
            if($this->model->where(array('uid'=>$this->uid))->count() <= 0){
                //判断是不是第一个
                $this->model->is_default = "1";
            }   
            if ($this->model->add() !== false) {
                retJson("200",json_encode($this->model->info));
            }else {
                retJson("404","修改失败！");
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：修改用户收货地址
     */
    public function edit(){
        $id = I('get.id');
        $data = I('post.');
        if ($this->model->create($data)) {
            $map[$this->pk] = $data['id'];
            if ($this->model->where($map)->save() !== false) {
                retJson("200",json_encode($data));
            }else {
                retJson("404","修改失败！");
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }

    /**
     * 更新订单运费价格
     * @param $id 订单ID
     * @param $addressid  收货地址ID
     */
    public function cale($id,$addressid){
        $order = M('order')->where(array('orderid'=>$id))->find();
        if($order['commercial'] != ''){
            retJson("404","已经下单过的订单无法修改地址！");
        }
        $address = M('address')->where(array('addressid'=>$addressid))->find();
        $snop = M('order_commodity_snop')->where(array('orderid'=>$id))->find();
        $snop['snopjson'] = json_decode($snop['snopjson'],true);
        $carriageid = $snop['snopjson']['carriageid'];

        $carriage = D('carriage')->get_money($carriageid,$address);//获取运费价格
        $save['carriage'] = $carriage;
        $save['addressid'] = $addressid;

        M('order')->where(array('orderid'=>$id))->save($save);
        $res["money"] = sprintf("%.2f", $order['money'] + number_format($carriage,2));
        $res["carriage_money"] = number_format($carriage,2);
        $res = json_encode($res);
//        retJson("200",sprintf("%.2f", $order['money'] + number_format($carriage,2)));
        retJson("200",$res);
    }

    /**
     * 开发者：huangwei
     * 方法功能：收货地址管理列表
     */
    public function lists()
    {
        $map['uid'] = $this->uid;
        $data = $this->model->where($map)->select();
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除收货地址
     */
    public function del(){
        $map[$this->pk] = I('get.id');
        if($this->model->where($map)->delete()){
            $redis = new Hredis();
            $key = C('REDIS_KEY').":address:".$this->shopid.":".$this->uid;
            $redis->del($key);
            $key = C('REDIS_KEY').":address:all:".$this->shopid.":".$this->uid;
            $redis->del($key);
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败！");
        }

    }

    /**
     * 开发者：huangwei
     * 方法功能：设置默认地址
     */
    public function set_default(){
        $this->model->startTrans();
        $map['uid'] = $this->uid;

        $res = $this->model->where($map)->setField('is_default','0');

        $map[$this->pk] = I('get.id');

        $res1 = $this->model->where($map)->setField('is_default','1');

        if($res >= 1 && $res1 >= 1){
            $this->model->commit();
            retJson("200","设置成功！");
        }else{
            $this->model->rollback();
            retJson("404","设置失败！");
        }
    }

}