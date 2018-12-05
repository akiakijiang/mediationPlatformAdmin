<?php
namespace Admin\Controller;
use Think\Controller;
class AdminGroupController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('AdminGroup');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：后台角色列表
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
     * 方法功能：删除自己店铺下的角色
     */
    public function del(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        if($id == 3){
            retjson("404","开发者角色无法删除！");
        }
        if($this->model->where($map)->delete()){
            retjson("200","删除成功！");
        }else{
            retjson("404","删除失败！");
        }
    }

    public function edit(){
        $admin = $this->model->find(I('get.id',0));//获取当前用户组数据
        $admin['rule'] = explode(",",$admin['rule']);

        $rule = M('admin_rule')->select();
        $cate = M('admin_rule_cat')->select();
        foreach ($rule as $k => $v){
            if(in_array($v['id'],$admin['rule'])){
                $rule[$k]['isselected'] = 1;
            }else{
                $rule[$k]['isselected'] = 0;
            }
        }

        $this->assign('rule',json_encode($rule,JSON_UNESCAPED_UNICODE));
        $this->assign('cat',json_encode($cate,JSON_UNESCAPED_UNICODE));
        $this->assign('admin',$admin);
        $this->display('add');
    }

    public function add(){
        $rule = M('admin_rule')->select();
        $cate = M('admin_rule_cat')->select();

        $this->assign('rule',json_encode($rule,JSON_UNESCAPED_UNICODE));
        $this->assign('cat',json_encode($cate,JSON_UNESCAPED_UNICODE));
        $this->display();
    }


    /**
     * 管理员账号添加修改住方法
     */
    public function handle(){
        $data = I('post.');
        if(!$data['gid']){//创建
            if ($this->model->create($data)) {
                $this->model->shopid = $this->shopid;
                if ($this->model->add() !== false) {
                    retJson("200","添加成功！");
                }else {
                    retJson("404","添加失败！");
                }
            }else{
                retJson("404",$this->model->getError());
            }
        }else{//保存
            if ($this->model->create($data)) {
                $this->model->shopid = $this->shopid;
                if ($this->model->save() !== false) {
                    retJson("200","修改成功！");
                }else {
                    retJson("404","修改失败！");
                }
            }else{
                retJson("404",$this->model->getError());
            }
        }
    }

}