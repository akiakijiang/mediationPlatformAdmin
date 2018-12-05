<?php
namespace Home\Model;
use Think\Model\RelationModel;
class OrderModel extends RelationModel {

    protected $redis;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_validate = array(

    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'snop' => array(
            'mapping_type' => self::HAS_MANY,
            'class_name'   => 'order_commodity_snop',
            'foreign_key'  => 'orderid',
        ),
        'address' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'address',
            'foreign_key'  => 'addressid',
        ),
        'extend' => array(
            'mapping_type' => self::HAS_ONE,
            'class_name'   => 'order_extend',
            'foreign_key'  => 'orderid',
            'mapping_fields' => 'express,couriernumber'
        ),
    );


}