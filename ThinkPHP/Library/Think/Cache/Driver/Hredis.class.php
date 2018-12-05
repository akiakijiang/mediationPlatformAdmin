<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
namespace Think\Cache\Driver;
use Think\Cache;
defined('THINK_PATH') or exit();

class Hredis extends Cache {
	 /**
	 * 架构函数
     * @param array $options 缓存参数
     * @access public
     */
    public function __construct($options=array()) {

        if ( !extension_loaded('redis') ) {
            E(L('_NOT_SUPPORT_').':redis');
        }
        $options = array_merge(array (
            'host'          => C('REDIS_HOST') ? : '127.0.0.1',
            'port'          => C('REDIS_PORT') ? : 6379,
            'auth'          => C('REDIS_AUTH') ? : null,
            'timeout'       => C('DATA_CACHE_TIMEOUT') ? : false,
            'persistent'    => false,
        ),$options);

        $this->options =  $options;
        $this->options['expire'] =  isset($options['expire'])?  $options['expire']  :   C('DATA_CACHE_TIME');
        $this->options['prefix'] =  isset($options['prefix'])?  $options['prefix']  :   C('DATA_CACHE_PREFIX');        
        $this->options['length'] =  isset($options['length'])?  $options['length']  :   0;        
        $func = $options['persistent'] ? 'pconnect' : 'connect';
        $this->handler  = new \Redis;
        $options['timeout'] === false ?
        $this->handler->$func($options['host'], $options['port']) :
        $this->handler->$func($options['host'], $options['port'], $options['timeout']);
        $options['auth'] != false? $this->handler->auth($options['auth']):'';
    }

    /**
     * 开发者：huangwei
     * 方法功能：  设置字符串键值
     * @param $key    键
     * @param $value  键值
     */
    public function set($key,$value){
        if(is_array($value)){
            $value = json_encode($value);
        }
        $this->handler->set($key,$value);
    }

    /**
     * 开发者：huangwei
     * 方法功能：  获取字符串键值
     * @param      $key    键
     * @param bool $is_array   是否返回数组，默认返回数据
     *
     * @return bool
     */
    public function get($key,$is_array = true){
        $temp = $this->handler->get($key);
        if($is_array){
            $temp = json_decode($temp,true);
        }
        return $temp;
    }

    /**
     * 开发者：huangwei
     * 方法功能：判断键是否存在
     * @param $key
     *
     * @return bool  真存在，假不存在
     */
    public function exists($key){
        if($this->handler->exists($key)){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除指定键
     * @param $key  键名
     */
    public function del($key){
        $this->handler->delete($key);
    }

    /**
     * 开发者：huangwei
     * 方法功能：   设置hash值
     * @param $key  键
     * @param $data 键值
     */
    public function hmset($key,$data){
        $this->handler->hMset($key,$data);
    }

    /**
     * 开发者 ： huangwei
     * 方法功能：设置hash中某一键值
     */
    public function hset($key,$name,$value){
        $this->handler->hSet($key,$name,$value);
    }

    /**
     * 开发者 ： huangwei
     * 方法功能：获取hash值
     */
    public function hmget($key,$array){
        if(is_array($array)){
            return $this->handler->hMGet($key,$array);
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：       获取hash值所有
     * @param $key
     *
     * @return array
     */
    public function hGetAll($key){
        return $this->handler->hGetAll($key);
    }

    /**
     * 开发者：huangwei
     * 方法功能：设置键的过期时间
     * @param $key   键名
     * @param $time  过期时间 ，秒
     */
    public function expire($key,$time=300){
        $this->handler->expire($key,$time);
    }

    /**
     * 设置到某个时间点失效
     */
    public function expireAt($key,$time=300)
    {
        $this->handler->expireAt($key,$time);
    }

    public function incr($key)
    {
        $this->handler->incr($key);
    }


    /**
     * 开发者 ： huangwei
     * 方法功能：用于为哈希表中的字段值加上指定增量值
     */
    public function HINCRBY($key,$field,$nub){
        $this->handler->hIncrBy($key,$field,$nub);
    }


    /**-----------------------以下部分是集合类型----------------------------------------------------------------
     *
     **/

    /**
     * 开发者：huangwei
     * 方法功能：添加一个集合
     * @param $key  键
     * @param $member  成员
     *
     * @return int  成功返回1，已经存在返回0
     */
    public function sAdd($key,$member){
        return $this->handler->sAdd($key,$member);
    }

    /**
     * 开发者：huangwei
     * 方法功能：从集合中删除某指定元素
     * @param $key  集合
     * @param $member 成员
     *
     * @return int  成功返回1，其他返回0
     */
    public function sRem($key,$member){
        return $this->handler->sRem($key,$member);
    }

    /**
     * 开发者：huangwei
     * 方法功能：判断元素是在存在与当前集合
     * @param $key
     * @param $member
     *
     * @return bool  是返回1，否返回0
     */
    public function sIsMember($key,$member){
        return $this->handler->sIsMember($key,$member);
    }

    /**
     * 开发者：huangwei
     * 方法功能：
     * @param $key
     *
     * @return array
     */
    public function sMembers($key){
        return $this->handler->sMembers($key);
    }

    /**
     * 开发者：huangwei
     * 方法功能：    随机返回集合中的一个元素
     * @param $key  键
     *
     * @return string
     */
    public function sRandMember($key){
        return $this->handler->sRandMember($key);
    }

}
