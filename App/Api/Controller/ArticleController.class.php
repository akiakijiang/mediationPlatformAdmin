<?php
namespace Api\Controller;
use Think\Controller;
class ArticleController extends Controller {

    protected $shopid;

    public function  _initialize(){
        $this->shopid = "1";
    }

    /**
     * 开发者：huangwei
     * 方法功能：积分规则页面
     */
    public function jifen(){
        $data = D('Admin/article')->get_article('jifen', $this->shopid);//获取文章
        $data['content'] = htmlspecialchars_decode($data['content']);
        $this->ajaxReturn($data);
    }

    /**
     * 开发者：huangwei
     * 方法功能：合作建议页面
     */
    public function hezuo(){
        $data = D('Admin/article')->get_article('hezuo', $this->shopid);//获取文章
        $data['content'] = htmlspecialchars_decode($data['content']);
        $this->ajaxReturn($data);
    }
}