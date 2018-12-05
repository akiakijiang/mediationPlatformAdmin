<?php
namespace Home\Model;
use Think\Model\RelationModel;
class DividedintoModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(
        
    );

    protected $_auto = array(

    );

    protected $_link = array(
        'from' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'user',
            'foreign_key'  => 'fromuid',
            'mapping_fields' => 'nickname'
        ),
    );

    /**
     * 开发者：huangwei
     * 方法功能：获取指定用户所有返现红包记录
     */
    public function get_all(){
        $uid = session('user.id');
        $map['uid'] = $uid;
        $data = $this->where($map)->cache(C('REDIS_KEY').":redpack:".$uid,300)->select();
        return $data;
    }

}