<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class UserModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(
        
    );

    protected $_auto = array(

    );

    protected $_link = array(
        
    );

    /**
     * 开发者：huangwei
     * 方法功能：UID和opendi的转换
     */
    public function uid_to_openid($uid){
        return $this->where(array('id'=>$uid))->getField('openid');
    }

}