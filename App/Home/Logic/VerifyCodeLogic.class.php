<?php
namespace Home\Logic;

use Think\Model;
use JiGuang\JSMS;

class VerifyCodeLogic extends Model
{

    protected $autoCheckFields = false;
    protected $appId = "bf3d0ed15b74ea9708587374";
    protected $appSecret = "007859e15ff2df096b20aa3e";
    protected $tempId = "157179";

    protected $jgApi = '';

    public function __construct()
    {
        $this->jgApi = new JSMS($this->appId, $this->appSecret);
    }

    /**
     * @param $phone
     * @param $code
     * 检查验证码是否正确
     */
    public function checkVerifyCode($phone, $code)
    {

        $get_phone_code = M('PhoneCode')->where(['phone' => $phone, 'status' => 1])->order('create_time desc')->find();

        if (!$get_phone_code) {
            return ['status' => 500, 'info' => '没有有效验证码', 'data' => []];
        }

        $msg_id = $get_phone_code['msg_id'];

        $check_code_res = $this->jgApi->checkCode($msg_id, $code);

        if ($check_code_res['http_code'] == 200) {

            $update_data['code'] = $code;
            $update_data['update_time'] = time();
            $where['msg_id'] = $msg_id;
            M('PhoneCode')->where($where)->data($update_data)->save();
            return ['status' => 200, 'info' => 'ok', 'data' => []];
        }

        if ($check_code_res['http_code'] != 200 && $check_code_res['body']['error']['code'] ==  50011) {
            $update_data['code'] = $code;
            $update_data['update_time'] = time();
            $where['msg_id'] = $msg_id;
            M('PhoneCode')->where($where)->data($update_data)->save();

            return ['status' => $check_code_res['http_code'], 'info' => '验证码过期', 'data' => []];
        }

        \Think\Log::record("home验证码验证失败：" . json_encode($check_code_res), \Think\Log::ERR);
        return ['status' => $check_code_res['http_code'], 'info' =>$check_code_res['body']['error']['message'], 'data' => []];


    }



}