<?php
namespace Admin\Model;
use Think\Cache\Driver\Hredis;
use Think\Model;
class ArticleModel extends Model {

    protected $_validate = array(

    );

    protected $_map = array(
        
    );

    protected $_auto = array(

    );

    /**
     * 开发者：huangwei
     * 方法功能：获取某票文章
     * @param $abc  文章标识 -----固定
     * @param $id  店铺ID
     */
    public function get_article($abc,$id){
        $key = C('REDIS_KEY').":article:".$id.":".$abc;
        $redis = new Hredis();
        if($redis->exists($key)){
            return $redis->hmget($key,array('title','content'));
        }else{
            $map['shopid'] = $id;
            $map['abc'] = $abc;
            $data = $this->where($map)->find();
            $redis->hmset($key,$data);//写入redis
            $redis->expire($key);
            return $data;
        }
    }

}