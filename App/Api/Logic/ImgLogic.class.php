<?php
namespace Api\Logic;

use Think\Model;

class ImgLogic extends Model
{
    protected $autoCheckFields = false;

    public function singleUpload($file, $width = "500")
    {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->savePath  =      ''; // 设置附件上传目录    // 上传文件
        $info   =   $upload->uploadOne($file);

        if (!$info) {
            return ['status' => 500, 'info' => $upload->getError(), 'data' => []];
        }

        $path = "Uploads/" . $info['savepath'] . $info['savename'];

        $this->dealImg($path, $width);

        $data['pic_url'] = $path;

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }


    public function dealImg($path, $width)
    {
        $image = new \Think\Image();
        $image->open($path);
        $image->thumb($width,$width)->save($path);
    }


}