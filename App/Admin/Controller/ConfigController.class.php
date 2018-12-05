<?php
namespace Admin\Controller;
use Think\Cache\Driver\Hredis;
use Think\Controller;
class ConfigController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('weixin_config');
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 开发者：huangwei
     * 方法功能：编辑页面
     */
    public function edit(){
        $map['shopid'] = $this->shopid;
        $config = $this->model->where($map)->select();
        $this->assign('config',$config);
        $this->display();
    }

    /**
     * 开发者：huangwei
     * 方法功能：修改配置
     */
    public function handle(){
        $redis = new Hredis();
        $redis_key = C('REDIS_KEY').":config";//配置键
        $data = I('post.');
        $key = array_keys($data);

        $this->model->startTrans();
        $map['shopid'] = $this->shopid;
        $map['name'] = "site_logo";

//        $data['silver'] = 200000000;
//        $data['gold']   = 200000000;

        if(!empty($_FILES['site_logo']['name'])){//上传不为空，则调用上传
            $ret = upload();
            if(!is_array($ret)){
                retJson("404",$ret);
            }else{
                $path = "/Uploads/".$ret['site_logo']['savepath'].$ret['site_logo']['savename'];
            }
            $this->model->where($map)->setField('value',$path);
            $redis->hset($redis_key,"site_logo",$path);//改用hash存储
        }


        foreach ($key as $k => $v){
            $map['name'] = $v;
            if($v != "site_logo" || $v != "appid" || $v != "secret"){
                if($this->model->where($map)->setField('value',$data[$v]) === false){
                    $this->model->rollback();
                    retJson("404","修改失败！");
                }
                $redis->hset($redis_key,$v,$data[$v]);//改用hash存储
            }
        }
//        var_dump($data);die;
        $this->model->commit();
        retJson("200","修改成功！");
    }

}