<?php
namespace Api\Controller;
use Think\Controller;

class AreaController extends Controller
{

    protected $autoCheckFields = false;

    public function regionAll()
    {
        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $res = D("Region", "Logic")->getRegionAll();

        if ($res['status'] != 200) {
            errReturn($res['status'], $res['info']);
        }

        succReturn($res['data']);

    }

    /**
     * 获取热门区域
     */
    public function getHotArea()
    {
        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $data = I("post.");

        if (!$data['area_id']) {
            errReturn('501', '缺少必要参数');
        }

        $res = D("Region", "Logic")->getHotArea($data);

        if ($res['status'] != 200) {
            errReturn($res['status'], $res['info']);
        }

        succReturn($res['data']);
    }
}