<?php
namespace Admin\Model;
use Think\Cache\Driver\Hredis;
use Think\Model;
class ProvinceModel extends Model {

    protected $_validate = array(

    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    /**
     * 开发者：akiaki
     * 方法功能： 获取所有省份列表
     * @return bool|mixed
     */
    public function get_all(){
        $redis = new Hredis();
        if($redis->exists("province")){//已经存在键
            return $redis->get("province");
        }else{
            $data = $this->select();//获取新数据
            foreach ($data as $k => $v) {
                $data[$k]['is'] = false;
            }
            $redis->set('province',$data);
            return $data;
        }
    }

}