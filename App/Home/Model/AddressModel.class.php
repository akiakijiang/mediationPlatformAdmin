<?php
namespace Home\Model;
use Think\Model;
class AddressModel extends Model {

    protected $redis;
    protected $shopid;
    public $info;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_validate = array(
        array('name','require','收货人不能为空！'),
        array('phone','require','联系电话不能为空！'),
        array('address','require','详细地址不能为空！'),
    );

    protected $_map = array(

    );

    protected $_auto = array(
        array('uid','setuid',3,'callback'),
        array('province','setprovince',3,'callback'),
        array('city','setcity',3,'callback'),
        array('district','setdistrict',3,'callback'),
    );

    protected function setuid(){
        return session('user.id');
    }

    protected function setprovince(){
        $temp = explode(" ",I('post.province'));
        return $temp[0];
    }

    protected function setcity(){
        $temp = explode(" ",I('post.province'));
        return $temp[1];
    }

    protected function setdistrict(){
        $temp = explode(" ",I('post.province'));
        if(count($temp) <3){
            return "";
        }else{
            return $temp[2];
        }
    }

    protected function _after_insert($data, $options){
        $this->info = $data;
        $map['orderid'] = I('post.orderid');
        M('order')->where($map)->setField('addressid',$data['addressid']);//更新订单中的收货地址
    }



}