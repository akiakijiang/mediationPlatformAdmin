<?php
namespace Api\Logic;

use Think\Model;

class LinkLogic extends Model
{
    protected $autoCheckFields = false;
    protected $default_value = 0;

    public function getLinks()
    {
        $ret = [
            'code' => 200,
            'msg'  => 'ok',
            'data' => []
        ];

        $data = [];
        $where['is_delete'] = $this->default_value;
        $res  = M('Link')->where($where)->select();

        if (empty($res)) {
            return $ret;
        }

        foreach ($res as $k => $v) {
            $data[$k]['link_name'] = $v['name'];
            $data[$k]['link'] = $v['link'];
        }

        $ret['data'] = array_values($data);

        return $ret;
    }
}