<?php
namespace Admin\Controller;
use Think\Controller;
class PublicController extends Controller {

    public function __construct(){
        parent::__construct();

        $action = __ACTION__;//当前操作url地址


        if(empty(session('admin.id'))){//判断是否登录
            if(IS_AJAX){
                retJson("404","登录失效，请先登录后再操作！");
            }else{
                $this->error("请先登录后再操作！","/Admin/index/login");
            }
        }
        $other_action = array('handle',"lists2");//除这些方法外，都需要验证

        $map['gid'] = session('admin.group');
        $rule = M('admin_group')->where($map)->getField('rule');

        $temp_arr = explode(',',$rule);

        $map['identifying'] = $action;
        $rule_id = M('admin_rule')->where($map)->getField('id');

        if(session('admin.group') != "3"){
            if(is_null($rule_id) || !in_array($rule_id,$temp_arr)){
                if(!in_array(ACTION_NAME,$other_action)){
                    if(IS_AJAX){
                        retJson("404","您没有权限操作!");
                    }
                    $this->error("您没有权限操作！");
                }
            }
        }



    }

}