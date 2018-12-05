<?php
namespace Api\Logic;

use Think\Model;

class ShopLogic extends Model
{

    protected $autoCheckFields = false;
    protected $error = ["status" => 500, "info" => "暂无数据", "data" => []];
    protected $succ  = ["status" => 200, "info" => "ok", "data" => []];
    protected $geo_length = 1;
    protected $default_val = 0;
    protected $default_limit = 20;//默认条数,
    protected $default_pic = "";

    //获取店铺列表 （还需要做修改）
    public function getShopList($params)
    {
        $category_id        = isset($params['category_id'])?$params['category_id']:0;
        $province_id        = isset($params['province_id'])?$params['province_id']:0;
        $city_id            = isset($params['city_id'])?$params['city_id']:0;
        $district_id	    = isset($params['district_id'])?$params['district_id']:0;
        $hot_district_id    = isset($params['hot_district_id'])?$params['hot_district_id']:0;
        $arrange_id         = isset($params['arrange_id'])?$params['arrange_id']:0; //1 距离 2 人气  3口碑  4综合
        $sort               = isset($params['sort'])?($params['sort'] == 0?"desc":"asc"):'desc';
        $index              = isset($params['index'])?$params['index']:0;

        $limit              = "$index, $this->default_limit";

        //用户的经纬度. 如果没有用户的经纬度，怎么展示
        $user_lat = isset($params['user_lat'])?$params['user_lat']:-100;
        $user_lng = isset($params['user_lng'])?$params['user_lng']:-100;


        //距离计算
        $where = [];
        if ($category_id > 0) {
            $where['s.category_id'] = $category_id;
        }

        if ($hot_district_id > 0) {
            $where['s.district_id'] = $hot_district_id;
        } else if ($district_id > 0) {
            $where['s.district_id'] = $district_id;
        }

        switch ($arrange_id) {
            case 1:
                if ($user_lng == -100 || $user_lat == -100) {
                    $list = $this->sortByScoreOrPopular($where, $user_lat, $user_lng, $limit, 'create_time asc' );
                } else {
                    $list = $this->sortByDistance($where, $user_lng, $user_lat, $sort);
                }
                break;
            case 2:
                $list = $this->sortByScoreOrPopular($where, $user_lat, $user_lng, $limit, 'popular ' . $sort);
                break;
            case 3:
                $list = $this->sortByScoreOrPopular($where, $user_lat, $user_lng, $limit, 'star ' . $sort);

                break;
            default:
                $list = $this->sortByScoreOrPopular($where, $user_lat, $user_lng, $limit, 'create_time asc' );
                break;
        }

        if ($list['status'] == 200) {
            $data['index'] = $index;
            $data['shop_list'] = $list['data'];
            $list['data'] = $data;
        }
        return $list;

    }

