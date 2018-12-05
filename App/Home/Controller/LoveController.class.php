<?php
namespace Home\Controller;
use Think\Controller;
class LoveController extends Controller {

    /**
     * 集合名称 love:店铺ID:用户ID
     * @var
     */

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('love');
        $this->pk = $this->model->getPk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：添加商品收藏
     */
    public function add(){
        $post = I('post.');
        $add['commodityid'] = $post['commodityid'];
        $add['shopid'] = $this->shopid;
        $add['uid'] = $this->uid;

        if($this->model->add($add)){
            $this->model->redis->sAdd(C('REDIS_KEY').":love:".$this->shopid.":".$this->uid,$add['commodityid']);
            retJson("200","收藏成功！");
        }else{
            retJson("404","收藏失败！");
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：用户收藏详情页
     */
    public function index(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $map['shopid'] = $this->shopid;
        $map['uid'] = $this->uid;
        $data = $this->model->where($map)->limit(($page-1)*$size,$size)->relation(true)->order('loveid desc')->select();
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
     * 方法功能：删除收藏
     */
    public function del(){
        $id = I('get.id',0);
        $cid = I('get.cid',0);

        if($id == 0){
            //商品详情页取消
            $map['shopid'] = $this->shopid;
            $map['commodityid'] = $cid;
        }else{
            $map[$this->pk] = $id;
        }
        $map['uid'] = $this->uid;

        if($data = $this->model->where($map)->find()){
            if($this->model->where($map)->delete()){
                $key = C('REDIS_KEY').":love:".$this->shopid.":".$this->uid;
                $this->model->redis->sRem($key,$data['commodityid']);
                retJson("200","删除成功！");
            }else{
                retJson("404","删除失败！");
            }
        }else{
            retJson("404","删除失败！");
        }
    }


}