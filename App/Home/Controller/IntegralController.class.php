<?php
namespace Home\Controller;
use Think\Controller;
class IntegralController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;
    static public $treeList = array();

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('integral');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：我的积分
     */
    public function index(){
        $map['uid'] = $this->uid;
        $map['shopid'] = $this->shopid;

        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $data = $this->model->where($map)->relation(true)->limit(($page-1)*$size,$size)->order('integralid desc')->select();
        $integra = D('user')->get_integral($this->uid);//获取用户积分，更新session

        foreach ($data as $k => $v){
            $data[$k]['snop'] = json_decode($v['snop']['snopjson'],true);
        }

        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }

        $this->assign('data',$data);
        $this->assign('integra',$integra);
        $this->display();
    }

}