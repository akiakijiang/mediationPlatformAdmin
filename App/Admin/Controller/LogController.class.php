<?php
namespace Admin\Controller;
use Think\Controller;
class LogController extends PublicController {

    protected $model;
    protected $shopid;
    protected $uid;

    public function _initialize(){
        $this->model = D('Log');
        $this->shopid = session('admin.shopid');
        $this->uid = session('admin.id');
    }

    public function lists(){
        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,40);
        $show       = $Page->show();
        $list = $this->model->where($map)->limit($Page->firstRow.','.$Page->listRows)->order('time desc')->relation(true)->select();
        $this->assign('page',$show);
        $this->assign('data',json_encode($list));
        $this->display();
    }
}