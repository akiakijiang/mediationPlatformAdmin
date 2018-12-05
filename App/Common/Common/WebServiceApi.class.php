<?php

class WebServiceApi
{
    protected $key = "YIFBZ-3KY3F-BMNJ5-JH4AX-SLBQT-GNFLY";

    protected $_url = "https://apis.map.qq.com/ws/geocoder/v1/?";

    public function getLatLngByAddress($address)
    {
        if (empty($address)) {
            return ['status' => 501, 'info' => '请上传地址', 'data' => []];
        }

        $address = trim($address);
        $url = $this->_url . "address=" . $address . "&key=" . $this->key;

        $res = getHttpResponseGET($url);

        if (!$res) {
            return ['status' => 500, 'info' => 'webapi出错', 'data' => []];
        }

        $res_arr = json_decode($res, true);

        if ($res_arr['status'] != 0) {
            return ['status' => $res_arr['status'], 'info' => $res_arr['message'], 'data' => []];
        }

        return ['status' => 200, 'info' => 'ok', 'data' => $res_arr['result']['location']];

    }


}