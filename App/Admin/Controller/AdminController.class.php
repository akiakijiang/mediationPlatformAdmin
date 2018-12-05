<?php
namespace Admin\Controller;
use Think\Controller;
class AdminController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Admin');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：当前店铺所有管理员帐号列表
     */
    public function lists(){
        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,10);
        $show       = $Page->show();
        $list = $this->model->where($map)->relation(true)->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('page',$show);
        $this->assign('data',json_encode($list));
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：删除指定管理员
     */
    public function del(){
        $map[$this->pk] = I('get.id',0);
        $data = $this->model->where($map)->find();
        if($data['id'] == session('admin.id')){
            retjson("404","不能删除自己的帐号！");
        }

        if($this->model->where($map)->delete()){
            retjson("200","删除成功！");
        }else{
            retjson("404","删除失败！");
        }
    }

    /**
     * 添加管理员界面
     */
    public function add(){
        $group = D('admin_group')->get_all();
        $this->assign('group',$group);
        $this->display();
    }

    /**
     * 编辑管理员界面
     */
    public function edit(){
        $map[$this->pk] = I('get.id',0);
        $data = $this->model->where($map)->find();
        $group = D('admin_group')->get_all();

        $this->assign('data',$data);
        $this->assign('group',$group);
        $this->display('add');
    }

    /**
     * 开发者：akiaki
     * 方法功能：添加编辑管理员帐号主方法
     */
    public function handle(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            $this->model->password = md5($data['password']);
            if(!$data['id']){
                if ($this->model->add() !== false) {
                    retJson("200","添加成功！");
                }else {
                    retJson("404","添加失败！");
                }
            }else{
                if ($this->model->save() !== false) {
                    retJson("200","修改成功！");
                }else {
                    retJson("404","修改失败！");
                }
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }

}