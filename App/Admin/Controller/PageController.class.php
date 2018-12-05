<?php
namespace Admin\Controller;
use Think\Controller;
class PageController extends Controller {

    protected $model;
    protected $pk;

    public function _initialize(){
        $this->model = D('custom_page');
        $this->pk = $this->model->getpk();
    }

    /**
     * 自定义页面方法
     */
    public function handle(){
        $post = I('post.');
        $map[$this->pk] = 1;
        $save['json'] = json_encode($post['data']);
        if($this->model->where($map)->save($save) !== false){
            retJson("200","保存成功！");
        }else{
            retJson("404","保存失败！");
        }
    }

}