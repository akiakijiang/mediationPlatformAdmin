<?php
namespace Home\Controller;
use Think\Controller;
class PublicController extends Controller {


    public function __construct()
    {
        parent::__construct();
    }


    /**
     * 开发者：huangwei
     * 方法功能：错误页面
     */
    public function error($text = ''){
        $this->assign('text',$text);
        $this->display();
    }


}