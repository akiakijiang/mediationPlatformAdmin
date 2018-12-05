<?php
namespace Api\Logic;

use JiGuang\JSMS;
use Think\Cache\Driver\Hredis;
use Think\Model;

class VerifyCodeLogic extends Model
{
    protected $autoCheckFields = false;

    protected $redis;

    protected $countPrefix = 'phone_count_';
    protected $phonePrefix = 'mp_';
    protected $limitTotal = 5;
    protected $expireTime = 5;//5分钟

    protected $appId = "";
    protected $appSecret = "";
    protected $tempId = "157179";

    protected $jgApi = '';

    public function __construct()
    {
        $this->redis = new Hredis();
        $this->jgApi = new JSMS($this->appId, $this->appSecret);
    }

    //生成随意6位数
    public function generateNumber($length=6)
    {
        $chars = '0123456789';
        $str = "";
        for ($i = 0; $i < $length; $i++) {
            $str .= $chars[mt_rand(0, strlen($chars) - 1)];
        }
        return $str;

    }


    /**
     * 获取验证码
     */
    public function getVerifyCode($phone, $other=[])
    {
        //检查是否可以发送,是否发送过，是否重复发送
        $data['phone'] = $phone;
        $check_is_send = $this->checkIsSend($data);
        if ($check_is_send['status'] != 200) {
            return $check_is_send;
        }

        //生成code (极光自动生成验证码)
        //$code = $this->generateCode($phone);

        //发送验证码
        $send_res = $this->sendSmsCode($phone);
        if ($send_res['status'] == 200) {
            if (!$this->redis->get($this->countPrefix.$phone)) {
                $expire_time = mktime(23, 59, 59, date("m"), date("d"), date("Y"));
                $this->redis->expireAt($this->countPrefix . $phone, $expire_time);
            }
            $this->redis->incr($this->countPrefix . $phone);
            $add_data['phone'] = $phone;
            $add_data['msg_id'] = $send_res['data']['msg_id'];
            $add_data['status'] = 1;
            $add_data['create_time']   = time();
            D('PhoneCode')->addVerifyCode($add_data);

        }

        return $send_res;

    }


    /**
     * 检查是否可以发送
     */
    public function checkIsSend($data)
    {
        //是否发送过于频繁

        $phone = $data['phone'];
       # $ip = $data['IP'];
        if (empty($phone)) {
            return ['status' => 500, 'info' => '缺少参数', 'data'=> []];
        }

        $phone_key = $this->phonePrefix . $phone;
        $now = time();

        $value = ['phone' => $phone, 'last_time' => $now];

        //如果没有设置过，就可以发送
        if (!$this->redis->exists($phone_key) || empty($this->redis->get($phone_key))) {
            $this->redis->set($phone_key, $value);
            $expire_time = mktime(23, 59, 59, date("m"), date("d"), date("Y"));
            $this->redis->expireAt($phone_key, $expire_time);

            return ['status' => 200, 'info' => '可以发送', 'data'=> []];
        } else {
            $get_last_phone_values = $this->redis->get($phone_key);

            if ($get_last_phone_values && $get_last_phone_values['last_time'] > $now - 60) {
                return ['status' => 500, 'info' => '您的请求过于频繁，请稍后再试', 'data'=> []];
            }

            $value['last_time'] = time();
            $this->redis->set($phone_key, $value);

        }



        //是否超过每日限制
        $phone_count_key = $this->countPrefix . $phone;

        if ($this->redis->get($phone_count_key)
            && $this->redis->get($phone_count_key) > $this->limitTotal ) {

            return ['status' => 500, 'info' => '今天发送的验证码过多。请明日再试', 'data' => []];
        }


        return ['status' => 200, 'info' => '可以发送', 'data'=> []];


    }


    private function generateCode($phone)
    {
        $data = [
            'phone' => $phone,
            'code'  => $this->generateNumber(),
            'create_time' => time()
        ];

        D('PhoneCode')->addVerifyCode($data);

        return $data['code'];
    }

    //TODO:: 对接第三方
    private function sendSmsCode($phone)
    {

        $res = $this->jgApi->sendCode($phone, $this->tempId);

        if ($res['http_code'] == 200) {
            $data = $res['body'];
            return ['status' => 200, 'info' => 'ok', 'data' => $data];
        }
        \Think\Log::record("发送码验证失败：" . json_encode($res), \Think\Log::ERR);

        return ['status' => $res['http_code'], 'info' => $res['body']['error']['message'], 'data' => []];


    }


    /**
     * @param $phone
     * @param $code
     * 检查验证码是否正确
     */
    public function checkVerifyCode($phone, $code)
    {

        $get_phone_code = D('PhoneCode')->getVerifyCode(['phone' => $phone, 'status' => 1]);

        if (!$get_phone_code) {
            return ['status' => 500, 'info' => '没有有效验证码', 'data' => []];
        }

        $msg_id = $get_phone_code['msg_id'];


        $check_code_res = $this->jgApi->checkCode($msg_id, $code);

        if ($check_code_res['http_code'] == 200) {

            $update_data['code'] = $code;
            $update_data['update_time'] = time();
            $where['msg_id'] = $msg_id;
            D("PhoneCode")->updateVerifyCode($update_data, $where);
            return ['status' => 200, 'info' => 'ok', 'data' => []];
        }

        if ($check_code_res['http_code'] != 200 && $check_code_res['body']['error']['code'] ==  50011) {
            $update_data['code'] = $code;
            $update_data['update_time'] = time();
            $where['msg_id'] = $msg_id;
            D("PhoneCode")->updateVerifyCode($update_data, $where);
        }

        return ['status' => $check_code_res['http_code'], 'info' => $check_code_res['body']['error']['message'], 'data' => []];

    }







}