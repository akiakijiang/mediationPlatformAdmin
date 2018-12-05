<?php
namespace MiniApi\Controller;
use Think\Controller;

class UserController extends PublicController
{
    public function _initialize()
    {
        parent::_initialize();
    }

    public function login()
    {
        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $data = I("post.");


        //先检查验证码
        $phone  = $data['phone'];
        $verifyCode = $data['verifyCode'];

        $checkCode = D("VerifyCode", "Logic")->checkVerifyCode($phone, $verifyCode);

        if ($checkCode['status'] != 200) {
            errReturn($checkCode['status'], $checkCode['info']);
        }


        $res = D("User", "Logic")->login($data);

        if ($res['status']) {
            errReturn($res['status'], $res['info']);
        }

        succReturn($res['data']);
    }


    /**
     * 更改手机号
     */
    public function modifyPhone()
    {
        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $data = I("post.");

        $old_phone = $data['oldPhone'];

        $verifyCode = $data['verifyCode'];

        $new_phone = $data['newPhone'];

        if (!$old_phone || !$verifyCode || !$new_phone) {
            errReturn('500', '缺少必要参数');
        }

        $check_code = D("VerifyCode", "Logic")->checkVerifyCode($old_phone, $verifyCode);

        if ($check_code['status'] != 200) {
            errReturn($check_code['status'], $check_code['info']);
        }


        $modify_res = D("User", "Logic")->changeUserPhone($old_phone, $new_phone);

        if ($modify_res['status'] != 200) {
            errReturn($modify_res['status'], $modify_res['info']);
        }

        succReturn();
    }


    /**
     * 获取我的评论
     */
    public function getMyComments()
    {

        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $data = I("post.");

        $res = D("User", "Logic")->getMyComments($data);

        if ($res['status'] != 200) {
            errReturn($res['status'], $res['info']);
        }

        succReturn($res['data']);

    }



}