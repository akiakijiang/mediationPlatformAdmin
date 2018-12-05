<?php
namespace Api\Model;

use Think\Model;

class ShopModel extends Model
{
    protected $autoCheckFields = false;

    public function getOne($where)
    {
        return $this->table($this->getTableName())->where($where)->find();
    }

    public function getListByScoreOrPopular($where, $limit = '0,20', $order = 'star desc')
    {
        $res = $this->table('mp_shop as s')
                ->field('s.*, avg(se.star) as star, count(se.uid) as popular')
                ->where($where)
                ->join('mp_shop_evaluat as se ON s.shop_id = se.shop_id', 'left')
                ->group('s.shop_id')
                ->order($order)
                ->limit($limit)
                ->select();
         return $res;
    }



    public function getListByDistance($where, $limit = '0,20')
    {
        $res = $this->table('mp_shop as s')
            ->field('s.*, sp.lat, sp.lng')
            ->where($where)
            ->join('mp_shop_position as sp ON s.shop_id = sp.shop_id')
            ->limit($limit)
            ->select();
        return $res;
    }


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