<?php
namespace Admin\Controller;
use Think\Controller;
class CarouselExtendController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('carousel_extend');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：获取所有广告位置数据
     */
    public function get_all(){
        $data = $this->model->cache(C('REDIS_KEY').':carousel:position',300)->select();
        return $data;
    }

}