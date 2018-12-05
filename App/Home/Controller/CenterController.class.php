<?php
namespace Home\Controller;
use Config\Db;
use Think\Controller;
class CenterController extends Controller {
    public function index(){

        $data = D('user')->get_one(session('user.id'));

        $this->assign('data',$data);
        $this->assign('user_id',session('user.id'));
        $this->display();
    }


   public function c_phone(){
        $data = D('user')->where(['id'=>I('post.user_id')])->getField('c_phone');
        if(empty($data)){
            $msg['code'] = 404;
            $msg['msg']  = "暂未绑定手机号";
        }else{
            $msg['code'] = 200;
            $msg['msg']  = "已绑定手机号";
        }

        die(json_encode($msg));
    }


    public function phone(){
        $this->display();
    }


    public function c_phone_save(){
        $c_phone            = I('post.c_phone');
        //同步用户积分信息   后期修改
        $url = "http://tmcrm.times8.cn:6987/test/user.php?phone=$c_phone";
        $user_data = json_decode(file_get_contents($url), true);




        if($user_data['msg']['code'] == 200){

            //ERP积分
//            $data['integral'] = $user_data['jifen'][0][0];
            $erp_jifen = $user_data['jifen'][0][0];
            //微商城积分
            $wei_jifen = D('User')->where(['c_phone'=>$c_phone])->getField('integral');

            $data['integral'] = (int)$wei_jifen + (int)$erp_jifen;

            D('User')->where(['c_phone'=>$c_phone])->save($data);

                //同步配镜信息
           $glass = $user_data['yg'][0];

            if(!empty($data)){
                foreach($user_data['yg'] as $k=>$v){
                    if($v != FALSE){
                        $op_data['user_id']                 = session('user.id');
                        $op_data['c_code']                  = $v['c_code'];
                        $op_data['c_clientcode']            = $v['c_clientcode'];
                        $op_data['c_lball']                 = $v['c_lball'];
                        $op_data['c_rball']                 = $v['c_rball'];
                        $op_data['c_lpole']                 = $v['c_lpole'];
                        $op_data['c_rpole']                 = $v['c_rpole'];
                        $op_data['c_laxes']                 = $v['c_laxes'];
                        $op_data['c_raxes']                 = $v['c_raxes'];
                        $op_data['c_lspace']                = $v['c_lspace'];
                        $op_data['c_lspace2']               = $v['c_lspace2'];
                        $op_data['c_rspace']                = $v['c_rspace'];
                        $op_data['c_rspace2']               = $v['c_rspace2'];
                        $op_data['c_lhspace']               = $v['c_lhspace'];
                        $op_data['c_rhspace']               = $v['c_rhspace'];
                        $op_data['c_lcheck']                = $v['c_lcheck'];
                        $op_data['c_rcheck']                = $v['c_rcheck'];
                        $op_data['c_lsign']                 = $v['c_lsign'];
                        $op_data['c_rsign']                 = $v['c_rsign'];
                        $op_data['c_ladd']                  = $v['c_ladd'];
                        $op_data['c_radd']                  = $v['c_radd'];
                        $op_data['c_llight']                = $v['c_llight'];
                        $op_data['c_rlight']                = $v['c_rlight'];
                        $op_data['c_lfoot']                 = $v['c_lfoot'];
                        $op_data['c_rfoot']                 = $v['c_rfoot'];
                        $op_data['c_lcurvature']            = $v['c_lcurvature'];
                        $op_data['c_rcurvature']            = $v['c_rcurvature'];
                        $op_data['c_date']                  = $v['c_date'];
                        $op_data['c_empcode']               = $v['c_empcode'];
                        $op_data['c_empname']               = $v['c_empname'];
                        $op_data['c_space2']                = $v['c_space2'];
                        D('UserOptometry')->add($op_data);
                    }
                }
            }
        }

        $data['c_phone']    = $c_phone;
        $s = D('user')->where(['id'=>session('user.id')])->save($data);

        if($s){
            $msg['code'] = 200;
        }
        die(json_encode($msg));
    }






    /**
     * @param $c_phone 用户手机号码
     * 查找对应的用户积分信息
     *
     */

