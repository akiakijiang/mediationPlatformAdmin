<?php
namespace Admin\Model;
use Think\Cache\Driver\Hredis;
use Think\Model;
class SpecificationsModel extends Model {

    protected $shopid;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
        $this->shopid = session('admin.shopid');
    }

    protected $_validate = array(
        array('name','require','规格名称必须填写！'),
    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    /**
     * 开发者：huangwei
     * 方法功能： 获取当前店铺所有规格列表
     * @return bool|mixed
     */
    public function get_all(){
        $map['shopid'] = $this->shopid;
        return $this->where($map)->cache(C('REDIS_KEY').':guige:'.$this->shopid,120)->select();
    }

}