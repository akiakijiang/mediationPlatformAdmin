<?php
namespace Home\Model;
use Think\Model\RelationModel;
class CustomPageModel extends RelationModel {

    protected $_validate = array(

    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    protected $_link = array(

    );

    /**
     * 开发者：huangwei
     * 方法功能：获取自定义首页数据
     */
    public function get(){
        $map['id'] = 1;
        $data = $this->where($map)->cache(C('REDIS_KEY').':index',600)->find();

        $temp = json_decode($data['json'],true);//获取自定义18个商品

        foreach ($temp as $k => $v){
            foreach ($temp[$k] as $k1 => $v1){
                $temp[$k][$k1]['thumbnail'] = C('CDN_PATH').$temp[$k][$k1]['thumbnail'];
            }
        }//设置CDN路径
        return $temp;
    }

}