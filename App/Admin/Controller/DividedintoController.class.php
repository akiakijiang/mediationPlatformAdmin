<?php
namespace Admin\Controller;
use Think\Controller;
class DividedintoController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('dividedinto');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：分成列表
     */
    public function lists(){
        $get = I('get.');

        if(!is_null($get['status'])){
            $map['status'] = $get['status'];
        }

        if($get['uid'] != ""){
            $map['uid'] = $get['uid'];
        }

        $start = $get['start'] ? $get['start'] : date('Y-m-01 H:i:s', strtotime(date("Y-m-d")));
        $end = $get['end'] ? $get['end'] : date('Y-m-d H:i:s', strtotime("$start +1 month -1 day -1seconds"));
        if($get['type'] != "2"){
            $map['time'] = array(array('GT',$start),array('lt',$end)) ;
        }


        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,10);
        $show       = $Page->show();
        $list = $this->model->where($map)->relation(true)->limit($Page->firstRow.','.$Page->listRows)->order('time desc')->select();
        $this->assign('page',$show);
        $this->assign('data',$list);
        $this->assign('time',array($start,$end));
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：待放款列表
     */
    public function lists2(){
        $get = I('get.');
        $map['status'] = "1";
        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,30);
        $show       = $Page->show();
        $list = $this->model->where($map)->relation('user')->limit($Page->firstRow.','.$Page->listRows)->field('uid,money,intoid')->select();

        $temp = array();
        foreach ($list as $k => $v){
            if(!in_array($v['uid'],$temp)){
                $temp[] = $v['uid'];
                $temparr[] = $v;
            }else{
                $t = array_search($v['uid'],$temp);
                $temparr[$t]['money'] = $temparr[$t]['money'] + $v['money'];
            }
        }

        $this->assign('page',$show);
        $this->assign('data',$temparr);
        $this->display();
    }


    /**
     * 开发者：huangwei
     * 方法功能：放款主方法
     */
    public function fangkuan(){
        $get = I('get.');

        if(!is_null($get['uid'])){
            //全部放款
            $map['uid'] = $get['uid'];
        }else{
            //部分放款
            $temp = explode(",",$get['id']);
            $map['intoid']  = array('in',$temp);
        }
        $map['status'] = "1";

        $data = $this->model->where($map)->field('uid,money,time')->select();

        if(count($data)<=0){
            retJson("404","非法数据源！");
        }

        $send['money'] = 0;
        foreach ($data as $k => $v){
            $send['money'] += $v['money'];
        }
        if($send['money'] < 1){
            retJson("404","放款失败，必须大于1元才能发红包！");
        }

        $send['openid'] = D('user')->uid_to_openid($data[0]['uid']);

        $ret = A('Home/weixin')->pay($send,$data[0]['uid'],"hb".date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8));//将钱打入用户账户
        if($ret != "200"){
            retjson("404",$ret);
        }
        $send['time'] = $data[0]['time'];

        A('Home/weixin')->send_message_money($send);


        if($this->model->where($map)->save(array('status'=>"2"))){
            retJson("200","放款成功！");
        }else{
            retJson("404","放款失败！");
        }
    }
}