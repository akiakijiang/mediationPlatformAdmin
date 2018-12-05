<?php
namespace Api\Model;
use Think\Model;

class UserModel extends Model
{

    public function addUser($data)
    {
        return $this->table($this->getTableName())->add($data);
    }

    public function updateUser($data, $where)
    {
        return $this->table($this->getTableName())->where($where)->save($data);
    }

    public function getUser($where)
    {
        return $this->table($this->getTableName())->where($where)->find();
    }






}