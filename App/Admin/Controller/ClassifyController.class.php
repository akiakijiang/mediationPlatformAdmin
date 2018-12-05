<?php
namespace Admin\Controller;
use Think\Controller;
class ClassifyController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Classify');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：分类列表
     */
    public function lists(){
        $classify = $this->model->get_all($this->shopid);
        $this->assign('data',json_encode($classify));
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：添加编辑分类主方法
     */
    public function handle(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            if(!$data['classifyid']){
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
     * 开发者：akiaki
     * 方法功能：添加分类页面
     */
    public function add(){
        $classify = $this->model->get_all($this->shopid);
        $this->assign('classify',$classify);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：编辑分类页面
     */
    public function edit(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $data = $this->model->where($map)->find();

        $classify = $this->model->get_all($this->shopid);

        $this->assign('data',$data);
        $this->assign('classify',$classify);
        $this->display('add');
    }

    /**
     * 开发者：akiaki
     * 方法功能：删除分类主方法
     */
    public function del(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        if($this->model->where(array('pid'=>$id))->find()){
            retJson("404","请先删除下级分类！");
        }

        if($this->model->where($map)->delete()){
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败!");
        }
    }

}