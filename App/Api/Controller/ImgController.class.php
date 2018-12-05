<?php
namespace Api\Controller;

use Api\Controller\PublicController;
use Think\Controller;

class ImgController extends PublicController
{

    public function _initialize()
    {
        parent::_initialize();
    }

    public function uploadImg()
    {
        if (!IS_POST) {
            errReturn('500', '非法请求');
        }

        $data = $_FILES;

        $file = $data['file'];



        if (!$file) {
            errReturn('500', '请上传图片');
        }

        $upload_res = D("Img", "Logic")->singleUpload($file);

        if ($upload_res['status'] != 200) {
            errReturn($upload_res['status'], $upload_res['info']);
        }

        succReturn($upload_res['data']);
    }
}