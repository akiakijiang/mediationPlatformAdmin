<?php
namespace Home\Controller;
use Think\Cache\Driver\Hredis;
use Think\Controller;
class GoodsController extends Controller {

    protected $shopid;
    protected $uid;
    protected $model;
    protected $pk;
    static public $treeList = array();

    public function  _initialize(){
        $this->shopid = session('shopid');
        $this->uid = session('user.id');
        $this->model = D('commodity');
        $this->pk = $this->model->getPk();
    }


    public function index(){
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：查看商品详情
     */
    public function detail(){
        //session('user',M('user')->where(array('id'=>"28"))->find());//电脑模拟登录

        //if(is_null($this->uid)){
        //    redirect('/Home/weixin/login/?url='.urlencode(__SELF__));//跳转到登录
        //}

        $get = I('get.');
        //判断是否存在分享
        if(!is_null($get['fromto'])){
            session('tuijian',$get['fromto']);//下单的时候根据该值判断分成情况
            $from = explode("|",base64_decode($get['fromto']));
            if(count($from)== 3){
                //对数组进行删除第一个，增加当前用户ID
                unset($from[0]);
            }
            array_push($from,$this->uid);
        }else{
            //干净的页面无分享
            if(is_null(session('tuijian'))){
                $from = array(0,0,$this->uid);
            }else{
                $from = explode("|",base64_decode(session('tuijian')));
            }
        }

        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $data = $this->model->get_goods($id);                               //获取商品数据,根据商品判断属于哪家店铺
        $data['size'] = $this->model->get_stock($id); //获取总库存值
        $data['carriage'] = $this->model->get_default_carriage($data['carriageid']);
        session('shopid',$data['shopid']);
        $data['carrousel']  = json_decode($data['carrousel']);
        $data['islove']     = D('love')->is_love($data['commodityid']);     //判断商品是否收藏
        $data['tuijian']    = $this->model->get_tuijian($id);             //获取三个随机商品


        $url = "http://shop.sunday.so/Home/goods/detail?id=".$id."&fromto=".base64_encode(implode("|",$from));

        $sku = D('commodity_sku')->where($map)->field('shuxingji')->find();
        $js = A('weixin')->getjs();                                         //获取微信的分享
        $jsconfig = $js->config(array('onMenuShareAppMessage','onMenuShareTimeline', 'onMenuShareWeibo','getLocation'), false);

        $this->assign('jssdk',$jsconfig);
        $this->assign('data',$data);
        $this->assign('url',$url);
        $this->assign('shuxingji',$sku['shuxingji']);
        $this->display();
    }

    public function dd(){
        dump("http://shop.sunday.so/Home/goods/detail?id=7&fromto=".base64_encode(implode("|",array("0","24","15"))));
    }

    /**
     * 开发者：akiaki
     * 方法功能：商品评价页面
     */
    public function comment(){
        $id = I('get.id',0);//商品ID
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $comment = D('commodity_comment')->where(array('commodityid'=>$id))->relation(true)->order('time desc')->limit(($page-1)*$size,$size)->select();//获取评论数据

        if(IS_AJAX){
            if(count($comment)>0){
                $this->ajaxReturn(json_encode($comment,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }

        $map[$this->pk] = $id;
        $data = $this->model->get_goods($id);//获取商品数据
        $data['islove']     = D('love')->is_love($id);//判断商品是否收藏
        $sku = D('commodity_sku')->where($map)->field('shuxingji')->find();

        $this->assign('data',$data);
        $this->assign('comment',$comment);
        $this->assign('shuxingji',$sku['shuxingji']);
        $this->display();
    }




    /**
     * 开发者：akiaki
     * 方法功能：新品推荐，按时间排序
     */
    public function xinpin(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $map['shopid'] = $this->shopid;
        $map['type'] = 1;
        $map['status'] = 1;
        $data = D('commodity')->where($map)->limit(($page-1)*$size,$size)->field('thumbnail,title,commodityid,original,current')->select();
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：积分商城
     */
    public function jifen(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $map['shopid'] = $this->shopid;
        $map['type'] = 2;
        $data = D('commodity')->where($map)->limit(($page-1)*$size,$size)->field('thumbnail,title,commodityid,original,current')->select();
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }
        $this->assign('data',$data);
        $this->display();
    }

    public function detail_jifen(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $data = $this->model->get_goods($id);                               //获取商品数据,根据商品判断属于哪家店铺
        session('shopid',$data['shopid']);

        $data['carrousel']  = json_decode($data['carrousel']);

        $sku = D('commodity_sku')->where($map)->field('shuxingji')->find();

        $this->assign('data',$data);
        $this->assign('shuxingji',$sku['shuxingji']);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：搜索详情页
     */
    public function lists(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        if(!is_null($get['keyword'])){
            $map['title'] = array('like',"%".$get['keyword']."%");
        }

        if(!is_null($get['id'])){
            $map['classifyid'] = $get['id'];
        }
        $map['status'] = 1;
        $map['type'] = 1;

        $data = $this->model->where($map)->select();
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn(json_encode($data,JSON_UNESCAPED_UNICODE));
            }else{
                $this->ajaxReturn("0");
            }
        }

        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取属性值的价格和库存
     */
    public function get_attr(){
        $post = I('post.');
        $data = $this->model->get_attr($post['sku'],$post['id']);
        $this->ajaxReturn($data);
    }

    /**
     * 开发者：akiaki
     * 方法功能：商品搜索页面
     */
    public function search(){
        //键名  sx:classify:shopid
        $redis = new Hredis();
        $key = "sx:classify:".$this->shopid;
        if(!$redis->exists($key)){//判断是否存在缓存
            $class = D('classify');
            $map['shopid'] = $this->shopid;
            $map['pid'] = 0;
            $first = $class->where($map)->field('classifyid,name')->select();//获取所有一级分类
            foreach ($first as $k => $v){
                $map['pid'] = $v['classifyid'];
                $seconde = $class->where($map)->field('classifyid,name')->select();//获取二级菜单
                foreach ($seconde as $k1 => $v1){
                    $first[$k]['child'][$k1] = $v1;
                    $map['pid'] = $v1['classifyid'];
                    $three = $class->where($map)->field('classifyid,name')->select();//获取三级菜单
                    foreach ($three as $k2 => $v2){
                        $first[$k]['child'][$k1]['chlid'][$k2] = $v2;
                    }
                }
            }

            $redis->set($key,$first);
            $redis->expire($key);//设置有效期，默认300秒
        }else{
            $first = $redis->get($key);
        }

        $this->assign('data',$first);
        $this->display();
    }

    private function tree($data,$pid = 0,$count = 1) {
        foreach ($data as $key => $value){
            if($value['pid']==$pid){
                $value['Count'] = $count;
                self::$treeList []= $value;
                unset($data[$key]);
                $this->tree($data,$value['classifyid'],$count+1);
            }
        }
        return self::$treeList;
    }
}