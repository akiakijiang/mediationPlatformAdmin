<?php
namespace Home\Controller;
use JiGuang\JSMS;
use Think\Controller;


class TestController extends PublicController
{
    public function getRegions()
    {
        $api_id = "wx1315058e1d1dd9e2";
        $api_secret = "0306b7ba18d468fa7b01d94e63bc451c";
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$api_id}&secret={$api_secret}&js_code=JSCODE&grant_type=authorization_code";
        $res = file_get_contents($url);

        echo json_encode($res);die;
    }
}
