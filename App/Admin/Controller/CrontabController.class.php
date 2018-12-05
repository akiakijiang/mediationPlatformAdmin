<?php
/**
 * Created by PhpStorm.
 * User: baimifan-pc
 * Date: 2017/6/28
 * Time: 16:42
 */
namespace Admin\Controller;
use EasyWeChat\Foundation\Application;
use Think\Controller;
class CrontabController{

    public function __construct()
    {
        var_dump(2121);
    }

    public function cron(){
        $cron = A('Admin/Commodity');
        $cron->c_number();
    }



    function request_by_curl($remote_server, $post_string)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $remote_server);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json;charset=utf-8'));
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }


    public function notice()
    {
        $message="我就是我, 是不一样的烟火";
        $data = array ('msgtype' => 'text','text' => array ('content' => $message));
        $data_string = json_encode($data);
        $result = $this->request_by_curl("https://oapi.dingtalk.com/robot/send?access_token=16d5fd3d2c9c19e035102d426c60096198fb29d4ada7d6772ca16fa320203fe3", $data_string);
        return $result;
    }
}