    public function user_tb($c_phone){
        if(!empty($c_phone)){
            //连接信息
            $con = mssql_connect();
            if(!$con || !mssql_select_db('dbo',$con)){
                $msg['code'] = 404;
                $msg['msg']  = "连接ERP数据库失败";
                $data = array();
            }

            $jifen = mssql_query("SELECT c_ipoint,c_clientcode FROM client_list WHERE c_phone1 = $c_phone");

            if(mssql_num_rows($jifen)<=0){
                $msg['code'] = 404;
                $msg['msg']  = "未找到对应的数据";
                $data = array();
            }

            $msg['code'] = 200;
            $msg['msg']  = "查找数据数据成功";
            $data = $jifen;
        }else{
            $msg['code'] = 404;
            $msg['msg']  = "请传递正确的手机号";
            $data = array();
        }

       $j = [
           'msg'=>$msg,
           'data'=>$data
       ];

       return json_encode($j);
    }



    public function user_pj($c_phone){
        if(empty($c_phone)){
            $msg['code'] = 404;
            $msg['msg']  = "请传递正确的手机号";
            $data = array();
        }

        $con = mssql_connect();
        if(!$con || !mssql_select_db('dbo',$con)){
            $msg['code'] = 404;
            $msg['msg']  = "连接ERP数据库失败";
            $data = array();
        }

        $jifen = mssql_query("SELECT c_ipoint,c_clientcode FROM client_list WHERE c_phone1 = $c_phone");

        if(mssql_num_rows($jifen)<=0){
            $msg['code'] = 404;
            $msg['msg']  = "未找到对应的数据";
            $data = array();
        }

        if(!empty($jifen['c_clientcode'])){
            $clientcode = $jifen['c_clientcode'];
            //同步配镜记录
            $glass = mssql_query("SELECT c_lspace,c_lspace2,c_rspace,c_rspace2,c_lhspace,c_rhspace,c_lcurvature,c_rcurvature,c_date,c_empname FROM client_optometry WHERE c_clientcode = $clientcode");
            if(!empty($glass)){
                $msg['code'] = 200;
                $msg['msg'] = "获取数据成功";
                $data = $glass;
            }else{
                $msg['code'] = 404;
                $msg['msg'] = "未找到对应的数据";
                $data = array();
            }
        }else{
            $msg['code'] = 404;
            $msg['msg'] = "未找到对应的数据";
            $data = array();
        }

        $j = [
            'msg'=>$msg,
            'data'=>$data
        ];

        return json_encode($j);
    }




    /**
     * 判断是否绑定手机,是否已领取会员卡
     *
     */

    public function get_hui()
    {
        $phone  = D('User')->where(['id' => session('user.id')])->getField('c_phone');
        $is_get = D('User')->where(['id' => session('user.id')])->getField('is_get');
        if (empty($phone)) {
            $data['code'] = 404;

        } else if($is_get == 1){
            $data['code'] = 403;

        }else {
           $data['code'] = 200;

        }
        die(json_encode($data));

    }
    /**
     * 配镜记录列表
     */

    public function glass(){
        $data = D('UserOptometry')->where(['user_id'=>session('user.id')])->select();
        foreach($data as $k=>$v){
            $data[$k]['name'] = D('User')->where(['id'=>$v['user_id']])->getField('nickname');
        }


        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 配镜记录详情
     */

    public function read(){
        $id     = I('get.id');
        $data   = D('UserOptometry')->where(['id'=>$id])->find();
        $data['name'] = D('User')->where(['id'=>$data['user_id']])->getField('nickname');

//        var_dump($data);die;
        $this->assign('data',$data);
        $this->display();
    }


    public function access(){


        $app_id = "wx2932f269a786744a";
        $secret = "37585bfed1f578089c96d2a7a8552ccb";
        $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $app_id . "&secret=" . $secret;
        $code_num = rand(100000000000, 999999999999);
        $access_token = json_decode(file_get_contents($url), true);
        $access_token = $access_token['access_token'];
        $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=".$access_token."&type=wx_card";

        $ticket     = json_decode(file_get_contents($url), true);
        $time       = time();
        $signature  = sha1("135697".$time.$ticket['ticket']."pGklKuPXG80csOVu0m5qr1P9nhJQ");
        $data['time'] = $time;
        $data['signature'] = $signature;
         die(json_encode($data));
    }
}