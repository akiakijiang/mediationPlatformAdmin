<?php
namespace Admin\Model;
use Think\Model;
class CarriageModel extends Model {

    protected $_validate = array(

    );

    protected $_map = array(         

    );

    protected $_auto = array(

    );

    /**
     * 开发者：akiaki
     * 方法功能：获取该商家所有运费模版
     */
    public function get_all($id){
        $map['shopid'] = $id;
        return $this->where($map)->cache(C('REDIS_KEY').':carriage:'.$id,300)->field('carriageid,title')->select();
    }

    /**
     * 开发者：akiaki
     * 方法功能：写入拓展表数据
     */
    protected function _after_insert($data, $options){
        $post = I('post.');
        $M = M('carriage_extend');
        $province = $post['takeprovince'];
        $price = $post['price2'];
        foreach ($province as $k => $v) {
            $add[] = array(
                'carriageid' => $data['carriageid'],
                'takeprovince' => $province[$k],
                'price' => $price[$k]
            );
        }
        $M->addAll($add);
    }


    protected function _after_update($data, $options){
        $M = M('carriage_extend');
        $map['carriageid'] = $data['carriageid'];
        $M->where($map)->delete();
        $post = I('post.');
        $province = $post['takeprovince'];
        $price = $post['price2'];
        foreach ($province as $k => $v) {
            $add[] = array(
                'carriageid' => $data['carriageid'],
                'takeprovince' => $province[$k],
                'price' => $price[$k]
            );
        }
        $M->addAll($add);
    }

}