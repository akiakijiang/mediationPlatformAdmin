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

}