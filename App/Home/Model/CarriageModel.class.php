<?php
namespace Home\Model;
use Think\Model\RelationModel;
class CarriageModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'extend' => array(
            'mapping_type' => self::HAS_MANY,
            'class_name'   => 'carriage_extend',
            'foreign_key'  => 'carriageid',
        ),
    );

    /**
     * 开发者：akiaki
     * 方法功能：获取运费价格
     * @param $id 运费模版ID
     * @param $address 用户收货地址
     */
    public function get_money($id,$address){
        $map['carriageid'] = $id;
        $data = $this->where($map)->relation(true)->find();
        if($address == "0"){
            return $data['price'];
        }else{
            foreach ($data['extend'] as $k => $v){
                if($v['takeprovince'] == $address['province']){
                    return $v['price'];
                }
            }
            return $data['price'];
        }
    }

}