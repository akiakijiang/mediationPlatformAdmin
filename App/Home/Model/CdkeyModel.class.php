<?php
namespace Home\Model;
use Think\Model\RelationModel;
class CdkeyModel extends RelationModel {


    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_validate = array(

    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

    public function get_coupon($uid){
        $map["a.getuid"] = array("eq",$uid);
        $map["a.orderid"] = array("eq",0);
        $map["b.starttime"] = array("lt",time());
        $map["b.endtime"] = array("gt",time());
        $data = $this->alias("a")
            ->where($map)
            ->field("a.id,b.type,b.facevalue,b.condition,b.coupon_path")
            ->join("left join coupon b on a.cid=b.id")
            ->order("b.id desc")
            ->select();
        return $data;
    }


}