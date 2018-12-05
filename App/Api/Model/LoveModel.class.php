<?php
namespace Home\Model;
use Think\Cache\Driver\Hredis;
use Think\Model\RelationModel;
class LoveModel extends RelationModel {

    public $redis;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
        $this->redis = new Hredis();

        $map['shopid'] = session('shopid');
        $map['uid'] = session('user.id');

        $key = "sx:love:".session('shopid').":".session('user.id');
        if(!$this->redis->exists($key)){
            $data = $this->where($map)->field('commodityid')->select();
            foreach ($data as $k => $v){
                $this->redis->sAdd($key,$v['commodityid']);
            }
            $this->redis->expire($key);//设置有效期，默认200秒
        }
    }

    protected $_validate = array(

    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

    protected $_link = array(
        'goods' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'commodity',
            'foreign_key'  => 'commodityid',
            'mapping_fields' => 'title,thumbnail,current,status,commodityid'
        ),
    );

    /**
     * 开发者：akiaki
     * 方法功能：  判断商品是否已经收藏
     * @param $member
     *
     * @return int
     */
    public function is_love($member){
        $key = "sx:love:".session('shopid').":".session('user.id');
        if($this->redis->sIsMember($key,$member)){//判断该商品是否已经收藏
            //已经收藏
            return 1;
        }else{
            return 0;
        }
    }


}