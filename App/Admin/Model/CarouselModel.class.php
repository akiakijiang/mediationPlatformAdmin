<?php
namespace Admin\Model;
use Think\Cache\Driver\Hredis;
use Think\Model\RelationModel;
class CarouselModel extends RelationModel {

    protected $redis;

    public function __construct($name, $tablePrefix, $connection)
    {
        parent::__construct($name, $tablePrefix, $connection);
        $this->redis = new Hredis();
    }

    protected $_validate = array(

    );

    protected $_map = array(

    );

    protected $_auto = array(
        array('carouselimg','setImg',3,'callback'),
    );

    protected $_link = array(
        'extend' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'carousel_extend',
            'foreign_key'  => 'position',
            'mapping_fields' => 'name'
        ),
    );

    /**
     * 开发者：huangwei
     * 方法功能：设置缩略图
     */
    protected function setImg(){
        if($_FILES['suolvetu']['name'] != ""){//上传不为空，则调用上传
            $upload = new \Think\Upload();// 实例化上传类
            $upload->maxSize   =     3145728 ;// 设置附件上传大小
            $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
            $upload->savePath  =      ''; // 设置附件上传目录    // 上传文件
            $info   =   $upload->upload();
            if(!$info) {// 上传错误提示错误信息
                retJson("404",$upload->getError());
            }else{// 上传成功
                $this->info = $info;
                $path = "/Uploads/".$info['suolvetu']['savepath'].$info['suolvetu']['savename'];
                return $path;
            }
        }else{
            return I('post.suo2');//返回已经上传的图
        }
    }

    /**
     * 开发者：huangwei
     * 方法功能：获取所有轮播
     * @param $id  店铺ID
     *
     * @return mixed
     */
    public function get_all($id){
        $key = C('REDIS_KEY').":carousel";
        if(!$this->redis->exists($key)){
            $map['shopid'] = $id;
            $data = $this->where($map)->field('position,carouselimg,url')->select();
            foreach ($data as $k => $v ){
                $data[$k]['carouselimg'] = C('CDN_PATH').$data[$k]['carouselimg'];
            }
            $this->redis->set($key,json_encode($data));
            $this->redis->expire($key);
        }else{
            $data = $this->redis->get($key);
        }
        return $data;
    }


}