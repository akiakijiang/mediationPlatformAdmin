<?php
namespace Admin\Controller;
use Think\Controller;
class CustomController extends PublicController {

    /**
     * 开发者：huangwei
     * 方法功能：自定义首页
     */
    public function index(){
        $data = M('custom_page')->find();
        $this->assign('data',$data['json']);
        $this->display();
    }
}