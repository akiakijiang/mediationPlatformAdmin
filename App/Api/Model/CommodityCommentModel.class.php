<?php
namespace Home\Model;
use Think\Model\RelationModel;
class CommodityCommentModel extends RelationModel {

    protected $redis;
    protected $shopid;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_link = array(
        'user' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'user',
            'foreign_key'  => 'uid',
            'mapping_fields' => 'nickname,img'
        ),
    );

}