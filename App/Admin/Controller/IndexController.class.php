<?php
namespace Admin\Controller;
use Think\Controller;
class IndexController extends Controller {

    protected $model;

    public function _initialize(){
        $this->model = D('admin');
    }

    /**
     * 开发者：huangwei
     * 方法功能：后台默认跳转到登录页面
     */
    public function index(){
        redirect(U('index/login/'));
    }

    /**
     * 开发者：huangwei
     * 方法功能：登录页面
     */
    public function login(){
        if(!empty(session('admin.id'))){
            redirect(U('index/center/'));
        }
        $this->display();
    }

    /**
     * 登录主方法
     */
    public function postlogin(){
        header("Access-Control-Allow-Origin:*");
        $post = I('post.');
        if ($this->model->create($post)) {
            $map['account'] = $post['account'];
            $map['password'] = md5($post['password']);
            $res = $this->model->islogin($map);

            if($res == "-1"){
                $this->error("帐号密码错误!",C('SITE_PATH')."admin/index/login");
            }else{
                session('admin',$res);//登录成功，设置session
                redirect(C('SITE_PATH')."/admin/index/center");
            }
        }else{
            $this->error($this->model->getError(),C('SITE_PATH')."admin/index/login");
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：后台操作主界面
     */
    public function center(){
//        session('user',NULL);
        if(empty(session('admin.id'))){
            redirect(U('index/login/'));
        }
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：退出后台系统
     */
    public function logout(){
        $_SESSION = array();
        if(isset($_COOKIE[session_name()])){
            setcookie(session_name(),'',time()-1,'/');
        }
        session_destroy();
        redirect("/admin");
    }

    public function kefu(){
        $response=array(
            "code"=> 0,
            "msg" => "",
            "data"=>array(
                "mine"=>array(
                    "username"=>"小二",
                    "id"      => 999,
                    "status"  =>"online",
                    "sign"    => "小二,来壶炸酱面",
                    "avatar"  => "http://hcfl.sunday.so/Public/resource/images/timg.jpg",
                )
            )
        );
        $this->ajaxReturn($response);
    }
}