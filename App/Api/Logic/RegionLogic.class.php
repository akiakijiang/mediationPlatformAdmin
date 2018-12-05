<?php
namespace Api\Logic;
use Think\Model;

class RegionLogic extends Model
{
    protected $autoCheckFields = false;
    //获取省市区三级联动
    public function getRegionAll()
    {
        $provices = M("Province")->select();
        $citys = M("City")->select();
        $districts = M("District")->select();
        if (empty($provices) || empty($citys) || empty($districts)) {
            return ['status' => 500, 'info' => '网络出问题，请稍后再试', 'data' => []];
        }
        $data = [];
        foreach ($provices as $k => $val) {
            $temp_province = [];
            $temp_province['province_id'] = $val['province_id'];
            $temp_province['province_name'] = $val['name'];
            $temp_province['level'] = 0;
            foreach ($citys as $city_item) {
                $temp_city = [];
                if ($city_item['parent_id'] == $val['province_id']) {
                    $temp_city['city_id'] = $city_item['city_id'];
                    $temp_city['city_name'] = $city_item['name'];
                    $temp_city['level'] = 2;
                    foreach ($districts as $district_item) {
                        $temp_district = [];
                        if ($district_item['parent_id'] == $city_item['city_id']) {
                            $temp_district['district_id'] = $district_item['district_id'];
                            $temp_district['district_name'] = $district_item['name'];
                            $temp_district['level'] = 3;
                            $temp_city['child'][] = $temp_district;
                        }
                    }
                    $temp_province['child'][] = $temp_city;
                }
            }
            $data[] = $temp_province;
        }

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }


    public function getHotArea($params)
    {
        $is_city = $params['is_city']?$params['is_city']:0;

        $area_id = $params['area_id'];

        if (!$area_id) {
            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }

        $where['is_hot'] = 1;
        $where['parent_id'] = $area_id;
        if ($is_city == 1) {
            $res = M("City")->where($where)->select();
        } else {
            $res = M("District")->where($where)->select();
        }

        if (!$res) {
            $data = [];
        } else {
            foreach ($res as $key => $val) {
                $data[$key]['hot_id'] = $val['district_id'];
                $data[$key]['hot_name'] = $val['name'];
            }

        }

        return ['status' => 200, 'info'=>'ok', 'data'=>$data];
    }



}
