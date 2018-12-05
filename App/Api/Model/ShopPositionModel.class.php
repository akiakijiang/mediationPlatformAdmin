<?php
namespace Api\Model;
use Think\Model;

class ShopPositionModel extends Model
{
    public function getList($where)
    {
        $res = $this->table($this->getTableName())->where($where)->select();
        return $res;
    }

    public function getOne($where)
    {
        $res = $this->table($this->getTableName())->where($where)->find();
        return $res;
    }
}