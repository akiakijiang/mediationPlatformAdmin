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

}