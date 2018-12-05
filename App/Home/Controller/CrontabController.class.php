<?php
/**
 * Created by PhpStorm.
 * User: baimifan-pc
 * Date: 2017/6/28
 * Time: 16:42
 */
namespace Home\Controller;
use EasyWeChat\Foundation\Application;
use Think\Controller;
class CrontabController{

    /**
     * 10分钟同步一次库存
     */

    public function c_number()
    {
        $data = D('commodity_sku')->field('commodityid,product_no')->select();
        $innumber = "";
        foreach ($data as $k=>$v) {
            if (!empty($v['product_no'])) {
                $bianma = $v['product_no'];
                $url = "http://tmcrm.times8.cn:6987/test/comditiddy.php?product_no=$bianma";

                $save[$k] = json_decode(file_get_contents($url), true);
                $s_data = $save[$k]['data'];
                foreach ($s_data as $k1 => $v1) {
                    $innumber[$v1[1]][$k1] = $v1[0];
                }
            }
        }


        $in = "";
        foreach($innumber as $k=>$v){
            foreach($v as $k1=>$v1){
                $in[$k] += $v1;
            }
        }

        //这里调取接口  得到返回的数据
        if(!empty($in)){
            foreach($in as $k=>$v){
                $a['stock'] = $v;
                D("Commodity_sku")->where(['product_no'=>$k])->save($a);
            }
        }
    }



    /**
     * 每隔一段时间同步一次 用户的验光信息
     */

    public function pj(){
        $phone  = D('User')->field('c_phone,id')->where("c_phone != ''")->select();

        foreach($phone as $k1=>$v1){
            $url = "http://tmcrm.times8.cn:6987/test/user.php?phone=".$v1['c_phone'];
            $user_data = json_decode(file_get_contents($url), true);
            if($user_data['msg']['code'] == 200){

                $data['integral'] = $user_data['jifen'][0][0];

                D('User')->where(['c_phone'=>$phone])->save($data);

                //同步配镜信息
                $glass = $user_data['yg'][0];

                if(!empty($data)){
                    if(!empty(D('UserOptometry')->where(['user_id'=>$v1['id']])->find())){
                        D('UserOptometry')->where(['user_id'=>$v1['id']])->delete();
                    }

                    foreach($user_data['yg'] as $k=>$v){
                        if($v != FALSE){
                            $op_data['user_id']                 = $v1['id'];
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
        }
    }

}