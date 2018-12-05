<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class AdminModel extends RelationModel {

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
        'role' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'admin_group',
            'foreign_key'  => 'group',
            'mapping_fields' => 'title'
        ),
    );


    /**
     * 开发者：huangwei
     * 方法功能：  判断登录用户是否存在
     * @param $map
     *
     * @return int|mixed   存在返回用户数据，不存在返回-1
     */
    public function islogin($map){
        $result = $this->where($map)->find();
        if(!$result){
            return -1;
        }else{
            return $result;
        }
    }

}