<?php
namespace Api\Model;

use Think\Model;

class PhoneCodeModel extends Model
{
   public function addVerifyCode($data)
   {
       return $this->table($this->getTableName())->data($data)->add();
   }

   public function updateVerifyCode($data,$where)
   {
       return $this->table($this->getTableName())->where($where)->save($data);
   }

   public function getVerifyCode($where)
   {
       return $this->table($this->getTableName())->where($where)->order("create_time desc")->find();
   }
}