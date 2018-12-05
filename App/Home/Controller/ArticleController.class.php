<?php
namespace Home\Controller;
use Think\Controller;
class ArticleController extends Controller {

    protected $shopid;

    public function  _initialize(){
        $this->shopid = session('shopid');
    }

    /**
     * 规则中心
     */
    public function guize(){
        $goumai = D('Admin/article')->get_article('goumai', $this->shopid);
        $fenxiao = D('Admin/article')->get_article('fenxiao', $this->shopid);
        $jifen = D('Admin/article')->get_article('jifen', $this->shopid);
        $huiyuan = D('Admin/article')->get_article('huiyuan', $this->shopid);
        $this->assign('data',array($goumai,$fenxiao,$jifen,$huiyuan));
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：引导页面
     */
    public function yindao(){
        $data = D('Admin/article')->get_article('yindao', $this->shopid);//获取文章
        $this->assign('data',$data);
        $this->display('jifen');
    }
}