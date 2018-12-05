<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class AdminGroupModel extends RelationModel {

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

    /**
     * 开发者：huangwei
     * 方法功能：获取当前店铺下所有管理员角色
     */
    public function get_all(){
        $map['shopid'] = session('admin.shopid');
        return $this->where($map)->select();
    }


}