<?php
namespace Home\Model;
use Think\Model\RelationModel;
class OrderCommoditySnopModel extends RelationModel {

    protected $_validate = array(
        
    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'order' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'order',
            'foreign_key'  => 'orderid',
            'mapping_fields' => 'order_state,refund_state,type'
        ),
        'goods' => array(
            'mapping_type' => self::HAS_ONE,
            'class_name'   => 'order_return_goods',
            'foreign_key'  => 'snopid',
            //'mapping_fields' => 'order_state,refund_state'
        ),
    );

    /**
     * 开发者：akiaki
     * 方法功能：获取该商品是什么类型
     */
    public function get_type($snopid){
        $map['snopid'] = $snopid;
        $data = $this->where($map)->getField('snopjson');
        $data = json_decode($data,true);
        return $data['type'];
    }

    /**
     * 开发者：akiaki
     * 方法功能：计算收益
     * @param $orderid
     * @param $uid
     *
     * @return mixed
     */
    public function cale($orderid,$uid){
        $map['orderid'] = $orderid;
        $map['is_refunds'] = 0;
        $data = $this->where($map)->select();
        $one = $two = $three = 0;
        $level = D('Home/user')->get_level($uid);
        $nickname = M('user')->where(array('id'=>$uid))->getField('nickname');

        foreach ($data as $k => $v){
            $data[$k]['snopjson'] = json_decode($v['snopjson'],true);
            $one += ($v['money']*$v['nums']*$data[$k]['snopjson']['firstgraded']*0.01);
            $two += ($v['money']*$v['nums']*$data[$k]['snopjson']['secondgraded']*0.01);
            $three += ($v['money']*$v['nums']*$data[$k]['snopjson']['threegraded']*0.01);
        }

        $temp = array($one,$two,$three);
        foreach ($level as $k => $v){
            if($v != 0){
                $ret[$k]['money'] = $temp[$k];
                $ret[$k]['title'] = $data[0]['snopjson']['title'];
                $ret[$k]['openid'] = D('user')->uid_to_openid($v);
                $ret[$k]['id'] = $v;
                $ret[$k]['nickname'] = $nickname;
            }
        }

        return $ret;
    }

    public function cale2($orderid,$uid){
        $map['orderid'] = $orderid;
        $map['is_refunds'] = 0;
        $data = $this->where($map)->select();
        $one = $two = $three = 0;
        $level = D('Home/user')->get_level($uid);
        $nickname = M('user')->where(array('id'=>$uid))->getField('nickname');

        foreach ($data as $k => $v){
            $data[$k]['snopjson'] = json_decode($v['snopjson'],true);
            $one += ($v['money']*$v['nums']*$data[$k]['snopjson']['firstgraded']*0.01);
            $two += ($v['money']*$v['nums']*$data[$k]['snopjson']['secondgraded']*0.01);
            $three += ($v['money']*$v['nums']*$data[$k]['snopjson']['threegraded']*0.01);
        }

        $temp = array($one,$two,$three);

        $ret = array();
        foreach ($level as $k => $v){
            if($v != 0){
                $ret[$k]['money'] = $temp[$k];
                $ret[$k]['title'] = $data[0]['snopjson']['title'];
                $ret[$k]['openid'] = D('user')->uid_to_openid($v);
                $ret[$k]['id'] = $v;
                $ret[$k]['nickname'] = M('user')->where(array('id'=>$v))->getField('nickname');
            }
        }
        return $ret;
    }

}