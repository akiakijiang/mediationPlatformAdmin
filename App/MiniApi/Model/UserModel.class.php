<?php
namespace MiniApi\Model;
use Think\Model;

class UserModel extends Model
{

    public function getComments($where, $limit = '0,5', $order = 'desc')
    {
        $res = $this->table('mp_shop_evaluat as se')
            ->field('s.shop_id, s.shop_title, se.content, se.create_time , se.star')
            ->where($where)
            ->join('mp_shop as s ON s.shop_id = se.shop_id', 'left')
            ->limit($limit)
            ->order('se.create_time ' .$order)
            ->select();

        return $res;
    }
}