<?php
namespace Home\Controller;
use Think\Cache\Driver\Hredis;
use Think\Controller;
class CouponController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('Cdkey');
        $this->pk = $this->model->getPk();
    }

    /**
     *抵用券列表页
     */
    public function index(){
        $data = $this->model->get_coupon($this->uid);
        $this->assign('data',$data);
        $this->display();
    }

    /**
     *兑换抵用券页
     */
    public function conversion(){
        $couponid = I('get.couponid');

        $key=M('cdkey')->where(array('cid' => $couponid, 'is_issue' => 1, 'getuid' => $this->uid))->select();
        if(empty($key) && $couponid!==0){
            $cdkey=M('cdkey')->where(['cid'=>$couponid,'getuid'=>0])->getField('cdkey');
        }else{
            $cdkey="";
        }
//        if($couponid!==0){
//            $cdkey=M('cdkey')->where(['cid'=>$couponid,'getuid'=>0])->getField('cdkey');
//        }
//        dump($couponid);
//        exit;
        $this->assign('cdkey',$cdkey);
        $this->display();
    }

    public function handle(){
        if(IS_AJAX){
            $map['a.cdkey'] = I("post.cdkey");
            $map['a.getuid'] = 0;
            $data = $this->model->alias("a")
                ->where($map)
                ->field("a.id,b.endtime,a.cid")
                ->join("left join coupon b on a.cid=b.id")
                ->order("b.id desc")
                ->find();
            if(empty($data)){
                retJson("404","兑换码不存在或兑换码已被兑换！");
            }
            if(time()>=$data['endtime']){
                retJson("404","兑换码已过期，请联系客服！");
            }
            $check = $this->model->where(['cid'=>$data['cid']])->select();
           foreach($check as $k=>$v){
               if($v['getuid'] == $this->uid){
                   retJson('404','已兑换该抵用券');
               }
           }
            $save['getuid'] = $this->uid;
            $save["is_issue"] = 1;
            $where['id']=$data['id'];
            $up = $this->model->where($where)->save($save);
            if($up){
                retJson("200","兑换成功！");
            }else{
                retJson("404","兑换失败！");
            }
        }
        $this->display("conversion");
    }



}