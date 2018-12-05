<?php
namespace Admin\Controller;
use Think\Controller;
class CarouselController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Carousel');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：所属店铺轮播列表
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
     * 方法功能：添加广告的页面
     */
    public function add(){
        $extend = A('CarouselExtend')->get_all();
        $this->assign('extend',$extend);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：添加修改广告轮播主方法
     */
    public function handle(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            if(!$data['carouselid']){
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
     * 方法功能：删除指定广告轮播
     */
    public function del(){
        $map[$this->pk] = I('get.id',0);
        $carriageid = I('get.id',0);
        if(M("carriage_extend")->where(['carriageid'=>$carriageid])->delete()!==false){
            if($this->model->where($map)->delete()){
                retJson("200","删除成功！");
            }else{
                retJson("404","删除失败!");
            }
        }else{
            retJson("404","删除失败!");
        }

    }

    /**
     * 开发者：akiaki
     * 方法功能：编辑指定广告轮播
     */
    public function edit(){
        $map[$this->pk] = I('get.id',0);
        $data = $this->model->where($map)->find();

        $extend = A('CarouselExtend')->get_all();
        $this->assign('extend',$extend);
        $this->assign('data',$data);
        $this->display('add');
    }

}