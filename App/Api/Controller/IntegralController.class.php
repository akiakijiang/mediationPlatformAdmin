<?php
namespace Api\Controller;
use Think\Controller;
class IntegralController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;
    static public $treeList = array();

    public function  _initialize(){
        $this->shopid = "1";
        $this->uid = session('user.id');
        $this->model = D('integral');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：我的积分
     */
    public function index(){
        $map['uid'] = "15";
        $map['shopid'] = $this->shopid;

        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $data = $this->model->where($map)->relation(true)->limit(($page-1)*$size,$size)->select();
        D('user')->get_integral($this->uid);//获取用户积分，更新session

        foreach ($data as $k => $v){
            $data[$k]['snop'] = json_decode($v['snop']['snopjson'],true);
        }

        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(($data));
            }else{
                $this->ajaxReturn("0");
            }
        }
    }

}