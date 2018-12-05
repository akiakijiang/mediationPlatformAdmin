<?php
namespace Home\Model;
use Think\Model\RelationModel;
class CartModel extends RelationModel {

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
        'goods' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'commodity',
            'foreign_key'  => 'commodityid',
            'mapping_fields' => 'title,thumbnail'
        ),
    );


}