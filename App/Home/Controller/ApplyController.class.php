<?php
namespace Home\Controller;
use Think\Controller;
class ApplyController extends Controller {

    protected $uid;//用户ID
    protected $model;
    protected $pk;

    public function _initialize(){
        $this->uid = session('user.id');
        $this->model = D('suggest');
        $this->pk = $this->model->getpk();
    }

    /**
     * 投诉建议页面
     */
    public function index(){
        $this->display();
    }

    /**
     * 提交私人定制建议方法
     */
    public function appdo(){
        if(IS_POST){
            $data = I('post.');
            if ($this->model->create($data)) {
                $this->model->uid = $this->uid;
                if ($this->model->add() !== false) {
                    retJson("200","添加成功！");
                }else {
                    retJson("404","添加失败！");
                }
            }else{
                retJson("404",$this->model->getError());
            }
        }
    }
}