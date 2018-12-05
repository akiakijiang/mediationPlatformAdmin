<?php
namespace Home\Model;
use Think\Model\RelationModel;
class IntegralModel extends RelationModel {

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
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'order_commodity_snop',
            'foreign_key'  => 'snopid',
        ),
    );


}