    /**
     * 距离排序
     */
    public function sortByDistance($where, $user_lat, $user_lng, $sort)
    {
        $geo = new \Geohash();
        $user_geo_code = $geo->encode($user_lat, $user_lng);
        //一开始没有很多家店铺，先大范围查找
        $n_geohash = substr($user_geo_code, 0, $this->geo_length);

        $where['sp.geo_code'] = ['like', $n_geohash . '%'];
        $list = D("Shop")->getListByDistance($where);

        if ($list < 20) {
            unset($where['sp.geo_code']);
            $list = D("Shop")->getListByDistance($where);
        }

        if (empty($list)) {
            return ['status' => 500,'info' => '暂无数据', 'data' => []];
        }

        $shop_ids = array_column($list , 'shop_id');

        $score_where['shop_id'] = ['in', array_values($shop_ids)];
        $score_popular_res = D("Shop")->getScoreAndPopular($score_where);

        $score_popular_arr = [];
        if ($score_popular_res) {
            foreach ($score_popular_res as $val) {
                $score_popular_arr[$val['shop_id']]['star'] = $val['star'];
                $score_popular_arr[$val['shop_id']]['popular'] = $val['popular'];
            }
        }


        $i = 0;
        $data = [];
        foreach ($list as $val) {
            $distance       = getdistance($user_lng, $user_lat, $val['lng'], $val['lat']);
            $sort_by[$i]['distance'] = $distance;
            $shop_id    = $val['shop_id'];
            $data[$i]['shop_id'] = $shop_id;
            $data[$i]['shop_id'] = $shop_id;
            $data[$i]['shop_name'] = $val['shop_name'];
            $data[$i]['shop_title'] = $val['shop_title'];
            $pics = json_decode($val['pics']);
            if (!is_array($pics)) {
                $pic = $this->default_pic;
            } else {
                $pic = $pics['cover_pic'];
            }

            $data[$i]['shop_pic']     = $pic;
            if (isset($score_popular_arr[$shop_id])) {
                $data[$i]['shop_star']   = $score_popular_arr[$shop_id]['star'];
                $data[$i]['shop_popular'] = $score_popular_arr[$shop_id]['popular'];
            } else {
                $data[$i]['shop_star']   = 0;
                $data[$i]['shop_popular'] = 0;
            }

            if ($distance < 1000) {
                $distance = sprintf("%.0f",$distance)."米";
            } else {
                $distance = sprintf("%.1f",$distance/1000)."公里";
            }
            $data[$i]['distance']     = $distance;
            $data[$i]['reg_date']     = date('Y-m-d', $val['create_time']);

            $i ++;
        }

        if (strtolower($sort) == 'desc') {
            array_multisort($sort_by, SORT_DESC, $data);
        } else {
            array_multisort($sort_by, SORT_ASC, $data);
        }

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }



    public function sortByScoreOrPopular($where, $user_lat, $user_lng, $limit, $order)
    {
        $score_list = D("Shop")->getListByScoreOrPopular($where, $limit, $order);
        if (empty($score_list)) {
            return ['status' => 500,'info' => '暂无数据', 'data' => []];
        }
        $shop_ids  = array_column($score_list, "shop_id");


        $shop_position = $this->getShopPosition(array_values($shop_ids), $user_lat, $user_lng);
        if ($shop_position['status'] != 200) {
            return $shop_position;
        }
        $data = [];
        $position_list = $shop_position['data'];

        foreach ($score_list as $value) {
            $temp = [];
            $shop_id = $value['shop_id'];
            $temp['shop_id']    = $shop_id;
            $temp['shop_name']  = $value['shop_name'];
            $temp['shop_title'] = $value['shop_title'];
            $pics = json_decode($value['pics']);
            if (!is_array($pics)) {
                $pic = $this->default_pic;
            } else {
                $pic = $pics['cover_pic'];
            }

            if (isset($position_list[$shop_id])) {
                $distance = $position_list[$shop_id]['distance'];
            } else {
                $distance = 0;
            }
            $temp['shop_pic']     = $pic;
            $temp['shop_star']    = $value['star']?round($value['star'],2):0;
            $temp['shop_popular'] = $value['popular']?$value['popular']:0;
            $temp['distance']     = $distance;
            $temp['reg_date']     = date("Y-m-d", $value['create_time']);
            $data[] = $temp;
        }

        return ['status' => 200, 'info' => 'ok', 'data' => $data];


    }

    protected function getShopPosition($shop_ids, $user_lat, $user_lng)
    {

        if (!is_array($shop_ids) ||
            !$user_lat || ! $user_lng) {

            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }
        $where['shop_id'] = ['in', $shop_ids];
        $lists= D("ShopPosition")->getList($where);
        if (empty($lists)) {
            return ['status' => 500,'info' => '暂无数据', 'data' => []];

        }
        $data = [];
        foreach ($lists as $val) {
            if ($user_lat == -100 || $user_lng == -100) {
                $data[$val['shop_id']]['distance'] = 0;
            } else {
                $distance = getdistance($user_lng, $user_lat, $val['lng'], $val['lat']);
                if ($distance < 1000) {
                    $distance = sprintf("%.0f",$distance)."米";
                } else {
                    $distance = sprintf("%.1f",$distance/1000)."公里";
                }
                $data[$val['shop_id']]['distance'] = $distance;
            }

        }

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }

