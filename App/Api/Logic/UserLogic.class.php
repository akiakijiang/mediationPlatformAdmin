<?php
namespace Api\Logic;

use Think\Model;


class UserLogic extends Model
{
    /**
     *
     * 上传个人资料
     * @param $data
     *
     * @return array
     */
    public function uploadUserInfo($data)
    {
        $uid = $data['uid'];

        $user_info = $this->getUserInfo(['uid' => $uid]);

        if (empty($user_info)) {
            return ['status' => '500', 'info' => '非本人不可操作', 'data' => []];
        }

        $update_data['nick_name']= base64_encode($data['nick_name']);
        $update_data['avatar']   = $data['avatar']?$data['avatar']:'';
        $update_data['birthday'] = strtotime($data['birthday']);

        $update_res = D("User")->where(['uid' => $uid])->data($update_data)->save();
        if ($update_res === false) {
            return ['status' => 500, 'info' => '上传失败', 'data' => []];
        }

        return ['status' => 200, 'info' => '上传成功', 'data' => []];


    }


    public function getUserInfo($where)
    {
        $res = D("User")->where($where)->find();
        if (!$res) {
            return ['status' => 500, 'info' => '暂无此人信息', 'data' => []];
        }
        $data['nick_name'] = $res['nick_name']?base64_decode($res['nick_name']):'';
        $data['member_id'] = $res['member_id'];
        $data['phone']     = $res['phone'];
        $data['birthday']  = $res['birthday'] > 0? date('Ym', $res['birthday']):'';
        $data['avatar']    = $res['avatar']?$res['avatar']:'';
        return ['status' => 200, 'info' => 'ok', 'data' => $data];
    }




    public function getMyComments($params)
    {

        $uid = $params['uid'];
        $index = $params['index']?$params['index']: 0;
        $defalut_limt = 5;
        $limit = "$index, $defalut_limt";
        if (!$uid) {
            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }

        $where['s.uid'] = $uid;

        $comment_res   = D("Shop")->getComments($where, $limit);

        if (empty($comment_res)) {
            return ['status' => 500, 'info' => '暂无数据', 'data' => []];
        }

        $data['index'] = $index;

        $list = [];

        $i = 0;
        foreach ($comment_res as $val) {
            $list[$i]['shop_id']        = $val['shop_id'];
            $list[$i]['shop_title']     = $val['shop_title'];
            $list[$i]['comment']        = $val['comment'];
            $list[$i]['score']          = $val['score'];
            $list[$i]['comment_time']   = date('Y-m-d', $val['shop_id']);
            $i++;
        }

        $data['comment_list'] = $list;

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }
}