<?php
namespace Home\Model;
use Think\Model\RelationModel;
class OrderReturnGoodsModel extends RelationModel {

    protected $_validate = array(
        array('moeny','require','退款金额不能为空！'),
        array('content','require','退款说明不能为空！'),
    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'snop' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'order_commodity_snop',
            'foreign_key'  => 'snopid',
            //'mapping_fields' => 'money,nums'
        ),
    );


}