<?php
namespace Home\Controller;
use Think\Controller;


class UserController extends PublicController
{

    public function __construct()
    {
        parent::__construct();
    }

    public function login()
    {
        if (IS_POST) {

            $data = I('post.');

            $phone = $data['phone'];
            $verify_code = $data['verifyCode'];

            if (!$phone || !$verify_code) {
                errReturn('501', '请上传手机号或者验证码');
            }


            $check_code = D("VerifyCode", "Logic")->checkVerifyCode($phone, $verify_code);

            if ($check_code['status'] != 200) {
                errReturn($check_code['status'], $check_code['info']);
            }

            $reg_login = D("User", "Logic")->userLogin($phone);

            if ($reg_login['status'] == 200) {
                $user_info = $reg_login['data'];
                session("user_info", $user_info);

                succReturn($user_info);
            }

            errReturn($reg_login['status'], $reg_login['info']);


        }

        errReturn('500', '非法请求');
    }

    public function history()
    {

    }

    public function logout()
    {

    }




}