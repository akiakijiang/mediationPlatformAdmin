<?php

    /**
     * [arraySortByKey 数组重新索引]
     * @param  array   $array [description]
     * @param  [type]  $key   [description]
     * @param  boolean $asc   [description]
     * @return [type]         [description]
     */
    function arraySortByKey(array $array, $key, $asc = true){
        $result = array();
        // 整理出准备排序的数组
        foreach ( $array as $k => &$v ) {
            $values[$k] = isset($v[$key]) ? $v[$key] : '';
        }
        unset($v);
        // 对需要排序键值进行排序
        $asc ? asort($values) : arsort($values);
        // 重新排列原有数组
        foreach ( $values as $k => $v ) {
            $result[$k] = $array[$k];
        }
      return $result;
    }

    /**
     * 获取某一时间段内所有日期
     */
    function get_all_day($end,$start){
        $days = (strtotime($end)-strtotime($start))/3600/24;
        $start_day = $start;
        $arr=array();
        for($i=0;$i<$days;$i++)
        {
            $arr[]=date('Y-m-d',strtotime($start_day)+$i*24*60*60);
        }
        return $arr;
    }




    /**
     * 开发者：akiaki
     * 方法功能：生产短链接
     * @param $surl
     *
     * @return mixed
     */
    function get_duan_url($surl){
        $ch = curl_init();
        $url = 'http://apis.baidu.com/3023/shorturl/shorten?url_long='.urlencode($surl);
        $header = array(
            'apikey: 28ed820c8b04b7e623fe8a9fe9812ed2',
        );
        // 添加apikey到header
        curl_setopt($ch, CURLOPT_HTTPHEADER  , $header);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // 执行HTTP请求
        curl_setopt($ch , CURLOPT_URL , $url);
        $res = curl_exec($ch);
        $res = json_decode($res,true);
        return $res['urls'][0]['url_short'];
    }


    function downloadweixinfile($url){
        $ch = curl_init($url);
        curl_setopt($ch,CURLOPT_HEADER,0);
        curl_setopt($ch,CURLOPT_NOBODY,0);
        curl_setopt($ch, CURLOPT_TIMEOUT,60);
        curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,FALSE);
        curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,FALSE);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        $package = curl_exec($ch);
        $curl_errno = curl_errno($ch);
        $httpinfo = curl_getinfo($ch);
        curl_close($ch);
        if($curl_errno >0){
            return "404";
        }
        return $package;
    }

    function saveweixinfile($filename,$filecontent){
        $local_file = fopen($filename,'w');
        if(false !== $local_file){
            if(false !== fwrite($local_file,$filecontent)){
                fclose($local_file);
            }
        }
    }

    function resizeImage($im,$maxwidth,$maxheight,$name,$filetype)
    {
        $pic_width = imagesx($im);
        $pic_height = imagesy($im);

        if(($maxwidth && $pic_width > $maxwidth) || ($maxheight && $pic_height > $maxheight))
        {
            if($maxwidth && $pic_width>$maxwidth)
            {
                $widthratio = $maxwidth/$pic_width;
                $resizewidth_tag = true;
            }

            if($maxheight && $pic_height>$maxheight)
            {
                $heightratio = $maxheight/$pic_height;
                $resizeheight_tag = true;
            }

            if($resizewidth_tag && $resizeheight_tag)
            {
                if($widthratio<$heightratio)
                    $ratio = $widthratio;
                else
                    $ratio = $heightratio;
            }

            if($resizewidth_tag && !$resizeheight_tag)
                $ratio = $widthratio;
            if($resizeheight_tag && !$resizewidth_tag)
                $ratio = $heightratio;

            $newwidth = $pic_width * $ratio;
            $newheight = $pic_height * $ratio;

            if(function_exists("imagecopyresampled"))
            {
                $newim = imagecreatetruecolor($newwidth,$newheight);//PHP系统函数
                imagecopyresampled($newim,$im,0,0,0,0,$newwidth,$newheight,$pic_width,$pic_height);//PHP系统函数
            }
            else
            {
                $newim = imagecreate($newwidth,$newheight);
                imagecopyresized($newim,$im,0,0,0,0,$newwidth,$newheight,$pic_width,$pic_height);
            }

            $name = $name.$filetype;
            imagejpeg($newim,$name);
            imagedestroy($newim);
        }
        else
        {
            $name = $name.$filetype;
            imagejpeg($im,$name);
        }
    }




    function succReturn($data=[], $msg='OK', $code='200')
    {
        header('Content-Type:application/json; charset=utf-8');
        $res['code'] = $code;
        $res['msg']  = $msg;
        $res['data'] = $data;
        exit(json_encode($res));
    }

    function errReturn($code='500', $msg="服务故障，稍后重试", $data=[])
    {
        succReturn($data, $msg, $code);
    }


    /**
    * @param $lon1
    * @param $lat1
    * @param $lon2
    * @param $lat2
    * @return float|int
     * 计算距离
    */
    function getdistance($lon1, $lat1, $lon2, $lat2)
    {
        $DEF_PI180 = 0.01745329252; // PI/180.0
        $DEF_R = 6370693.5; // radius of earth in meters
        // 角度转换为弧度
        $radLng1 = floatval($lon1) * $DEF_PI180;
        $radLat1 = floatval($lat1) * $DEF_PI180;
        $radLng2 = floatval($lon2) * $DEF_PI180;
        $radLat2 = floatval($lat2) * $DEF_PI180;

        $distance = 2 * asin(sqrt(pow(sin(($radLat1 - $radLat2) / 2), 2) + cos($radLat1) * cos($radLat2) * pow(sin(($radLng1 - $radLng2) / 2), 2))) * $DEF_R;
        return $distance;
    }

    function checkIsPhone($phone)
    {
        if (preg_match("/^1[345678]{1}\d{9}$/", $phone)) {
            return true;
        } else {
            return false;
        }
    }


    function getHttpResponseGET($url)
    {
        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_HEADER, 0); // 过滤HTTP头
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);// 显示输出结果
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);//SSL证书认证
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);//严格认证
        $response = curl_exec($curl);
        curl_close($curl);
        return $response;
    }

    function httpRequest($url, $data = null)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        if (!empty($data)){
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($curl);
        if($output === FALSE ){
            return false;
        }
        curl_close($curl);
        return json_decode($output,JSON_UNESCAPED_UNICODE);
    }

