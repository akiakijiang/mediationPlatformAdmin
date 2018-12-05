<?php
namespace Admin\Controller;
use Think\Controller;
class UserController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('User');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：会员列表
     */
    public function lists(){
        $get = I('get.');
        if($get['type'] == "1"){
            $map['nickname'] = array('like','%'.$get['keyword'].'%');
        }elseif ($get['type'] =="2"){
            $map['id'] = array('eq',$get['keyword']);
        }elseif ($get['type'] =="3"){
            $map['c_phone'] = array('eq',$get['keyword']);
        }

        $map['shopid'] = $this->shopid;
        $count      = $this->model->where($map)->count();
        $Page       = new \Think\Page($count,15);
        $show       = $Page->show();
        $list = $this->model->where($map)->limit($Page->firstRow.','.$Page->listRows)->order('id desc')->select();
        $this->assign('page',$show);
        $this->assign('data',json_encode($list));
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除会员
     */
    public function del(){
        $id = I('get.id',0);
        $type = I('get.type');
        $map[$this->pk] = $id;
        if($type == 1){
            $save['is_delete'] = 2;
        }elseif ($type == 2){
            $save['is_delete'] = 1;
        }

        if($this->model->where($map)->save($save)){
            retJson("200","删除成功！");
        }
        retJson("404","删除失败!");
    }

    /**
     * 开发者：huangwei
     * 方法功能：查看分销层级关系
     */
    public function fenxiao(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $user = $this->model->where($map)->field('first,second,three')->find();

        $id_arr  = array_values($user);

        foreach ($id_arr as $k => $v){
            if($v == "0"){
                $shang[$k] = 0;
            }else{
                $shang[$k] = $this->model->where(array('id'=>$v))->field('nickname,id,img')->find();//获取上级推荐人信息
            }
        }

        $map3['uid'] = $id;
        $data = D('dividedinto')->where($map3)->relation(true)->select();//获取所有推广记录
        $first = $second = $three = [];
        foreach ($data as $k => $v){
            if($v['level'] == "1"){
                $first[] = $v;
            }elseif ($v['level'] == "2"){
                $second[] = $v;
            }elseif ($v['level'] == "3"){
                $three[] = $v;
            }
        }

        $first = $this->money_add($first);
        $second = $this->money_add($second);
        $three = $this->money_add($three);

        $this->assign('first',$first);
        $this->assign('second',$second);
        $this->assign('three',$three);
        $this->assign('shang',$shang);
        $this->display();
    }

    private function money_add($array){
        $item=array();
        foreach($array as $k=>$v){
            if(!isset($item[$v['fromuid']])){
                $item[$v['fromuid']] = $v;
            }else{
                $item[$v['fromuid']]['money']+=$v['money'];
            }
        }
        return array_values($item);
    }


    public function jifen(){
        $id = I('get.id');
        // 查询现有积分
        $jifen = $this->model->where(['id'=>$id])->field('integral')->find();

        $this->assign('jifen',$jifen['integral']);
        $this->assign('id',$id);
        $this->display();
    }


    public function jifen_save(){
        $id     = I('post.id');
        $type   = I('post.type');
        $jifen  = I('post.jifen');
        if($type == 1){
            //减少积分
            $s = $this->model->where(['id'=>$id])->setDec("integral",$jifen);
        }else{
            //增加积分
            $s = $this->model->where(['id'=>$id])->setInc("integral",$jifen);;
        }
        if($s){
          retJson('200',"修改成功");
        }
    }


    public function demo(){
        $data = mssql_connect('202.75.212.180:1533','bmf','baimifan');


//        echo 1;die;
//        echo "<pre>";
        var_dump($data);
    }
}