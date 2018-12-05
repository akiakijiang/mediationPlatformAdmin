<?php
namespace Admin\Controller;
use Think\Controller;
class SpecificationsController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Specifications');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：规格列表
     */
    public function lists(){
        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,10);
        $show       = $Page->show();
        $list = $this->model->where($map)->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('page',$show);
        $this->assign('data',json_encode($list));
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：新增规格
     */
    public function add(){
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：添加修改规格主方法
     */
    public function handle(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            if(!$data['specificationsid']){
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

    /**
     * 开发者：huangwei
     * 方法功能：删除某规格
     */
    public function del(){
        $map[$this->pk] = I('get.id',0);
        if($this->model->where($map)->delete()){
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败!");
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：编辑某规格
     */
    public function edit(){
        $map[$this->pk] = I('get.id',0);
        $data = $this->model->where($map)->find();
        $this->assign('data',$data);
        $this->display('add');
    }
}