<?php
namespace Api\Model;

use Think\Model;

class ShopEvaluatModel extends Model
{
    public function getCount($where)
    {
        $res = $this->table($this->getTableName())->where($where)->count();
        return $res;
    }

    public function getAvg($where, $field)
    {
        $res = $this->table($this->getTableName())->where($where)->avg($field);
        return $res;
    }

    public function getRatingList($shop_id)
    {
        $res = $this->table($this->getTableName())
            ->field('rating, count(eva_id) as total')
            ->where(['shop_id' => $shop_id])
            ->group('rating')
            ->select();
        return $res;
    }

    public function getComments($where, $limit)
    {
        $res = $this->table('mp_shop_evaluat as se')
            ->field('u.avatar,u.uid, se.eva_id, se.content, se.star,se.create_time')
            ->join('mp_user as u ON u.uid = se.uid', 'LEFT')
            ->where($where)
            ->limit($limit)
            ->order('create_time desc')
            ->select();
        return $res;
    }
}