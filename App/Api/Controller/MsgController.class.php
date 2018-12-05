<?php
namespace Api\Controller;

use Think\Controller;

class MsgController extends PublicController
{
    public function _initialize()
    {
        parent::_initialize(); //
    }

    /**
     * 发送验证码
     */
    public function sendCode()
    {
        if (IS_POST) {

            $post_data = I('post.');

            $phone = $post_data['phone'];

            if (!$phone) {
                errReturn('500', '请上传手机号');
            }

            //检查手机号是否合法
            if (!checkIsPhone($phone)) {
                errReturn('500', '输入的手机号不合法');
            }

            $res = D("VerifyCode", "Logic")->getVerifyCode($phone);

            if ($res['status'] != 200) {
                errReturn($res['status'], $res['info']);
            }

            succReturn();
        }
        errReturn('500', '非法请求');
    }
}