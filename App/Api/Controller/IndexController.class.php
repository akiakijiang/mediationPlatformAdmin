<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {

    protected $uid;

    public function  _initialize(){
        $this->uid = session('user.id');
    }

    public function index(){
        session('shopid',1);//固定网站入口页
        //session('user',M('user')->where(array('id'=>"15"))->find());//电脑模拟登录
    
        $shopid = session('shopid');

        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $get = I('get.');
        //判断是否存在分享
        if(!is_null($get['fromto'])){
            session('tuijian',$get['fromto']);//下单的时候根据该值判断分成情况
            $from = explode("|",base64_decode($get['fromto']));
            if(count($from)== 3){
                //对数组进行删除第一个，增加当前用户ID
                unset($from[0]);
            }
            array_push($from,$this->uid);
        }else{
            //干净的页面无分享
            $from = array(0,0,$this->uid);
        }

        $url = "http://shop.sunday.so/Home/index/index?fromto=".base64_encode(implode("|",$from));//生成分享url

        $map['shopid'] = $shopid;
        $map['type'] = 1;
        $map['status'] = 1;
        $data = D('commodity')->where($map)->limit(($page-1)*$size,$size)->order('commodityid desc')->select();
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }

        $carousel = D('Admin/carousel')->get_all($shopid);
        $classify = D('Admin/classify')->get_index_class($shopid);//获取分类，缓存120秒
        $js = A('weixin')->getjs();//获取微信的分享
        $jsconfig = $js->config(array('onMenuShareAppMessage','onMenuShareTimeline', 'onMenuShareWeibo','getLocation'), false);

        $this->assign('data',$data);
        $this->assign('jssdk',$jsconfig);
        $this->assign('url',$url);
        $this->assign('classify',$classify);
        $this->assign('carousel',$carousel);
        $this->display();
    }
}