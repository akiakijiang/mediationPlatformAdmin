<?php
namespace Admin\Controller;
use Think\Controller;
use EasyWeChat\Foundation\Application;
class MenuController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Menu');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：akiaki
     * 方法功能：编辑页面
     */
    public function edit(){
        $map['shopid'] = $this->shopid;
        $map['pid'] = 0;
        $menu = $this->model->where($map)->select();//获取一级分类
        foreach ($menu as $k => $v){
            $temp[] = $v;
            $map['pid'] = $v['menuid'];
            $seconde = $this->model->where($map)->select();//获取二级菜单
            foreach ($seconde as $k1 => $v1){
                $temp[] = $v1;
            }
        }
        $this->assign('data',json_encode($temp));
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：保存菜单
     */
    public function save(){
        $post = I('post.');
        $add['shopid'] = $this->shopid;
        $add['pid'] = $post['data']['pid'];
        $add['level'] = $post['data']['level'];
        $add['name'] = $post['data']['name'];
        $add['sort'] = $post['data']['sort'];
        $add['value'] = $post['data']['value'];
        if($post['data']['menuid'] != 0){
            if($this->model->where(array('menuid'=>$post['data']['menuid']))->save($add) !== false){
                retJson("200",$post['data']['menuid']);//返回pid
            }else{
                retJson("400","操作失败！");
            }
        }else{
            if($res = $this->model->add($add)){
                retJson("200",$res);//返回pid
            }else{
                retJson("400","操作失败！");
            }
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：删除微信菜单
     */
    public function del(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;

        if($this->model->where(array('pid'=> $id))->find()){
            retJson("404","请先删除下级菜单！");
        }

        if($this->model->where($map)->delete()){
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败！");
        }

    }

    /**
     * 开发者：huangwei
     * 方法功能：更新微信自定义菜单
     */
    public function update(){
        $map['shopid'] = $this->shopid;
        $config = M('weixin_config')->where($map)->field('shopid',true)->select();//获取当前店铺的配置

        foreach ($config as $k => $v){
            if($v['name'] == "appid"){
                $options['app_id'] = $v['value'];
            }elseif($v['name'] == "secret"){
                $options['secret'] = $v['value'];
            }elseif($v['name'] == "token"){
                $options['token'] = $v['value'];
            }
        }

        $app = new Application($options);
        $menu = $app->menu;

        $map['pid'] = 0;
        $one = $this->model->where($map)->order('sort desc')->select();

        foreach ($one as $k => $v){
            $map['pid'] = $v['menuid'];
            $second = $this->model->where($map)->select();
            if(count($second)>0){
                $menu_data[$k]['name'] = $v['name'];
                foreach ($second as $k1 => $v1){
                    $menu_data[$k]['sub_button'][$k1] = array(
                        "type" => "view",
                        "name" => $v1['name'],
                        "url"  => C('SITE_PATH')."Home/weixin/login/?url=".urlencode($v1['value']),
                    );
                }

            }else{
                $menu_data[$k] = array(
                    "type" => "view",
                    "name" => $v['name'],
                    "url"  => C('SITE_PATH')."Home/weixin/login/?url=".urlencode($v['value']),
                );
            }
        }

        $res = $menu->add($menu_data);
        $res = json_decode($res,true);
        if($res['errmsg'] == "ok"){
            retJson("200","更新菜单成功！");
        }else{
            retJson("404","更新菜单失败！");
        }
    }

}