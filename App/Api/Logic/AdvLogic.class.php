<?php
namespace Api\Logic;

use Think\Model;

class AdvLogic extends Model
{
    const DEFAULT_VALUE = 0;

    public function getAdvs()
    {
        $ret = [
            'code' => 200,
            'msg'  => 'ok',
            'data' => []
        ];

        $data = [];
        $where['is_delete'] = self::DEFAULT_VALUE;
        $res  = M('Adv')->where($where)->select();

        if (empty($res)) {
            return $ret;
        }

        foreach ($res as $k => $v) {
            $data[$k]['adv_pic'] = $v['pic'];
            $data[$k]['adv_link'] = $v['link'];
        }
        $ret['data'] = array_values($data);

        return $ret;

    }

}