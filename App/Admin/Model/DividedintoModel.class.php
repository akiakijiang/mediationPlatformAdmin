<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class DividedintoModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(
        
    );

    protected $_auto = array(

    );

    protected $_link = array(
        'user' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'user',
            'foreign_key'  => 'uid',
            'mapping_fields' => 'nickname,id,img'
        ),
        'order' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'order',
            'foreign_key'  => 'orderid',
            'mapping_fields' => 'uniqueid'
        ),
        'from' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'user',
            'foreign_key'  => 'fromuid',
            'mapping_fields' => 'nickname,id,img'
        ),
    );

}