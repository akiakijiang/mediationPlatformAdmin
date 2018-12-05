<?php
namespace Admin\Model;
use Think\Model\RelationModel;
class ClassifyModel extends RelationModel {

    protected $redis;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected $_validate = array(
        array('pid','checklevel','最多添加3层分类',0,'callback'), // 自定义函数验证密码格式
    );

    protected $_map = array(

    );

    protected $_auto = array(
        array('ico','setImg',3,'callback'),
        array('level','setlevel',1,'callback'),
    );

    /**
     * 开发者：akiaki
     * 方法功能：判断是否超过3层
     */
    protected function checklevel(){
        $post = I('post.');
        $map['classifyid'] = $post['pid'];
        if($this->where($map)->getField('level') == 3){
            return false;
        }else{
            return true;
        }
    }

    /**
     * 开发者：akiaki
     * 方法功能：判断等级
     */
    protected function setlevel(){
        $post = I('post.');
        if($post['pid'] == 0){
            return 1;
        }else{
            $map['classifyid'] = $post['pid'];
            if($this->where($map)->getField('pid') == 0){
                return 2;
            }else{
                return 3;
            }
        }


    }

    /**
     * 开发者：akiaki
     * 方法功能：设置缩略图
     */
    protected function setImg(){
        if($_FILES['suolvetu']['name'] != ""){//上传不为空，则调用上传
            $ret = upload();
            if(!is_array($ret)){
                retJson("404",$ret);
            }else{
                $this->info = $ret;
                $path = "/Uploads/".$ret['suolvetu']['savepath'].$ret['suolvetu']['savename'];
                return $path;

            }
        }else{
            return I('post.suo2');//返回已经上传的图
        }
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取所有分类
     */
    public function get_all($shopid){
        $map['shopid'] = $shopid;
        $map['pid'] = 0;
        $first = $this->where($map)->select();//获取所有一级分类
        foreach ($first as $k => $v){
            $temp[] = $v;
            $map['pid'] = $v['classifyid'];
            $seconde = $this->where($map)->select();//获取二级菜单
            foreach ($seconde as $k1 => $v1){
                $temp[] = $v1;
                $map['pid'] = $v1['classifyid'];
                $three = $this->where($map)->select();//获取三级菜单
                foreach ($three as $k2 => $v2){
                    $temp[] = $v2;
                }
            }
        }
        return $temp;
    }

    /**
     * 开发者：akiaki
     * 方法功能：获取首页显示的8个分类
     * @param $shopid  店铺ID
     */
    public function get_index_class($shopid){
        $map['shopid'] = $shopid;
        $map['pid'] = 0;
        $map['isshow'] = 1;
        $data = $this->where($map)->cache(C('REDIS_KEY').":classify:index:".$shopid,300)->order('sort+1 desc')->select();
        foreach ($data as $k => $v){
            $data[$k]['ico'] = C('CDN_PATH').$v['ico'];
        }
        return $data;
    }

}