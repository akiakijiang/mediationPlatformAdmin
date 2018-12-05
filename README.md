## 智慧舰

## 配置

* ./App/Common/Conf/config.php
    * DB_NAME       //数据库名
    * SITE_PATH     //域名地址
    * REDIS_KEY     //redis键前缀
    * KEFU          //客服帐号前缀
    * CDN_PATH      //如果没有开启cdn，配置和SITE_PATH一样即可，否则出错


* 分页路径（动态配置）
    * ./ThinkPHP/Library/Think/Page.class.php
        public $site ; //跳转路径
        __construct
            $this->site = C('SITE_PATH');

* 二维码网址
    * ./App/Admin/View/Commodity/code.html
        修改网址

* 数据表weixin_config

* redis缓存时间（为了加快调试时间）
    * ./ThinkPHP/Library/Think/Cache/Driver/Hredis.class.php
        expire()方法

* 商城服务器里，qiuiqu的微商城要加redis身份验证配置
    * ./App/Common/Conf/config.php 添加配置信息
        'REDIS_AUTH'        => "baimifan!@#",
    * ./ThinkPHP/Library/Think/Cache/Driver/Hredis.class.php
        * __construct()方法下，更新下列代码
            $options = array_merge(array (
                        'host'          => C('REDIS_HOST') ? : '127.0.0.1',
                        'port'          => C('REDIS_PORT') ? : 6379,
                        'auth'          => C('REDIS_AUTH') ? : null,
                        'timeout'       => C('DATA_CACHE_TIMEOUT') ? : false,
                        'persistent'    => false,
            ),$options);
            $options['auth'] != false? $this->handler->auth($options['auth']):'';//连接的最后，进行身份验证

* 商城服务器里，配置路由
    'URL_MODULE_MAP'       => [
        'admin' => 'Admin',
        'index'  => 'Home',
    ],

* 阿里百川客服
    * ./ThinkPHP/Library/Vendor/taobao/index.php
        APPKEY
        SECRET
    * ./App/Home/View/User/kefu.html
        appkey          //AppKey
        touid           //在百川控制台设置的E客服账号
    * ./App/Home/Controller/WeixinController.class.php
        打开以下代码的注释
        //A('user')->reg($res,$this->user->getNickname());//注册聊天方法
        //M('user')->where(array('id'=>$res))->setField('chatid',C('KEFU').$res);
        //$add['chatid'] = C('KEFU').$res;

* 微信支付
    * 下载证书
        ./Uploads/sanxian/

* 微信消息模板
    * ./App/Home/Controller/WeixinController.class.php
        * send_message_fahuo()方法
        物流状态更新通知 IT科技	互联网|电子商务
        在微信公众平台根据条件查找并添加模板，将模板ID写入 $templateId 中

        * send_message_money()方法
        提现审核结果通知 IT科技	互联网|电子商务
        在微信公众平台根据条件查找并添加模板，将模板ID写入 $templateId 中

        * send_message_buy()方法
        购买成功通知 消费品	消费品
        在微信公众平台根据条件查找并添加模板，将模板ID写入 $templateId 中

* 启用后下单价格改为真实价格
    * ./App/Home/Controller/OrderController.class.php
        set_order_from_detail()方法
        set_order_from_cart()方法
        生成微信支付订单处，将0.01改为运费加订单总价
        即：$order['carriage']*1+$order['money']*1

* 首页初始化数据
    [[{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""}],[{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""}],[{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""},{"thumbnail":"","title":"","current":"","original":"","commodityid":""}]]
