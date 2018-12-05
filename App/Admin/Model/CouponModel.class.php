<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class CouponModel extends RelationModel {

    protected $redis;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_validate = array(
        array("type","1,2","种类不正确！","","in",3),
        array('facevalue','require','面额必填！'),
        array('facevalue','0.01,999','面额区间为0.01-999！',"","between"),
        array('starttime','require','开始时间必填！'),
        array('endtime','require','结束时间必填！'),
        array('num','require','数量必填！'),
    );

    protected $_map = array(

    );

    protected $_auto = array(
        array('starttime','getStarttime',3,'callback'),
        array('endtime','getEndtime',3,'callback'),
        array('addtime','time',1,'function'),
    );

    protected function getStarttime($time){
        return strtotime(date("Y-m-d 0:0:0",strtotime($time)));
    }
    protected function getEndtime($time){
        return strtotime(date("Y-m-d 23:59:59",strtotime($time)));
    }

    /**
     *是否可以发放
     */
    public function is_issue($id){
        $res = M("Cdkey")->alias("a")
            ->where(["a.id"=>$id])
            ->field("a.is_issue,b.endtime")
            ->join("left join coupon b on a.cid=b.id")
            ->order("b.id desc")
            ->find();
        $r = false;
        if($res['is_issue']==1){
            $r = "该兑换码已被兑换！";
        }elseif($res['endtime']<=time()){
            $r = "该兑换码已经过期，无法使用！";
        }
        return $r;
    }

}