    //获取类型列表
    public function getCategory()
    {
        $cates = M("ShopCategory")->select();
        if (empty($cates)) {
            return $this->error;
        }
        $data = [];
        foreach ($cates as $k => $val) {
            $data[$k]['category_id']   = $val['category_id'];
            $data[$k]['category_name'] = $val['name'];
        }

        $this->succ['data'] = $data;
        return $this->succ;
    }

    //获取机构信息内容
    public function getShopInfo($params)
    {
        if (!isset($params['uid']) || empty($params['uid'])) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $uid = $params['uid'];
        $where['uid'] = $uid;
        $shop_info = D("Shop")->getOne($where);
        if (empty($shop_info)) {
            return $this->error;
        }

        $data['uid']        = $uid;
        $data['shop_id']    = $shop_info['shop_id'];
        $data['shop_title'] = $shop_info['shop_title'];
        $data['shop_name']  = $shop_info['shop_name'];
        $data['reg_time']   = $shop_info['reg_time'];
        $data['contact']    = $shop_info['contact'];
        $data['tell_phone'] = $shop_info['tell_phone'];
        $data['mobile_phone'] = $shop_info['mobile_phone'];
        $data['wx_no']      = $shop_info['wx_no'];
        $data['category_id']  = $shop_info['category_id'];
        $data['province_id']  = $shop_info['province_id'];
        $data['city_id']      = $shop_info['city_id'];
        $data['district_id']  = $shop_info['district_id'];
        $data['address']      = $shop_info['address'];

        $this->succ['data'] = $data;

        return $this->succ;

    }

    //获取师资力量
    public function getFacultys($params)
    {
        $shop_id = $params['shop_id'];
        $index   = isset($params['index'])? $params['index']:0;
        $default_limit = 5;
        if (empty($shop_id)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }
        $facultys = M("Shop_faculty")->where(['shop_id' => $shop_id])->limit($index, $default_limit)->select();

        $this->succ['data'] = $facultys;

        return $this->succ;

    }


    //获取店铺主图
    public function getShopPics($params)
    {
        $shop_id = $params['shop_id'];
        if (empty($shop_id)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }
        $where['shop_id']  = $shop_id;
        $shop_info = D("Shop")->getOne($where);
        $data = [];
        if (!empty($shop_info)) {
            $pics  = $shop_info['pics'];
            $pic_arr = json_decode($pics);
            $data = $pic_arr;
        }

        $this->succ['data'] = $data;
        return $this->succ;

    }

    //获取环境
    public function getShopEnv($params)
    {
        $shop_id = $params['shop_id'];
        if (!$shop_id) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $where['shop_id'] = $shop_id;
        $where['is_delete'] = $this->default_val;
        $shop_env = M("Shop_environment")->where($where)->select();

        $this->succ['data'] = $shop_env;

        return $this->succ;

    }

    //获取评论
    public function getShopEva($params)
    {
        $shop_id = $params['shop_id'];
        if (!$shop_id) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }
        $default_limit = 5;
        $eva_model = D("ShopEvaluat");
        $index = isset($params['index'])?$params['index']:0;
        $rating = isset($params['rating'])?$params['rating']:0;

        $rating_arr = [
            -1, 1, 2, 3
        ];
        $where['shop_id'] = $shop_id;

        if ($rating > 0) {
            $where['rating'] = $rating;
        }

        $total = $eva_model->getCount($where);
        $avg_star = $eva_model->getAvg($where, 'star');

        $rating_list = $eva_model->getRatingList($shop_id);
        if (empty($rating_list)) {
            return $this->error;
        }
        $deal_rating = [];
        foreach ($rating_list as $item) {
            $deal_rating[$item['rating']] = $item['total'];
        }

        $rating_res = [];
        foreach ($rating_arr as $val) {

            if (isset($deal_rating[$val])) {
                $rating_res[$val] = $deal_rating[$val];
            } else {
                $rating_res[$val] = 0;
            }

            if ($val == -1) {
                $rating_res[$val] = $total;
            }

        }

        $limit = "$index, $default_limit";
        $eva_list = $eva_model->getComments($where, $limit);

