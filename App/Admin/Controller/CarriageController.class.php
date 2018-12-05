<?php
namespace Admin\Controller;
use Think\Controller;
class CarriageController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Carriage');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：所属商铺的运费模版
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
     * 方法功能：添加运费模版页面
     */
    public function add(){
        $province = D('province')->get_all();//获取所有省市区
        $this->assign('province',$province);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除运费模版
     */
    public function del(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        if(M('commodity')->where(array('carriageid'=>$id))->find()){
            retJson("404","该运费模版还有商品在使用中，不能删除！");
        }
        if($this->model->where($map)->delete()){
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败!");
        }
    }


    /**
     * 开发者：huangwei
     * 方法功能：添加修改运费模版主方法
     */
    public function handle(){
        $data = I('post.');
        if ($this->model->create($data)) {
            $this->model->shopid = $this->shopid;
            if(!$data['carriageid']){
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
     * 方法功能：编辑运费模版
     */
    public function edit(){
        $id = I('get.id',0);
        $province = D('province')->get_all();//获取所有省市区
        $map[$this->pk] = $id;
        $data = $this->model->where($map)->find();//获取该运费模版数据
        $extend = M('carriage_extend')->where(array('carriageid'=>$id))->select();

        foreach ($extend as $k => $v){
            foreach ($province as $k1 => $v1){
                if($v1['name'] == $v['takeprovince']){
                    $province[$k1]['is'] = true;
                    break;
                }
            }
        }

        $this->assign('data',$data);
        $this->assign('extend',json_encode($extend));
        $this->assign('province',$province);
        $this->display();
    }
}