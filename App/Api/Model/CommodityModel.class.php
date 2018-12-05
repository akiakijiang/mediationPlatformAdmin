<?php
namespace Home\Model;
use Think\Cache\Driver\Hredis;
use Think\Model;
class CommodityModel extends Model {

    protected $redis;
    protected $shopid;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
        $this->redis = new Hredis();
        $this->shopid = session('shopid');
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取推荐商品集合
     */
    public function get_redis($shopid){
        $key = "sx:tuijian:".$this->shopid;
        if(!$this->redis->exists($key)){
            $map['recommend'] = 2;
            $map['shopid'] = $shopid;
            $data = $this->where($map)->field('commodityid')->select();
            foreach ($data as $k => $v){
                $this->redis->sAdd($key,$v['commodityid']);
            }
            $this->redis->expire($key,300);//设置有效期，默认200秒
        }
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取推荐商品
     * @param $id   当前商品ID
     *
     * @return array  返回推荐商品数据
     */
    public function get_tuijian($id){
        $key = "sx:tuijian:".$this->shopid;
        $this->get_redis($this->shopid);//获取集合，防止过期
        $temp = $this->redis->sMembers($key);//获取全部
        $arr = range(0,count($temp)-1);
        shuffle($arr);
        for ($i = 0;$i<3;$i++){
            $data[] = $this->get_goods($temp[$arr[$i]]);
        }

        return $data;
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取某一商品
     * @param       $id   商品ID
     * @param array $array  返回字段
     * @param       $type  1未为全部
     *
     * @return array
     */
    public function get_goods($id,$array=array('commodityid','shopid','integral','title','thumbnail','original','current','carrousel','content','sales','carriageid'),$type=0){
        $key = "sx:goods:".$id;
        if(!$this->redis->exists($key)){
            $map['commodityid'] = $id;
            $data = $this->where($map)->find();
            $this->redis->hmset($key,$data);
            $this->redis->expire($key);//设置有效期，默认200秒
        }

        if($type == 1){
            return $this->redis->hGetAll($key);
        }

        return $this->redis->hmget($key,$array);
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取sku属性值
     */
    public function get_attr($sku,$id){
        $map['attr'] = $sku;
        $map['commodityid'] = $id;

        $key = "sx:sku:".md5($sku.$id);//加密下键

        if(!$this->redis->exists($key)){
            $data = M('commodity_sku')->where($map)->field('stock,attr_money,bianma')->find();
            $this->redis->set($key,$data);
            $this->redis->expire($key);
        }

        return $this->redis->get($key);
    }

    /**
     * 开发者：akiaki
     * 方法功能：   库存 -1   ，销量 +1  ,总库存量-1
     * @param $orderid
     */
    public function save_sku($orderid){
        $M_sku = M('commodity_sku');
        $map['orderid'] = $orderid;
        $data = M('order_commodity_snop')->where($map)->select();//获取订单下商品
        foreach ($data as $k => $v){
            $data[$k]['snopjson'] = json_decode($v['snopjson'],true);
            $sku['commodityid'] = $data[$k]['snopjson']['commodityid'];
            $sku['attr'] = $data[$k]['attr'];
            $M_sku->where($sku)->setDec('stock');//库存-1
            $key = "sx:sku:".md5($sku['attr'].$sku['commodityid']);//加密下键
            $this->redis->del($key);//删除sku的redis缓存
            $this->where(array('commodityid'=>$sku['commodityid']))->setInc('sales');//销量+1
            $key = "sx:goods:".$sku['commodityid'];
            $this->redis->del($key);//删除商品redis缓存
            $key = "sx:stock:".$sku['commodityid'];
            $this->redis->del($key);//删除商品总库存redis缓存
        }
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取某商品总库存
     * @param $id  商品ID
     *
     * @return bool  返回库存值
     */
    public function get_stock($id){
        $key = "sx:stock:".$id;
        if(!$this->redis->exists($key)){
            $map['commodityid'] = $id;
            $stock = M('commodity_sku')->where($map)->field('stock')->sum('stock');//获取总库存量;
            $this->redis->set($key,$stock);//不设置过期时间，只有在购买成功的时候重新设置
        }

        return $this->redis->get($key);
    }

    /**
     * 开发者：akiaki
     * 方法功能： 获取指定商品默认价格
     * @param $id  运费模版ID
     */
    public function get_default_carriage($id){
        $map['carriageid'] = $id;
        return M('carriage')->where($map)->cache("sx:goodscarriage:".$id,400)->getField('price');
    }


}