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
     * 开发者：huangwei
     * 方法功能：查看商品详情
     */
    public function detail(){
        if(is_null($this->uid)){
            redirect('/Home/weixin/login/?url='.urlencode(__SELF__));//跳转到登录
        }

        $get = I('get.');
        $id = $get['id'];
        if($id<1){
            $this->assign('text',"缺少必要参数！");
            $this->display('Public/error');
            exit();
        }
        $userdata = D('user')->get_one($this->uid,array('isbuy','type','first','second','three','isfix'));
        if($userdata['isfix'] != "1"){
            //未确定关系
            if(!is_null($get['fromto'])){
                $from = explode("|",base64_decode($get['fromto']));
                //此处判断链接有效性，如果有一个链接作弊，全部失效
                if(!D('user')->auth($this->uid,$from)){
                    $save['first'] = 0;
                    $save['second'] = 0;
                    $save['three'] = 0;
                }else{
                    $save['first'] = $from[2];
                    $save['second'] = $from[1];
                    $save['three'] = $from[0];
                }
                $save['isfix'] = 1;
            }else{
                $save['first'] = 0;
                $save['second'] = 0;
                $save['three'] = 0;
                $save['isfix'] = 1;
            }
            D('user')->save_one($this->uid,$save);
        }

        //type为1有推广权限，
        if($userdata['type'] == "1"){
            $level = array_reverse(array($userdata['first'],$userdata['second'],$userdata['three']));//获取用户层级关系
            unset($level[0]);
            array_push($level,$this->uid);
            $url = C('SITE_PATH')."Home/goods/detail?id=".$id."&fromto=".base64_encode(implode("|",$level));//生成分享url
        }else{
            $url = "";//无推广权限
        }

        $map[$this->pk] = $id;
        $data = $this->model->get_goods($id);                               //获取商品数据,根据商品判断属于哪家店铺
        session('shopid',$data['shopid']);
        if($data['commodityid'] == false){
            $this->assign('text',"该商品已经下架或者被删除！");
            $this->display('Public/error');
            exit();
        }
        $data['size'] = $this->model->get_stock($id); //获取总库存值
        $data['carriage'] = $this->model->get_default_carriage($data['carriageid']);
//        echo $data['carriageid'];exit;

        $data['carrousel']  = json_decode($data['carrousel']);
        $data['islove']     = D('love')->is_love($data['commodityid']);     //判断商品是否收藏
        $data['tuijian']    = $this->model->get_tuijian();             //获取三个随机商品

//        echo '<pre>';
//        var_dump($data['tuijian']);
//        exit;
        $data['content'] = htmlspecialchars_decode($data['content']);
        preg_match_all("/<img(.*)src=\"([^\"]+)\"[^>]+>/isU",$data['content'],$matches);

        foreach ($matches[2] as $k => $v){
            $data['content'] = str_replace($v,C('CDN_PATH').$v,$data['content']);
        }//将文章内的图片链接更新为CDN的域名链接

        $sku = D('commodity_sku')->where($map)->field('shuxingji')->find();
        $js = A('weixin')->getjs();                                         //获取微信的分享
        $jsconfig = $js->config(array('onMenuShareAppMessage','onMenuShareTimeline', 'onMenuShareWeibo','getLocation'), false);
        $phone= 'phone';
        $tel=M('weixin_config')->where(["name"=>$phone])->field('value')->find();
//        dump($data['huohao']);exit;
//        $data['huohao']=explode("-",$data['huohao']);
        $datas=file_get_contents("https://epeijing.cn/api/call/try/getTryUrl?phone=13805758818&sn={$data['huohao']}");
        $shidai=json_decode($datas,true)['url'];
//        dump($shidai);exit;
        $this->assign('shidai',$shidai);
        $this->assign('tel',$tel);
        $this->assign('jssdk',$jsconfig);
        $this->assign('data',$data);
        $this->assign('url',$url);
        $this->assign('shuxingji',$sku['shuxingji']);
        $this->display();
    }

    public function jiekou(){

        $get=I('get.');
//        echo $get;die;
        $search=D('commodity')->where(["huohao"=>$get['huohao']])->getField('commodityid');
        $this->ajaxReturn(array(
            'goodsid' => $search
        ));
    }


    /**
     * 开发者：huangwei
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
     * 开发者：huangwei
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

//    public function shidai(){
//        $id=I('get.id');
//        $sd=M('commodity')->where(["id"=>$id])->field('huohao')->find();
//        var_dump($sd);
//        exit;
//        $this->assign('sd',$sd);
//        $this->display();
//    }

    /**
     * 开发者：huangwei
     * 方法功能：积分商品详情
     */
    public function detail_jifen(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $data = $this->model->get_goods($id);                               //获取商品数据,根据商品判断属于哪家店铺
        if($data['commodityid'] == false){//判断是否删除或者下架
            $this->assign('text',"该商品已经下架或者被删除！");
            $this->display('Public/error');
            exit();
        }
        session('shopid',$data['shopid']);

        $data['carrousel']  = json_decode($data['carrousel']);

        $sku = D('commodity_sku')->where($map)->field('shuxingji')->find();

        $this->assign('data',$data);
        $this->assign('shuxingji',$sku['shuxingji']);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：搜索详情页
     */
    public function lists(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        if(!is_null($get['keyword'])){
            $map['title'] = array('like',"%".$get['keyword']."%");
        }

        if(!is_null($get['id']) && $get['id'] != ""){
            $map['classifyid'] = $get['id'];
        }

        if($get['order']!=""){
            if($get['type'] == "1"){
                $order = $get['order']." desc";
            }else{
                $order = $get['order'];
            }
        }else{
            $order = "commodityid desc";
        }

        $map['status'] = 1;
        $map['type'] = 1;

        $data = $this->model->where($map)->limit(($page-1)*$size,$size)->order($order)->select();
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
     * 开发者：huangwei
     * 方法功能：获取属性值的价格和库存
     */
    public function get_attr(){
        $post = I('post.');
        $data = $this->model->get_attr($post['sku'],$post['id']);
        $this->ajaxReturn($data);
    }

    /**
     * 开发者：huangwei
     * 方法功能：商品搜索页面
     */
    public function search(){
        //键名  sx:classify:shopid
        $redis = new Hredis();
        $key = C('REDIS_KEY').":classify:".$this->shopid;
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

    /**
     * 开发者：huangwei
     * 方法功能：开始推广的商品
     */
    public function tglist(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;

        $map['shopid'] = $this->shopid;
        $map['type'] = 1;
        $map['status'] = 1;
        $data = D('commodity')->where($map)->limit(($page-1)*$size,$size)->field('thumbnail,title,commodityid,current,firstgraded,secondgraded,threegraded')->select();
        if(IS_AJAX){
            if(count($data)>0){
                $this->ajaxReturn($data);
            }else{
                $this->ajaxReturn("0");
            }
        }
        $this->assign('data',$data);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：新品推荐，按时间排序
     */
    public function xinpin(){
        $get = I('get.');
        $page    = $get['page'] ? intval($get['page']) : 1;
        $size    = $get['size'] ? intval($get['size']) : 6;
        if($get['order']!=""){
            if($get['type'] == "1"){
                $order = $get['order']." desc";
            }else{
                $order = $get['order'];
            }
        }else{
            $order = "commodityid desc";
        }

        $map['shopid'] = $this->shopid;
        $map['type'] = 1;
        $map['status'] = 1;
        $data = D('commodity')->where($map)->limit(($page-1)*$size,$size)->order($order)->field('thumbnail,title,commodityid,original,current')->select();

        foreach ($data as $k => $v){
            $data[$k]['thumbnail'] = C('CDN_PATH').$v['thumbnail'];
        }

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
}