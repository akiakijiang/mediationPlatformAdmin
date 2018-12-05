<?php
    include "TopSdk.php";
    date_default_timezone_set('Asia/Shanghai');

    define("APPKEY","23538560");
    define("SECRET","635ed991e9d8fa97a72608fcfe12b807");

    /**
     * 注册openim帐号
     */
    function reg($account,$nick){
        $c = new TopClient;
        $c->appkey = APPKEY;
        $c->secretKey = SECRET;
        $req = new OpenimUsersAddRequest;
        $userinfos = new Userinfos;
        $userinfos->nick=$nick;
        $userinfos->icon_url="http://xxx.com/xxx";
        $userinfos->email="uid@taobao.com";
        $userinfos->mobile="18600000000";
        $userinfos->taobaoid="tbnick123";
        $userinfos->userid=$account;
        $userinfos->password="123456";
        $userinfos->remark="demo";
        $userinfos->extra="{}";
        $userinfos->career="demo";
        $userinfos->vip="{}";
        $userinfos->address="demo";
        $userinfos->name="demo";
        $userinfos->age="123";
        $userinfos->gender="M";
        $userinfos->wechat="demo";
        $userinfos->qq="demo";
        $userinfos->weibo="demo";
        $req->setUserinfos(json_encode($userinfos));
        $resp = $c->execute($req);
    }

    /**
     * 开发者 ： huangwei
     * 方法功能:读取商品信息
     */
    function read_goods(){
        $c = new TopClient;
        $c->appkey = APPKEY;
        $c->secretKey = SECRET;
        $req = new ItemSellerGetRequest;
        $req->setFields("num_iid,title,nick,price,approve_status,sku");
        $req->setNumIid("123456789");
        $resp = $c->execute($req, $sessionKey);
    }

?>