<?php
namespace Home\Controller;
use Think\Controller;
class CartController extends Controller {

    /**
     * 用户购物车缓存键     sx:gouwu:店铺ID:用户ID
     */

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('cart');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：购物车详情页面
     */
    public function index(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 20;

        $map['shopid'] = $this->shopid;
        $map['uid'] = $this->uid;
        $data = $this->model->where($map)->relation(true)->select();
        foreach ($data as $k => $v){
            $data[$k]['isselected'] = 0;
        }
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除购物车
     */
    public function del(){
        $map[$this->pk] = I('get.id',0);
        $map['uid'] = $this->uid;
        if($this->model->where($map)->delete()){
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败！");
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：加入购物车
     */
    public function add_cart(){
        $post = I('post.'); 

        if($post['nub']<=0){
            retJson("404","购买数量必须大于1！");
        }

        //获取该SKU的价格,顺便判断sku数据有效性
        $sku = D('commodity')->get_attr($post['sku'],$post['id']);

        if($sku['stock'] == false){
            retJson("404","非法数据参数！");
        }

        $add['commodityid'] = $post['id'];
        $add['sku'] = $post['sku'];
        $add['shopid'] = $this->shopid;
        $add['uid'] = $this->uid;

        if($data = $this->model->where($add)->find()){
            //已经存在
            if(($data['nubs']+$post['nub']) > $sku['stock']){
                retJson("404","您不能购买更多！");
            }
            $save['nubs'] = array('exp','nubs+'.$post['nub']);
            $save['money'] = array('eq',$sku['attr_money']);
            if($this->model->where($add)->save($save)){
                retJson("200","添加成功！");
            }else{
                retJson("404","添加失败！");
            }
        }else{
//            $add['url'] = session('tuijian') ? session('tuijian') : 0;
            $add['nubs'] = $post['nub'];
            $add['skuid'] = $sku['bianma'];
            if($this->model->add($add)){
                $this->model->where($add)->setField('money',$sku['attr_money']);
                retJson("200","添加成功！");
            }else{
                retJson("404","添加失败！");
            }
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：购物车加减
     * @param int $type 1为减，2为加
     */
    public function change(){
        $get = I('get.');
        $map[$this->pk] = $get['id'];

        $data = $this->model->where($map)->find();//判断真实性
        if(!($data)){
            retJson("404","非法数据参数");
        }

        $sku = D('commodity')->get_attr($data['sku'],$data['commodityid']);//获取sku数据

        if($get['type'] == "1"){
            //减
            if($data['nubs'] >= 1){
                $this->model->where($map)->setDec('nubs');
            }
        }else{
            if($sku['stock'] < $data['nubs']+1){
                retJson("404","您无法购买更多！");
            }
            $this->model->where($map)->setInc('nubs');
        }
        retJson("200","操作成功！");
    }


}