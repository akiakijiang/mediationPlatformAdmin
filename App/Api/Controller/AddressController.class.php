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
     * 开发者：akiaki
     * 方法功能：获取某一用户默认收货地址
     */
    public function get_one(){
        $map['uid'] = $this->uid;
        $key = "sx:address:".$this->shopid.":".$this->uid;
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
     * 开发者：akiaki
     * 方法功能：新增用户收货地址
     */
    public function add(){
        $data = I('post.');
        if ($this->model->create($data)) {
            if ($this->model->add() !== false) {
                retJson("200",json_encode($this->model->info));
            }else {
                retJson("404","修改失败！");
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }


    public function edit(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $map[$this->pk] = $data['id'];
            if ($this->model->where($map)->save() !== false) {
                //dump($data);
                retJson("200",json_encode($data));
            }else {
                retJson("404","修改失败！");
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }


    /**
     * 开发者：akiaki
     * 方法功能：计算运费
     */
    public function cale(){
        //获取当前用户收货地址的省份
        $redis = new Hredis();
        $key = "sx:address:".$this->shopid.":".$this->uid;
        $province = $redis->hmget($key,array('province'));

        




        //$current_address = M('address')->where(array('id'=>$aid))->getField('province');
        //
        //$map['cid'] = $yid;//商品运费ID
        //$carriage = D('carriage_extend')->where($map)->relation(true)->field('takeprovince,price,cid')->select();//运费信息
        //if(!$carriage){
        //    return 0;
        //}
        //foreach ($carriage as $k => $v) {
        //    if($v['takeprovince'] == $current_address){
        //        return $v['price'];
        //    }
        //}
        //return $carriage[0]['carriage']['price'];//没有定义价格的采用默认的价格
    }

}