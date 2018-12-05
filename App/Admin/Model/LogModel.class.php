<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class LogModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'admin' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'admin',
            'foreign_key'  => 'uid',
            'mapping_fields' => 'name'
        ),
    );

    /**
     * 开发者：huangwei
     * 方法功能：写入一条日志记录
     */
    public function set_one($text){
        $add['shopid'] = session('admin.shopid');
        $add['uid'] = session('admin.id');
        $add['content'] = $text;
        $add['ip'] = get_client_ip();
        if($this->add($add)){
            return true;
        }else{
            return false;
        }
    }

}