        if (empty($eva_list)) {
            return $this->error;
        }

        $comments_list = [];
        foreach ($eva_list as $val) {
            $temp = [];
            $temp['eva_id'] = $val['eva_id'];
            $temp['uid']    = $val['uid'];
            $temp['pic']    = $val['avatar'];
            $temp['star']   = $val['star'];
            $temp['content']= $val['content'];
            $temp['date']   = date('Y-m', $val['create_time']);
            $comments_list[] = $temp;
        }

        $data['total']      = $total;
        $data['avg_star']   = $avg_star;
        $data['index']      = $index;
        $data['eva_rating'] = $rating_res;
        $data['eva_list']   = $comments_list;

        $this->succ['data'] = $data;
        return $this->succ;

    }


    //上传评论
    public function addShopComments($params)
    {
        $uid     = $params['uid'];
        $shop_id = $params['shop_id'];
        $star    = $params['star'];
        $content = $params['content'];


        if (empty($uid) || empty($shop_id) || empty($star) || empty($content)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $rating = 1;
        switch ($star) {
            case 5:
                $rating = 1;
                break;
            case 4:
                $rating = 2;
                break;
            case 3:
                $rating = 2;
                break;
            case 2:
                $rating = 1;
                break;
            case 1:
                $rating = 1;
                break;
            default:
                $rating = 1;
        }

        $add_data['uid']            = $uid;
        $add_data['shop_id']        = $shop_id;
        $add_data['star']          = $star;
        $add_data['content']        = $content;
        $add_data['rating']         = $rating;
        $add_data['create_time']    = time();

        $add_res = D("ShopEvaluat")->data($add_data)->add();

        if ($add_res === false) {
            return $this->error;
        }

        return $this->succ;
    }

    //删除学习环境
    public function deleteShopEnv($params)
    {
        $env_id = $params['env_id'];
        if (!$env_id) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $data['is_delete'] = 1;
        $where['env_id'] = $env_id;

        $update_res = M("Shop_environment")->where($where)->data($data)->save();

        if ($update_res === false) {
            return $this->error;
        }

        return $this->succ;

    }
    //删除师资力量
    public function deleteShopFac($params)
    {
        $fac_id = $params['fac_id'];
        if (!$fac_id) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $data['is_delete'] = 1;
        $where['fac_id'] = $fac_id;

        $update_res = M("Shop_faculty")->where($where)->data($data)->save();

        if ($update_res === false) {
            return $this->error;
        }

        return $this->succ;
    }

    //上传店铺机构信息
    public function saveShop($params)
    {

        $data['uid']            = $params['uid'];
        $data['shop_title']     = $params['shop_title'];
        $data['shop_name']      = $params['shop_name'];
        $data['reg_time']       = strtotime($params['reg_date']);
        $data['contact']        = $params['contact'];
        $data['tell_phone']     = $params['tell_phone'];
        $data['mobile_phone']   = $params['mobile_phone'];
        $data['wx_no']          = $params['wx_no'];
        $data['category_id']    = $params['category_id'];
        $data['province_id']    = $params['province_id'];
        $data['city_id']        = $params['city_id'];
        $data['district_id']    = $params['district_id'];
        $data['address']        = $params['address'];

        $province_name = isset($params['province_name'])?trim($params['province_name']):'';
        $city_name    = isset($params['city_name'])?trim($params['city_name']):'';
        $district_name = isset($params['district_name'])?trim($params['district_name']):'';


        $shop_address = $province_name . $city_name . $district_name . $data['address'];

        //取商铺经纬度。
        $webapi = new \WebServiceApi();
        $get_lat_lng_res = $webapi->getLatLngByAddress($shop_address);
        if ($get_lat_lng_res['status'] != 200) {
            return $get_lat_lng_res;
        }

        $lat = $get_lat_lng_res['data']['lat'];
        $lng = $get_lat_lng_res['data']['lng'];

        //取geohash
        $geo = new \Geohash();
        $geo_code = $geo->encode($lat, $lng);

        $shop_model = D("Shop");

        $position_data['lat'] = $lat;
        $position_data['lng'] = $lng;
        $position_data['geo_code'] = $geo_code;

        $shop_info = $shop_model->getOne(['uid' => $data['uid']]);

        $shop_model->startTrans();

        if (empty($shop_info)) {
            $data['create_time'] = time();
            $res = $shop_model->data($data)->add();
            if ($res === false) {
                $shop_model->rollback();
                return $this->error;
            }
            $shop_id = $res;

        } else {
            unset($data['uid']);
            $data['update_time'] = time();
            $res = $shop_model->where(['shop_id' => $shop_info['shop_id']])->data($data)->save();
            if ($res === false) {
                $shop_model->rollback();
                return $this->error;
            }
            $shop_id = $shop_info['shop_id'];
        }


        if (!M('Shop_position')->where(['shop_id' => $shop_id])->find()) {

            $position_data['shop_id'] = $shop_id;
            $position_data['create_time'] = time();

            $position_res = M("Shop_position")->data($position_data)->add();

        } else {

            $position_data['update_time'] = time();

            $position_res = M("Shop_position")->where(['shop_id' => $shop_id])->data($position_data)->save();

        }

        if ($position_res === false) {

            $shop_model->rollback();
            return $this->error;
        }

        $shop_model->commit();

        $this->succ['data'] = ['shop_id' => $shop_id];

        return $this->succ;

    }


    //上传学习环境
    public function saveShopEnv($params)
    {
        $shop_id = $params['shop_id'];
        $env     = $params['env'];

        if (!$shop_id || empty($env) || !is_array($env)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }
        $data = [];

        foreach ($env as $val) {
            $temp = [];
            $temp['shop_id'] = $shop_id;
            $temp['title']   = $val['title'];
            $temp['pic']     = $val['pic'];
            $temp['create_time'] = time();
            $data[] = $temp;
        }

        $update_data['is_delete'] = 1;
        $update_res = M("Shop_environment")->where(['shop_id' => $shop_id])->save($update_data);

        $res = M("Shop_environment")->addAll($data);

        if ($res === false) {
            return $this->error;
        }

        return $this->succ;

    }

    //上传师资力量
    public function saveShopFac($params)
    {

        $shop_id = $params['shop_id'];
        $faculty     = $params['faculty'];

        if (!$shop_id || empty($faculty) || !is_array($faculty)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $data = [];
        foreach ($faculty as $val) {
            $temp = [];
            $temp['shop_id']    = $shop_id;
            $temp['name']       = $val['name'];
            $temp['pic']        = $val['pic'];
            $temp['job_title']  = $val['job_title'];
            $temp['describe']   = $val['describe'];
            $temp['create_time'] = time();
            $data[] = $temp;
        }

        $update_data['is_delete'] = 1;
        $update_res = M("Shop_faculty")->where(['shop_id' => $shop_id])->save($update_data);

        $res = M("Shop_faculty")->addAll($data);

        if ($res === false) {
            return $this->error;
        }

        return $this->succ;

    }

    //上传店铺主图
    public function saveShopPics($params)
    {

        $shop_id     = $params['shop_id'];
        $cover_pic   = $params['cover_pic'];
        $other       = $params['other'];

        if (!$shop_id || !$cover_pic || empty($other) || !is_array($other)) {
            $this->error['info'] = "缺少必要参数";
            return $this->error;
        }

        $shop_info = D("Shop")->getOne(['shop_id' => $shop_id]);

        if (empty($shop_info)) {
            return $this->error;
        }
        $uid = $shop_info['uid'];
        $temp_data['cover_pic'] = $cover_pic;
        $temp_data['other']  = $other;

        $data['pics'] = json_encode($temp_data);
        $res = D("Shop")->where(['shop_id' => $shop_id])->data($data)->save();

        if ($res === false) {
            return $this->error;
        }

        $update_data['is_shop'] = 1;

        $update_res = D("User")->where(['uid' => $uid])->data($update_data)->save();

        if ($update_res === false) {
            return $this->error;
        }

        return $this->succ;

    }

}