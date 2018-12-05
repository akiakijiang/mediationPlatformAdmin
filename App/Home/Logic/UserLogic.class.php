<?php
namespace Home\Logic;

use Think\Model;


class UserLogic extends Model
{
    protected $defaultAvatar = "";
    protected $nickNamePrefix = "qmstar";
    protected $defaultMemberId = "130000000";


    public function userLogin($phone)
    {

        //判断是否有注册过
        $user_info = D('User')->where(['phone' => $phone])->find();
        if ($user_info) {
            $data['uid']        = $user_info['uid'];
            $data['member_id']  = $user_info['member_id'];
            $data['avatar']     = $user_info['avatar'];
            $data['nick_name']  = base64_decode($user_info['nick_name']);
        } else {
            $insert_data['phone']       = $phone;
            $insert_data['nick_name']   = base64_encode($this->getDefaultNickName($phone));
            $insert_data['avatar']      = $this->defaultAvatar;
            $insert_res = D("User")->data($insert_data)->add();
            if ($insert_res === false) {
                return ['status' => 500, 'info' => '注册失败', 'data' => []];
            }

            $member_id = $this->generateMemID($insert_res);
            D("User")->where(['phone' => $phone])->data(['member_id' => $member_id])->save();
            $data['uid'] = $insert_res;
            $data['member_id'] = $member_id;
            $data['avatar']    = $insert_data['avatar'];
            $data['nick_name'] = base64_decode($insert_data['nick_name']);
        }

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }

    //生成默认的昵称
    protected function getDefaultNickName($phone)
    {
        $str = substr($phone,-4);
        $default_name = $this->nickNamePrefix . $str;
        return $default_name;
    }

    //生成会员ID
    protected function generateMemID($uid)
    {
        $date = date("Ymd", time());
        $member_id = (int)$this->defaultMemberId  +  $uid;
        return $member_id;
    }



    /**
     * 看了还看
     */
    public function historyAct()
    {

    }



}