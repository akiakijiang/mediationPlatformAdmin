<?php
namespace Admin\Model;
use Think\Model;
class ShopModel extends Model {

    protected $_validate = array(
        array('account','require','帐号不能为空！'),
        array('password','require','密码不能为空！'),
        array('name','','帐号昵称已经存在！',0,'unique',4),
        array('account','','登录帐号已经存在！',0,'unique',4),
    );

    protected $_map = array(         

    );

    protected $_auto = array(
        array('password','md5',3,'function') ,
    );

    /**
     * 开发者：akiaki
     * 方法功能： 获取某用户数据
     * @param $id  用户ID
     *
     * @return mixed  返回用户数据
     */
    public function getOne($id){
        return $this->find($id);
    }

}