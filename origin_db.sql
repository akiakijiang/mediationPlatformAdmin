-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Oct 31, 2018 at 07:28 PM
-- Server version: 5.7.23
-- PHP Version: 5.6.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mediationPlatformAdmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `addressid` int(11) NOT NULL,
  `is_default` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常1默认',
  `uid` int(11) NOT NULL,
  `name` varchar(45) NOT NULL COMMENT '收货人',
  `phone` varchar(20) NOT NULL,
  `province` varchar(80) NOT NULL COMMENT '省市区',
  `city` varchar(20) NOT NULL,
  `district` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL COMMENT '具体地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`addressid`, `is_default`, `uid`, `name`, `phone`, `province`, `city`, `district`, `address`) VALUES
(2, 1, 257, '徐帅', '15861137280', '浙江', '杭州', '江干区', '下沙七格小区'),
(3, 0, 2, '徐帅', '15861137280', '北京', '东城区', '', '北京'),
(4, 0, 1, '就回', '15858545552', '陕西', '西安', '莲湖区', '把 v 的地方解决'),
(5, 1, 7, '测试', '18758209999', '浙江', '杭州', '萧山区', '杭州湾信息港'),
(6, 1, 9, '333', '13776698052', '北京', '东城区', '', '日子'),
(7, 1, 12, '123', '123', '浙江', '杭州', '拱墅区', '123'),
(8, 1, 41, '减肥包括', '18857912613', '北京', '东城区', '', '吃就吃'),
(9, 1, 295, '李蕊', '15620952694', '浙江', '杭州', '萧山区', '启迪路198号'),
(10, 1, 356, '孙建娣', '15057147227', '浙江', '杭州', '萧山区', '闻堰街道社区卫生服务中心'),
(11, 0, 1, '奥术大师多 ', '15487411544', '浙江', '杭州', '滨江区', '驱蚊器二'),
(12, 1, 1, 'Asdasd', '444141445', '浙江', '杭州', '滨江区', '阿达'),
(16, 1, 384, '洪文扬', '13858126467', '浙江', '杭州', '滨江区', '杨家墩'),
(17, 1, 686, '马明忠', '17682448123', '浙江', '杭州', '下城区', '浙江省杭州天水巷9号西单元104室'),
(18, 1, 15, '谢治国', '15356185466', '浙江', '杭州', '萧山区', '信息港'),
(19, 1, 467, '俞可奕', '15858117214', '浙江', '杭州', '萧山区', '启迪路198号'),
(20, 1, 146, '孙原原', '18857912613', '浙江', '杭州', '萧山区', '经济技术开发区启迪路198号B1-506'),
(21, 1, 147, '吴菊菊', '18857912613', '浙江', '杭州', '萧山区', '启迪路198号'),
(22, 1, 703, '谢', '18855554444', '北京', '东城区', '', '哈哈'),
(23, 0, 703, '谢', '18855554444', '浙江', '杭州', '萧山区', '哈哈'),
(24, 1, 469, '旺旺', '15658874686', '浙江', '杭州', '拱墅区', '其实'),
(25, 1, 797, '孙原因', '1888888888', '浙江', '杭州', '萧山区', '经济技术开发区启迪路198号B1-506'),
(26, 1, 798, '燕', '15824495567', '浙江', '杭州', '萧山区', '启迪路198号'),
(27, 1, 53, '俞小红', '13777386829', '浙江', '杭州', '萧山区', '萧山区启迪路198号'),
(28, 1, 799, '汪先生', '15068843959', '浙江', '杭州', '萧山区', '杭州湾信息港'),
(29, 1, 638, 'q we', '13645280000', '浙江', '杭州', '拱墅区', '11'),
(30, 1, 967, '魏旭晖', '18317758760', '浙江', '杭州', '萧山区', '杭州湾信息港');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '昵称',
  `account` varchar(255) NOT NULL COMMENT '帐号',
  `password` varchar(80) NOT NULL COMMENT '密码',
  `group` tinyint(2) NOT NULL COMMENT '所属用户组'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `shopid`, `name`, `account`, `password`, `group`) VALUES
(21, 1, '订单管理', 'admin', '4297f44b13955235245b2497399d7a93', 3),
(35, 1, '客服2', '客服2', 'e10adc3949ba59abbe56e057f20f883e', 9),
(41, 1, '测试', '测试', '25f9e794323b453885f5181f1b624d0b', 11),
(44, 1, '占', 'zhan', '4297f44b13955235245b2497399d7a93', 3);

-- --------------------------------------------------------

--
-- Table structure for table `admin_group`
--

CREATE TABLE `admin_group` (
  `gid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '权限组名',
  `rule` varchar(255) NOT NULL COMMENT '权限规则',
  `miaoshu` varchar(255) NOT NULL COMMENT '权限组描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组表';

--
-- Dumping data for table `admin_group`
--

INSERT INTO `admin_group` (`gid`, `shopid`, `title`, `rule`, `miaoshu`) VALUES
(3, 1, '开发者帐号', '115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,181', '开发者帐号，非特殊情况别使用'),
(9, 1, '客服1', '123,124,125,130,134,138,139,140,145,150,155,156,157,158,159,160,161,162,163,164,165,166,167,168,175,176,177', '客服'),
(10, 1, '客服2', '123,124,125,130,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,150,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,175,176,177', '客服'),
(11, 1, '页面管理', '121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,174,175,176,177,178,179,180', '运营管理'),
(13, 1, '设计师', '115,121,122,123,126,127,128,129,130,134,135,136,138,140,141,143,144,146,148,168,169,170,175,178,180', '页面制作，上传产品'),
(15, 1, '售后客服', '130,133,140,145,155,159,160,161,162,163,164,165,166,167,177', '售后服务');

-- --------------------------------------------------------

--
-- Table structure for table `admin_rule`
--

CREATE TABLE `admin_rule` (
  `id` int(11) NOT NULL,
  `classify` tinyint(2) NOT NULL COMMENT '分类',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `identifying` varchar(255) NOT NULL COMMENT '标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员规则表';

--
-- Dumping data for table `admin_rule`
--

INSERT INTO `admin_rule` (`id`, `classify`, `desc`, `identifying`) VALUES
(115, 4, '查看管理员列表', '/Admin/Admin/lists'),
(116, 4, '删除指定管理员', '/Admin/Admin/del'),
(117, 4, '添加新管理员', '/Admin/Admin/add'),
(118, 4, '修改管理员资料', '/Admin/Admin/edit'),
(119, 4, '查看角色列表', '/Admin/AdminGroup/lists'),
(120, 4, '删除指定角色', '/Admin/AdminGroup/del'),
(121, 5, '查看文章列表', '/Admin/Article/lists'),
(122, 5, '修改指定文章', '/Admin/Article/edit'),
(123, 8, '查看用户统计', '/Admin/baobiao/user'),
(124, 8, '查看打款统计', '/Admin/baobiao/money'),
(125, 8, '查看销售统计', '/Admin/baobiao/xiaoshou'),
(126, 5, '查看轮播列表', '/Admin/Carousel/lists'),
(127, 5, '添加新广告轮播', '/Admin/Carousel/add'),
(128, 5, '修改广告轮播', '/Admin/Carousel/edit'),
(129, 5, '删除指定广告轮播', '/Admin/Carousel/del'),
(130, 6, '查看运费模版', '/Admin/Carriage/lists'),
(131, 6, '新增运费模版', '/Admin/Carriage/add'),
(132, 6, '删除运费模版', '/Admin/Carriage/del'),
(133, 6, '修改运费模版', '/Admin/Carriage/edit'),
(134, 2, '查看商品分类', '/Admin/Classify/lists'),
(135, 2, '新增商品分类', '/Admin/Classify/add'),
(136, 2, '修改商品分类', '/Admin/Classify/edit'),
(137, 2, '删除商品分类', '/Admin/Classify/del'),
(138, 2, '查看商品评论列表', '/Admin/CommodityComment/lists'),
(139, 2, '删除指定评论', '/Admin/CommodityComment/del'),
(140, 2, '查看商品列表', '/Admin/Commodity/lists'),
(141, 2, '新增商品', '/Admin/Commodity/add'),
(142, 2, '删除指定商品', '/Admin/Commodity/del'),
(143, 2, '修改指定商品', '/Admin/Commodity/edit'),
(144, 2, '商品上下架', '/Admin/Commodity/remove'),
(145, 2, '查看积分商品列表', '/Admin/CommodityJifen/lists'),
(146, 2, '新增积分商品', '/Admin/CommodityJifen/add'),
(147, 2, '删除指定积分商品', '/Admin/CommodityJifen/del'),
(148, 2, '修改指定积分商品', '/Admin/CommodityJifen/edit'),
(149, 7, '系统设置', '/Admin/Config/edit'),
(150, 9, '查看分销记录', '/Admin/Dividedinto/lists'),
(151, 7, '查看微信菜单', '/Admin/Menu/edit'),
(152, 7, '删除微信菜单', '/Admin/Menu/del'),
(153, 7, '更新微信菜单', '/Admin/Menu/update'),
(154, 7, '修改微信菜单', '/Admin/Menu/save'),
(155, 3, '查看订单列表', '/Admin/Order/lists'),
(156, 3, '修改订单价格', '/Admin/Order/changeorder'),
(157, 3, '取消指定订单', '/Admin/Order/cancelorder'),
(158, 3, '指定订单发货', '/Admin/Order/fahuo'),
(159, 3, '查看订单详情', '/Admin/Order/detail'),
(160, 3, '查看退款申请', '/Admin/OrderRefunds/lists'),
(161, 3, '同意退款申请', '/Admin/OrderRefunds/agree'),
(162, 3, '拒绝退款申请', '/Admin/OrderRefunds/refuse'),
(163, 3, '查看退货申请', '/Admin/OrderReturnGoods/lists'),
(164, 3, '同意退货申请', '/Admin/OrderReturnGoods/agree'),
(165, 3, '拒绝退货申请', '/Admin/OrderReturnGoods/refuse'),
(166, 3, '查看退货详情', '/Admin/OrderReturnGoods/detail'),
(167, 3, '商户确认收货', '/Admin/OrderReturnGoods/shouhuo'),
(168, 2, '查看规格列表', '/Admin/Specifications/lists'),
(169, 2, '新增商品规格', '/Admin/Specifications/add'),
(170, 2, '编辑商品规格', '/Admin/Specifications/edit'),
(171, 2, '删除商品规格', '/Admin/Specifications/del'),
(172, 1, '查看用户列表', '/Admin/User/lists'),
(173, 1, '删除指定用户', '/Admin/User/del'),
(174, 1, '查看用户分销关系', '/Admin/User/fenxiao'),
(175, 2, '查看商品二维码', '/Admin/Commodity/code'),
(176, 9, '分销打款', '/Admin/Dividedinto/fangkuan'),
(177, 3, '导出订单列表', '/Admin/Order/export'),
(178, 5, '查看合作建议', '/Admin/Suggest/lists'),
(179, 5, '删除合作建议', '/Admin/Suggest/del'),
(180, 5, '自定义首页', '/Admin/Custom/index'),
(181, 1, '用户积分操作', '/Admin/User/jifen');

-- --------------------------------------------------------

--
-- Table structure for table `admin_rule_cat`
--

CREATE TABLE `admin_rule_cat` (
  `cid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '分类名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则分类';

--
-- Dumping data for table `admin_rule_cat`
--

INSERT INTO `admin_rule_cat` (`cid`, `name`) VALUES
(1, '用户管理'),
(2, '商品管理'),
(3, '订单管理'),
(4, '管理员管理'),
(5, '网站管理'),
(6, '运营管理'),
(7, '系统设置'),
(8, '数据报表'),
(9, '分销管理');

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `articleid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `abc` varchar(20) NOT NULL,
  `title` varchar(45) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`articleid`, `shopid`, `abc`, `title`, `content`) VALUES
(1, 1, 'goumai', '购买需知', '&lt;p style=&quot;text-align: center;&quot;&gt;&lt;span style=&quot;font-size: 20px;&quot;&gt;&lt;strong&gt;购买需知&lt;/strong&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;购买光学镜的，请备注自己的左右眼度数，瞳距，散光。所有光学镜架适配1.61镜片，&lt;/p&gt;&lt;p&gt;基于平台的限制，为您的购买带来的麻烦我们深表歉意，times眼镜会用最优质的产品和服务让你100%满意。&lt;/p&gt;'),
(2, 1, 'fenxiao', '售后需知', '&lt;p style=&quot;text-align: center;&quot;&gt;&lt;span style=&quot;font-size: 20px;&quot;&gt;&lt;strong&gt;售后需知&lt;/strong&gt;&lt;/span&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family:宋体;font-size:14px&quot;&gt;一、TIMES眼镜&lt;/span&gt;&lt;span style=&quot;;font-family:宋体;font-size:14px&quot;&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;商城内所售商品为定制化生产产品，&lt;/span&gt;&lt;span style=&quot;font-family: 宋体; font-size: 14px; color: rgb(255, 0, 0);&quot;&gt;&lt;span style=&quot;font-family: 宋体;&quot;&gt;不支持&lt;/span&gt;7&lt;span style=&quot;font-family: 宋体;&quot;&gt;天无理由退换货&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;，我们采用专业冷运配送。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family:宋体;font-size:14px&quot;&gt;二、&lt;/span&gt;&lt;span style=&quot;;font-family:宋体;font-size:14px&quot;&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;您在收到产品后，请第一时间检查产品质量是否完好，核对品名和数量是否正确，如有问题，请拍摄照片，并在收到商品之时起&lt;/span&gt;24&lt;span style=&quot;font-family:宋体&quot;&gt;小时内联系我们或TIMES眼镜客服电话：&lt;/span&gt;&lt;span style=&quot;font-family:Calibri&quot;&gt;0571-83532266&lt;/span&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;（&lt;/span&gt;&lt;span style=&quot;font-family:Calibri&quot;&gt;9:00-17:30&lt;/span&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;）我们会及时为您处理，给您一个满意的结果。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family:宋体;font-size:14px&quot;&gt;三、&lt;/span&gt;&lt;span style=&quot;;font-family:宋体;font-size:14px&quot;&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;对于非江浙沪区域订单，尽管TIMES眼镜选择顺丰快递，但由于节假日快递延误等原因出现，请耐心等候，&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family:宋体;font-size:14px&quot;&gt;四、&lt;/span&gt;&lt;span style=&quot;;font-family:宋体;font-size:14px&quot;&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;您在拆包后，请检查眼镜的完整性。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family:宋体;font-size:14px&quot;&gt;五、&lt;/span&gt;&lt;span style=&quot;;font-family:宋体;font-size:14px&quot;&gt;&lt;span style=&quot;font-family:宋体&quot;&gt;对于偏远地区客户，因物流时效原因无法进行发货，敬请谅解。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 1em; margin-bottom: 1em;&quot;&gt;&lt;br/&gt;&lt;/p&gt;'),
(3, 1, 'jifen', '积分规则', '&lt;p style=&quot;margin: 5px 0;text-indent: 0&quot;&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0px; font-family: sans-serif;&quot;&gt;&lt;span style=&quot;font-size: 18px;&quot;&gt;如何成为&lt;/span&gt;&lt;span style=&quot;font-size: 20px;&quot;&gt;天明眼镜&lt;/span&gt;&lt;/span&gt;&lt;/strong&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0px; font-size: 18px; font-family: sans-serif;&quot;&gt;代言人&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;br/&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;span style=&quot;font-family:sans-serif&quot;&gt;您只需购买任意一件天明眼镜商品，系统将自动生成您的天明眼镜微店，拥有您个人&lt;/span&gt;ID链接及二维码图片。&amp;nbsp;&lt;br/&gt;&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 18px&quot;&gt;&amp;nbsp;一级代言人&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;br/&gt;&amp;nbsp; 凡是通过您的个人ID号或二维码成功关注并购买的好友或客户，成为您的一级代言人，公司直接回馈产品消费金额&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0px; font-size: 20px; color: rgb(255, 0, 0);&quot;&gt;15&lt;/span&gt;&lt;/strong&gt;&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;color: rgb(255, 0, 0);letter-spacing: 0;font-size: 20px&quot;&gt;%&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;的&lt;/span&gt;“现金奖励”。&lt;br/&gt;&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0px; font-size: 18px; font-family: sans-serif;&quot;&gt;二级代言人&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;br/&gt;&amp;nbsp; 凡是通过您的一级代言人的个人ID号或二维码成功关注并购买的好友或客户，成为您的二级代言人的同时，您还可将获得回馈产品消费金额&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;color: rgb(255, 0, 0);letter-spacing: 0;font-size: 20px&quot;&gt;10%&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;的&lt;/span&gt;“现金奖励”。&lt;br/&gt;&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0px; font-size: 18px; font-family: sans-serif;&quot;&gt;三级代言人&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;br/&gt;&amp;nbsp; 凡是通过您的二级代言人的个人ID号或二维码成功关注并购买的好友或客户，成为您的三级代言人的同时，您还可将获得回馈产品消费金额&lt;/span&gt;&lt;strong&gt;&lt;span style=&quot;color: rgb(255, 0, 0);letter-spacing: 0;font-size: 20px&quot;&gt;5%&lt;/span&gt;&lt;/strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;的&lt;/span&gt;“现金奖励。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin: 5px 0;text-indent: 0&quot;&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 16px&quot;&gt;&amp;nbsp;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin: 5px 0;text-indent: 0&quot;&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 18px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;以上规则最终解权归&lt;/span&gt;&lt;/span&gt;&lt;/strong&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 20px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;天明眼镜&lt;/span&gt;&lt;/span&gt;&lt;/strong&gt;&lt;strong&gt;&lt;span style=&quot;letter-spacing: 0;font-size: 18px&quot;&gt;&lt;span style=&quot;font-family:sans-serif&quot;&gt;公司所有。&lt;/span&gt;&lt;/span&gt;&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;'),
(4, 1, 'huiyuan', '会员规则', '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20161223/1482477398893685.png&quot; title=&quot;1482477398893685.png&quot; alt=&quot;icon_yinpai.png&quot;/&gt;天明眼镜银卡会员9.8折:一次性消费达到2650元，累计消费达到4800元;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20161223/1482477501546153.png&quot; title=&quot;1482477501546153.png&quot; alt=&quot;icon_jinpai.png&quot;/&gt;天明眼镜金卡会员9.5折：一次性消费达到4800元，累计消费达到6888元；&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20161223/1482477628460929.png&quot; title=&quot;1482477628460929.png&quot; alt=&quot;icon_zhizun.png&quot;/&gt;天明眼镜至尊会员9折：一次性消费达到12888元，累计消费达到16888元！&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `carousel`
--

CREATE TABLE `carousel` (
  `carouselid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `position` tinyint(5) NOT NULL COMMENT '位置',
  `title` varchar(45) NOT NULL COMMENT '轮播标题',
  `carouselimg` varchar(45) NOT NULL COMMENT '轮播图片',
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `carousel`
--

INSERT INTO `carousel` (`carouselid`, `shopid`, `position`, `title`, `carouselimg`, `url`) VALUES
(36, 1, 1, '新品上新', '/Uploads/2017-09-20/59c1c69a0f66d.jpeg', 'http://shopceshi.sunday.so/Home/goods/detail/?id=195'),
(37, 1, 2, '轮播图1', '/Uploads/2017-09-20/59c1d4fb4f43b.jpeg', ''),
(38, 1, 3, 'Times', '/Uploads/2017-09-20/59c1d5538e5fd.jpeg', ''),
(39, 1, 4, '大光明眼镜', '/Uploads/2017-09-21/59c3580f76819.jpeg', ''),
(40, 1, 1, '', '/Uploads/2017-09-20/59c1d4bd5676d.jpeg', 'http://shopceshi.sunday.so/Home/goods/detail/?id=210');

-- --------------------------------------------------------

--
-- Table structure for table `carousel_extend`
--

CREATE TABLE `carousel_extend` (
  `extendid` int(11) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告位置表';

--
-- Dumping data for table `carousel_extend`
--

INSERT INTO `carousel_extend` (`extendid`, `name`) VALUES
(1, '首页顶部轮播图'),
(2, '首页分类下第一个轮播图'),
(3, '首页分类下第二个轮播图'),
(4, '首页分类下第三个轮播图');

-- --------------------------------------------------------

--
-- Table structure for table `carriage`
--

CREATE TABLE `carriage` (
  `carriageid` int(11) NOT NULL COMMENT '运费表ID',
  `shopid` int(11) NOT NULL COMMENT '所属店铺ID',
  `title` varchar(45) NOT NULL COMMENT '模版标题',
  `province` varchar(20) NOT NULL COMMENT '发货省',
  `price` decimal(5,2) NOT NULL COMMENT '价格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `carriage`
--

INSERT INTO `carriage` (`carriageid`, `shopid`, `title`, `province`, `price`) VALUES
(1, 1, '1件运费模版（包邮）', '浙江', '0.00'),
(8, 1, '测试运费模板（请勿使用）', '浙江', '0.00'),
(10, 1, '积分商品运费模板（其他商品请勿使用）', '浙江', '0.01'),
(11, 1, '顺丰包邮', '浙江', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `carriage_extend`
--

CREATE TABLE `carriage_extend` (
  `carriage_extendid` int(11) NOT NULL,
  `carriageid` int(11) NOT NULL,
  `takeprovince` varchar(10) NOT NULL COMMENT '收货省',
  `price` tinyint(5) NOT NULL COMMENT '运费价格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `carriage_extend`
--

INSERT INTO `carriage_extend` (`carriage_extendid`, `carriageid`, `takeprovince`, `price`) VALUES
(187, 8, '北京', 1),
(188, 8, '天津', 2),
(189, 8, '上海', 1),
(190, 8, '重庆', 1),
(191, 8, '河北', 1),
(192, 8, '湖南', 1),
(193, 8, '黑龙江', 2),
(194, 8, '辽宁', 3),
(195, 8, '云南', 3),
(196, 8, '河南', 2),
(197, 8, '安徽', 1),
(198, 8, '山东', 2),
(199, 8, '新疆维吾尔', 2),
(200, 8, '江苏', 1),
(201, 8, '江西', 2),
(292, 1, '河北', 23),
(293, 1, '北京', 23),
(294, 1, '湖南', 23),
(295, 1, '天津', 23),
(296, 1, '重庆', 26),
(297, 1, '河南', 20),
(298, 1, '云南', 27),
(299, 1, '辽宁', 26),
(300, 1, '黑龙江', 31),
(301, 1, '山东', 22),
(302, 1, '新疆维吾尔', 34),
(303, 1, '江西', 20),
(304, 1, '湖北', 20),
(305, 1, '广西', 26),
(306, 1, '甘肃', 26),
(307, 1, '山西', 23),
(308, 1, '内蒙古', 26),
(309, 1, '陕西', 23),
(310, 1, '吉林', 31),
(311, 1, '福建', 22),
(312, 1, '贵州', 26),
(313, 1, '广东', 26),
(314, 1, '青海', 27),
(315, 1, '西藏', 34),
(316, 1, '四川', 26),
(317, 1, '宁夏', 31),
(318, 1, '海南', 27),
(319, 1, '台湾', 127),
(320, 1, '香港', 127),
(321, 1, '澳门', 127);

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL COMMENT '所属店铺ID',
  `uid` int(11) NOT NULL COMMENT '所属用户ID',
  `commodityid` int(11) NOT NULL COMMENT '商品ID',
  `sku` varchar(45) NOT NULL COMMENT '所选sku值',
  `skuid` varchar(40) NOT NULL COMMENT '商品唯一码',
  `nubs` tinyint(8) NOT NULL COMMENT '购买数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '价格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cdkey`
--

CREATE TABLE `cdkey` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL COMMENT '优惠券id',
  `cdkey` varchar(64) NOT NULL COMMENT '兑换码',
  `is_issue` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发放（0.未发放；1.已发放）',
  `getuid` int(11) NOT NULL DEFAULT '0' COMMENT '0.未领取；其他表示领取人id',
  `orderid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换码表';

-- --------------------------------------------------------

--
-- Table structure for table `chatlog`
--

CREATE TABLE `chatlog` (
  `id` int(11) NOT NULL,
  `type` tinyint(2) DEFAULT NULL,
  `fromid` int(11) NOT NULL,
  `toid` int(11) NOT NULL,
  `fromname` varchar(45) DEFAULT NULL,
  `fromavatar` varchar(255) DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `timeline` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `needsend` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `classify`
--

CREATE TABLE `classify` (
  `classifyid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `pid` int(11) NOT NULL COMMENT '上级iD',
  `level` tinyint(2) NOT NULL DEFAULT '1',
  `name` varchar(45) NOT NULL,
  `isshow` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1显示0不显示',
  `ico` varchar(200) NOT NULL,
  `sort` tinyint(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commodity`
--

CREATE TABLE `commodity` (
  `commodityid` int(11) UNSIGNED NOT NULL,
  `shopid` int(11) UNSIGNED NOT NULL,
  `huohao` char(255) NOT NULL,
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1普通商品2积分商品',
  `integral` smallint(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '可获取积分',
  `classifyid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(105) NOT NULL COMMENT '商品标题',
  `thumbnail` varchar(255) NOT NULL COMMENT '缩略图',
  `dai` varchar(255) DEFAULT NULL,
  `original` decimal(10,2) NOT NULL COMMENT '原价',
  `current` decimal(10,2) NOT NULL COMMENT '现价',
  `money` decimal(4,2) NOT NULL COMMENT '拿出来分成的钱',
  `sales` smallint(5) UNSIGNED NOT NULL COMMENT '销售量',
  `content` text NOT NULL,
  `carrousel` text NOT NULL,
  `carriageid` int(11) UNSIGNED NOT NULL,
  `recommend` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0正常，2店家推荐',
  `firstgraded` decimal(4,2) NOT NULL COMMENT '一级提成比例',
  `secondgraded` decimal(4,2) NOT NULL COMMENT '二级提成比例',
  `threegraded` decimal(4,2) NOT NULL COMMENT '三级提成比例',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1上架0下架'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commodity`
--

INSERT INTO `commodity` (`commodityid`, `shopid`, `huohao`, `type`, `integral`, `classifyid`, `title`, `thumbnail`, `dai`, `original`, `current`, `money`, `sales`, `content`, `carrousel`, `carriageid`, `recommend`, `firstgraded`, `secondgraded`, `threegraded`, `status`) VALUES
(61, 1, '8806', 1, 0, 23, 'TIMES光学眼镜8806-C3', '/Uploads/2017-10-24/59eeeff64fbed.jpg', 'https://epeijing.cn/api/bk2E0B', '398.00', '398.00', '0.00', 17, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257678156.jpg&quot; style=&quot;&quot; title=&quot;1489997257678156.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257747631.jpg&quot; style=&quot;&quot; title=&quot;1489997257747631.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257558555.jpg&quot; style=&quot;&quot; title=&quot;1489997257558555.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257859170.jpg&quot; style=&quot;&quot; title=&quot;1489997257859170.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257729451.jpg&quot; style=&quot;&quot; title=&quot;1489997257729451.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257864321.jpg&quot; style=&quot;&quot; title=&quot;1489997257864321.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257515915.jpg&quot; style=&quot;&quot; title=&quot;1489997257515915.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257812057.jpg&quot; style=&quot;&quot; title=&quot;1489997257812057.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997257419976.jpg&quot; style=&quot;&quot; title=&quot;1489997257419976.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997258417717.jpg&quot; style=&quot;&quot; title=&quot;1489997258417717.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489997258893333.jpg&quot; style=&quot;&quot; title=&quot;1489997258893333.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eeeff650186.jpg\",\"\\/Uploads\\/2017-10-24\\/59eeeff650706.jpg\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(62, 1, '8813', 1, 0, 23, 'times眼镜8813-C1', '/Uploads/2017-10-24/59eeeeef3db2d.jpg', 'https://epeijing.cn/api/byj7FH', '398.00', '398.00', '0.00', 17, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938610570.jpg&quot; style=&quot;&quot; title=&quot;1489998938610570.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938827131.jpg&quot; style=&quot;&quot; title=&quot;1489998938827131.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938957896.jpg&quot; style=&quot;&quot; title=&quot;1489998938957896.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938163043.jpg&quot; style=&quot;&quot; title=&quot;1489998938163043.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938199375.jpg&quot; style=&quot;&quot; title=&quot;1489998938199375.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998938940311.jpg&quot; style=&quot;&quot; title=&quot;1489998938940311.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998939339780.jpg&quot; style=&quot;&quot; title=&quot;1489998939339780.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998939762505.jpg&quot; style=&quot;&quot; title=&quot;1489998939762505.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998939344511.jpg&quot; style=&quot;&quot; title=&quot;1489998939344511.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998939866051.jpg&quot; style=&quot;&quot; title=&quot;1489998939866051.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489998939559377.jpg&quot; style=&quot;&quot; title=&quot;1489998939559377.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eeeeef3e15d.jpg\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(63, 1, '8832', 1, 0, 23, 'times眼镜8832-C1', '/Uploads/2017-10-24/59eecd2123ea2.JPG', 'https://epeijing.cn/api/b1B02D', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508822290164330.jpg&quot; style=&quot;&quot; title=&quot;1508822290164330.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508822290631370.jpg&quot; style=&quot;&quot; title=&quot;1508822290631370.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eecd21244f1.JPG\",\"\\/Uploads\\/2017-10-24\\/59eecd21249cb.JPG\",\"\\/Uploads\\/2017-10-24\\/59eecd2124d87.JPG\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(64, 1, '8838', 1, 0, 23, 'times眼镜8838-C4', '/Uploads/2017-10-24/59eef13425bbd.jpg', 'https://epeijing.cn/api/QsKuJ', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343678542.jpg&quot; style=&quot;&quot; title=&quot;1489999343678542.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343635817.jpg&quot; style=&quot;&quot; title=&quot;1489999343635817.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343919676.jpg&quot; style=&quot;&quot; title=&quot;1489999343919676.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343237812.jpg&quot; style=&quot;&quot; title=&quot;1489999343237812.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343126621.jpg&quot; style=&quot;&quot; title=&quot;1489999343126621.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343500548.jpg&quot; style=&quot;&quot; title=&quot;1489999343500548.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343691682.jpg&quot; style=&quot;&quot; title=&quot;1489999343691682.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343305554.jpg&quot; style=&quot;&quot; title=&quot;1489999343305554.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343489481.jpg&quot; style=&quot;&quot; title=&quot;1489999343489481.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343557609.jpg&quot; style=&quot;&quot; title=&quot;1489999343557609.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999343543242.jpg&quot; style=&quot;&quot; title=&quot;1489999343543242.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef1342616f.jpg\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(65, 1, '211009', 1, 0, 23, 'times眼镜211009-A01-1', '/Uploads/2017-10-24/59eef194233bd.jpg', 'https://epeijing.cn/api/4nrJQ', '198.00', '198.00', '0.00', 6, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999615208471.jpg&quot; style=&quot;&quot; title=&quot;1489999615208471.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616642127.jpg&quot; style=&quot;&quot; title=&quot;1489999616642127.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616896797.jpg&quot; style=&quot;&quot; title=&quot;1489999616896797.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616223188.jpg&quot; style=&quot;&quot; title=&quot;1489999616223188.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616161909.jpg&quot; style=&quot;&quot; title=&quot;1489999616161909.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616231411.jpg&quot; style=&quot;&quot; title=&quot;1489999616231411.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616295218.jpg&quot; style=&quot;&quot; title=&quot;1489999616295218.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616190411.jpg&quot; style=&quot;&quot; title=&quot;1489999616190411.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616768294.jpg&quot; style=&quot;&quot; title=&quot;1489999616768294.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616681549.jpg&quot; style=&quot;&quot; title=&quot;1489999616681549.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999616740660.jpg&quot; style=&quot;&quot; title=&quot;1489999616740660.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef194238a0.jpg\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(66, 1, 'D053', 1, 0, 23, 'times眼镜D053-C04', '/Uploads/2017-10-24/59eef3a7b1704.jpg', 'https://epeijing.cn/api/bk02Wy', '198.00', '198.00', '0.00', 0, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797379558.jpg&quot; style=&quot;&quot; title=&quot;1489999797379558.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797522102.jpg&quot; style=&quot;&quot; title=&quot;1489999797522102.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797871660.jpg&quot; style=&quot;&quot; title=&quot;1489999797871660.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797185844.jpg&quot; style=&quot;&quot; title=&quot;1489999797185844.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797690962.jpg&quot; style=&quot;&quot; title=&quot;1489999797690962.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797983973.jpg&quot; style=&quot;&quot; title=&quot;1489999797983973.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797664854.jpg&quot; style=&quot;&quot; title=&quot;1489999797664854.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797998067.jpg&quot; style=&quot;&quot; title=&quot;1489999797998067.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797390751.jpg&quot; style=&quot;&quot; title=&quot;1489999797390751.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797117384.jpg&quot; style=&quot;&quot; title=&quot;1489999797117384.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170320/1489999797429148.jpg&quot; style=&quot;&quot; title=&quot;1489999797429148.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef3a7b1b64.jpg\"]', 11, 2, '0.00', '0.00', '0.00', 1),
(67, 1, '8801', 1, 0, 23, 'times眼镜8801-C2', '/Uploads/2017-10-24/59eef328e98d7.jpg', 'https://epeijing.cn/api/kMrkZ', '398.00', '398.00', '0.00', 2, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543125821.jpg&quot; style=&quot;&quot; title=&quot;1490246543125821.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543113750.jpg&quot; style=&quot;&quot; title=&quot;1490246543113750.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543726460.jpg&quot; style=&quot;&quot; title=&quot;1490246543726460.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543870736.jpg&quot; style=&quot;&quot; title=&quot;1490246543870736.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543455053.jpg&quot; style=&quot;&quot; title=&quot;1490246543455053.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543704466.jpg&quot; style=&quot;&quot; title=&quot;1490246543704466.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246543442717.jpg&quot; style=&quot;&quot; title=&quot;1490246543442717.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246544629808.jpg&quot; style=&quot;&quot; title=&quot;1490246544629808.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246544157476.jpg&quot; style=&quot;&quot; title=&quot;1490246544157476.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246544453003.jpg&quot; style=&quot;&quot; title=&quot;1490246544453003.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246544783918.jpg&quot; style=&quot;&quot; title=&quot;1490246544783918.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490246544866642.jpg&quot; style=&quot;&quot; title=&quot;1490246544866642.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef328e9e17.jpg\"]', 11, 0, '0.00', '0.00', '0.00', 1),
(68, 1, '8803', 1, 0, 23, 'times眼镜8803-C1', '/Uploads/2017-10-24/59eeefb6f1325.jpg', 'https://epeijing.cn/api/7qGSt', '298.00', '298.00', '0.00', 0, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528515248.jpg&quot; style=&quot;&quot; title=&quot;1490247528515248.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528290850.jpg&quot; style=&quot;&quot; title=&quot;1490247528290850.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528287454.jpg&quot; style=&quot;&quot; title=&quot;1490247528287454.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528922701.jpg&quot; style=&quot;&quot; title=&quot;1490247528922701.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528488622.jpg&quot; style=&quot;&quot; title=&quot;1490247528488622.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528898548.jpg&quot; style=&quot;&quot; title=&quot;1490247528898548.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528678636.jpg&quot; style=&quot;&quot; title=&quot;1490247528678636.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528142033.jpg&quot; style=&quot;&quot; title=&quot;1490247528142033.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247528298541.jpg&quot; style=&quot;&quot; title=&quot;1490247528298541.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247529881520.jpg&quot; style=&quot;&quot; title=&quot;1490247529881520.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247529364741.jpg&quot; style=&quot;&quot; title=&quot;1490247529364741.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247529646549.jpg&quot; style=&quot;&quot; title=&quot;1490247529646549.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eeefb6f1857.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(69, 1, '8816', 1, 0, 23, 'timea光学眼镜8816-C1', '/Uploads/2017-10-24/59eef0190039d.jpg', 'https://epeijing.cn/api/bqBxVo', '398.00', '398.00', '0.00', 19, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805456003.jpg&quot; style=&quot;&quot; title=&quot;1490247805456003.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805579069.jpg&quot; style=&quot;&quot; title=&quot;1490247805579069.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805968992.jpg&quot; style=&quot;&quot; title=&quot;1490247805968992.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805405395.jpg&quot; style=&quot;&quot; title=&quot;1490247805405395.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805112260.jpg&quot; style=&quot;&quot; title=&quot;1490247805112260.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805468817.jpg&quot; style=&quot;&quot; title=&quot;1490247805468817.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805356024.jpg&quot; style=&quot;&quot; title=&quot;1490247805356024.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805132900.jpg&quot; style=&quot;&quot; title=&quot;1490247805132900.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805310167.jpg&quot; style=&quot;&quot; title=&quot;1490247805310167.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805959152.jpg&quot; style=&quot;&quot; title=&quot;1490247805959152.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490247805164281.jpg&quot; style=&quot;&quot; title=&quot;1490247805164281.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef01900855.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(70, 1, '8821', 1, 0, 23, 'times光学眼镜8821-C2', '/Uploads/2017-10-24/59eef3879c050.jpg', 'https://epeijing.cn/api/1ws1z', '398.00', '398.00', '0.00', 0, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088476659.jpg&quot; style=&quot;&quot; title=&quot;1490248088476659.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088305494.jpg&quot; style=&quot;&quot; title=&quot;1490248088305494.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088234371.jpg&quot; style=&quot;&quot; title=&quot;1490248088234371.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088535948.jpg&quot; style=&quot;&quot; title=&quot;1490248088535948.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088848328.jpg&quot; style=&quot;&quot; title=&quot;1490248088848328.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088673950.jpg&quot; style=&quot;&quot; title=&quot;1490248088673950.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088472463.jpg&quot; style=&quot;&quot; title=&quot;1490248088472463.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088620495.jpg&quot; style=&quot;&quot; title=&quot;1490248088620495.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088678967.jpg&quot; style=&quot;&quot; title=&quot;1490248088678967.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088257217.jpg&quot; style=&quot;&quot; title=&quot;1490248088257217.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248088320584.jpg&quot; style=&quot;&quot; title=&quot;1490248088320584.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef3879c564.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(71, 1, '8831', 1, 0, 23, 'times眼镜8831-C3', '/Uploads/2017-10-24/59eecc7bbf76c.jpg', 'https://epeijing.cn/api/cbuXXZ', '398.00', '398.00', '0.00', 0, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508822111341995.jpg&quot; style=&quot;&quot; title=&quot;1508822111341995.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508822111193704.jpg&quot; style=&quot;&quot; title=&quot;1508822111193704.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eecc7bbff1f.jpg\",\"\\/Uploads\\/2017-10-24\\/59eecc7bc04ca.jpg\",\"\\/Uploads\\/2017-10-24\\/59eecc7bc098d.jpg\",\"\\/Uploads\\/2017-10-24\\/59eecc7bc1299.jpg\",\"\\/Uploads\\/2017-10-24\\/59eecc7bc1943.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(72, 1, '8836', 1, 0, 23, 'times眼镜8836-C1', '/Uploads/2017-10-24/59eef1bd2d4de.jpg', 'https://epeijing.cn/api/bYdETk', '298.00', '298.00', '0.00', 2, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851381390.jpg&quot; style=&quot;&quot; title=&quot;1490248851381390.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851755697.jpg&quot; style=&quot;&quot; title=&quot;1490248851755697.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851212157.jpg&quot; style=&quot;&quot; title=&quot;1490248851212157.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851495551.jpg&quot; style=&quot;&quot; title=&quot;1490248851495551.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851762135.jpg&quot; style=&quot;&quot; title=&quot;1490248851762135.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248851895640.jpg&quot; style=&quot;&quot; title=&quot;1490248851895640.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248852565660.jpg&quot; style=&quot;&quot; title=&quot;1490248852565660.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248852635462.jpg&quot; style=&quot;&quot; title=&quot;1490248852635462.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248852351791.jpg&quot; style=&quot;&quot; title=&quot;1490248852351791.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248852462835.jpg&quot; style=&quot;&quot; title=&quot;1490248852462835.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490248852131874.jpg&quot; style=&quot;&quot; title=&quot;1490248852131874.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef1bd2d9f7.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(73, 1, 'D056', 1, 0, 23, 'times眼镜D056-C01', '/Uploads/2017-10-24/59eef1dc22244.jpg', 'https://epeijing.cn/api/bl4hhF', '198.00', '198.00', '0.00', 2, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249603309842.jpg&quot; style=&quot;&quot; title=&quot;1490249603309842.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249603466403.jpg&quot; style=&quot;&quot; title=&quot;1490249603466403.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249603863519.jpg&quot; style=&quot;&quot; title=&quot;1490249603863519.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249603108340.jpg&quot; style=&quot;&quot; title=&quot;1490249603108340.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604573138.jpg&quot; style=&quot;&quot; title=&quot;1490249604573138.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604140928.jpg&quot; style=&quot;&quot; title=&quot;1490249604140928.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604385119.jpg&quot; style=&quot;&quot; title=&quot;1490249604385119.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604266003.jpg&quot; style=&quot;&quot; title=&quot;1490249604266003.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604558605.jpg&quot; style=&quot;&quot; title=&quot;1490249604558605.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604570182.jpg&quot; style=&quot;&quot; title=&quot;1490249604570182.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249604105587.jpg&quot; style=&quot;&quot; title=&quot;1490249604105587.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef1dc22764.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(74, 1, '211005', 1, 0, 23, 'times眼镜211005-A01', '/Uploads/2017-10-24/59eef3600f913.jpg', 'https://epeijing.cn/api/tlEA5', '198.00', '198.00', '0.00', 0, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249782619527.jpg&quot; style=&quot;&quot; title=&quot;1490249782619527.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249782925939.jpg&quot; style=&quot;&quot; title=&quot;1490249782925939.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249782865455.jpg&quot; style=&quot;&quot; title=&quot;1490249782865455.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249782103196.jpg&quot; style=&quot;&quot; title=&quot;1490249782103196.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783146691.jpg&quot; style=&quot;&quot; title=&quot;1490249783146691.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783492262.jpg&quot; style=&quot;&quot; title=&quot;1490249783492262.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783637037.jpg&quot; style=&quot;&quot; title=&quot;1490249783637037.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783674583.jpg&quot; style=&quot;&quot; title=&quot;1490249783674583.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783864760.jpg&quot; style=&quot;&quot; title=&quot;1490249783864760.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783568226.jpg&quot; style=&quot;&quot; title=&quot;1490249783568226.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249783705337.jpg&quot; style=&quot;&quot; title=&quot;1490249783705337.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef3600fd95.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(75, 1, '651006', 1, 0, 23, 'times眼镜651006-A09', '/Uploads/2017-10-24/59eef2f3cef56.jpg', 'https://epeijing.cn/api/chzEWe', '198.00', '198.00', '0.00', 6, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942465505.jpg&quot; style=&quot;&quot; title=&quot;1490249942465505.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942363491.jpg&quot; style=&quot;&quot; title=&quot;1490249942363491.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942428161.jpg&quot; style=&quot;&quot; title=&quot;1490249942428161.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942555016.jpg&quot; style=&quot;&quot; title=&quot;1490249942555016.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942861441.jpg&quot; style=&quot;&quot; title=&quot;1490249942861441.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942920035.jpg&quot; style=&quot;&quot; title=&quot;1490249942920035.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942854113.jpg&quot; style=&quot;&quot; title=&quot;1490249942854113.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942556925.jpg&quot; style=&quot;&quot; title=&quot;1490249942556925.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942529960.jpg&quot; style=&quot;&quot; title=&quot;1490249942529960.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942210043.jpg&quot; style=&quot;&quot; title=&quot;1490249942210043.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170323/1490249942913941.jpg&quot; style=&quot;&quot; title=&quot;1490249942913941.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef2f3cf4e8.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(76, 1, '6067', 1, 0, 21, 'times太阳镜6067-C3', '/Uploads/2017-10-24/59eea65d27bbf.jpg', 'https://epeijing.cn/api/wmMt2', '298.00', '298.00', '0.00', 2, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812344559169.jpg&quot; style=&quot;&quot; title=&quot;1508812344559169.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812347546168.jpg&quot; style=&quot;&quot; title=&quot;1508812347546168.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea65d28a1e.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea65d2935b.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea65d29b42.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea65d2a2ce.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea65d2aa87.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(77, 1, '6077', 1, 0, 21, 'times太阳镜6077-C4', '/Uploads/2017-10-24/59eea5ddf218e.jpg', 'https://epeijing.cn/api/bVd0bx', '298.00', '298.00', '0.00', 0, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812217866883.jpg&quot; style=&quot;&quot; title=&quot;1508812217866883.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812217119571.jpg&quot; style=&quot;&quot; title=&quot;1508812217119571.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea5ddf2f44.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea5ddf3e62.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea5de004e5.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea5de00b92.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea5de01203.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(78, 1, 'js6095', 1, 0, 21, 'times太阳镜js6095-C5', '/Uploads/2017-10-24/59eea54f09285.jpg', 'https://epeijing.cn/api/g3UB6', '298.00', '298.00', '0.00', 0, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812054969357.jpg&quot; style=&quot;&quot; title=&quot;1508812054969357.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508812059804882.jpg&quot; style=&quot;&quot; title=&quot;1508812059804882.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea54f09952.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea54f0a1df.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea54f0aa23.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea54f0b70f.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea54f0c41f.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(79, 1, 'bc14049', 1, 0, 21, 'times太阳镜bc14049-C11', '/Uploads/2017-10-24/59eef2d296a25.jpg', 'https://epeijing.cn/api/bvGpRD', '228.00', '228.00', '0.00', 0, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318572865960.jpg&quot; style=&quot;&quot; title=&quot;1490318572865960.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573137896.jpg&quot; style=&quot;&quot; title=&quot;1490318573137896.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573511396.jpg&quot; style=&quot;&quot; title=&quot;1490318573511396.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573180128.jpg&quot; style=&quot;&quot; title=&quot;1490318573180128.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573231529.jpg&quot; style=&quot;&quot; title=&quot;1490318573231529.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573594961.jpg&quot; style=&quot;&quot; title=&quot;1490318573594961.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573160537.jpg&quot; style=&quot;&quot; title=&quot;1490318573160537.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573495327.jpg&quot; style=&quot;&quot; title=&quot;1490318573495327.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573175283.jpg&quot; style=&quot;&quot; title=&quot;1490318573175283.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170324/1490318573963804.jpg&quot; style=&quot;&quot; title=&quot;1490318573963804.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eef2d297014.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(80, 1, 'bc14051', 1, 0, 21, 'times太阳镜bc14051-C7', '/Uploads/2017-10-24/59eea4ad505a4.jpg', 'https://epeijing.cn/api/uOKOK', '228.00', '228.00', '0.00', 0, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811877918305.jpg&quot; style=&quot;&quot; title=&quot;1508811877918305.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811877287516.jpg&quot; style=&quot;&quot; title=&quot;1508811877287516.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea4ad510b9.jpg\"]', 11, 0, '15.00', '10.00', '5.00', 1),
(81, 1, 'bc80084', 1, 0, 21, 'times太阳镜bc80084-C14', '/Uploads/2017-10-24/59eea375afa27.jpg', 'https://epeijing.cn/api/1aJ5x', '228.00', '228.00', '0.00', 2, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811560626709.jpg&quot; style=&quot;&quot; title=&quot;1508811560626709.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811560987825.jpg&quot; style=&quot;&quot; title=&quot;1508811560987825.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea375b0449.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea375b0c6c.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea375b17cf.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea375b1e15.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea375b2620.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(82, 1, 'bc80085', 1, 0, 21, 'times太阳镜bc80085-C13', '/Uploads/2017-10-24/59eea2113774e.jpg', 'https://epeijing.cn/api/bTHTnr', '228.00', '228.00', '0.00', 1, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811202375848.jpg&quot; style=&quot;&quot; title=&quot;1508811202375848.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171024/1508811203112451.jpg&quot; style=&quot;&quot; title=&quot;1508811203112451.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-10-24\\/59eea211380ef.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea211386ae.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea21138f07.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea211393b6.jpg\",\"\\/Uploads\\/2017-10-24\\/59eea21139a61.jpg\"]', 11, 2, '15.00', '10.00', '5.00', 1),
(145, 1, '20035', 1, 0, 23, 'TIMES光学镜20035', '/Uploads/2017-06-28/59533a828035b.jpg', 'https://epeijing.cn/api/bZS3qo', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170628/1498627804442460.jpg&quot; style=&quot;&quot; title=&quot;1498627804442460.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170628/1498627804894887.jpg&quot; style=&quot;&quot; title=&quot;1498627804894887.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/5954930c3ba6c.jpg\",\"\\/Uploads\\/2017-06-29\\/5954930c3bfeb.jpg\",\"\\/Uploads\\/2017-06-29\\/5954930c3c3aa.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(151, 1, '88092', 1, 0, 23, 'TIMES光学镜架88092', '/Uploads/2017-06-29/5954578faa1fe.JPG', 'https://epeijing.cn/api/gT3NU', '398.00', '398.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498699619956276.jpg&quot; style=&quot;&quot; title=&quot;1498699619956276.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498699619661003.jpg&quot; style=&quot;&quot; title=&quot;1498699619661003.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/5954934036030.JPG\",\"\\/Uploads\\/2017-06-29\\/5954934036449.JPG\",\"\\/Uploads\\/2017-06-29\\/59549340367c9.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(152, 1, '20083', 1, 0, 23, 'TIMES光学镜架20083', '/Uploads/2017-06-29/59545921c348b.JPG', 'https://epeijing.cn/api/ck6zzJ', '398.00', '398.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498700002497412.jpg&quot; style=&quot;&quot; title=&quot;1498700002497412.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498700002369058.jpg&quot; style=&quot;&quot; title=&quot;1498700002369058.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/5954935a4666a.JPG\",\"\\/Uploads\\/2017-06-29\\/5954935a46b1b.JPG\",\"\\/Uploads\\/2017-06-29\\/5954935a47104.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(168, 1, '20057', 1, 0, 23, 'TIMES光学镜架20057', '/Uploads/2017-06-29/5954912333587.JPG', 'https://epeijing.cn/api/b2ZqG9', '398.00', '398.00', '0.00', 2, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498714354702017.jpg&quot; style=&quot;&quot; title=&quot;1498714354702017.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498714355756826.jpg&quot; style=&quot;&quot; title=&quot;1498714355756826.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/59549123339e9.JPG\",\"\\/Uploads\\/2017-06-29\\/5954912333db6.JPG\",\"\\/Uploads\\/2017-06-29\\/5954912334138.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(169, 1, '2650', 1, 0, 23, 'TIMES光学镜架2650', '/Uploads/2017-06-29/595494ca48f6f.JPG', 'https://epeijing.cn/api/DTf4J', '498.00', '498.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498715286330109.jpg&quot; style=&quot;&quot; title=&quot;1498715286330109.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498715286774498.jpg&quot; style=&quot;&quot; title=&quot;1498715286774498.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/595494ca494e4.JPG\",\"\\/Uploads\\/2017-06-29\\/595494ca49997.JPG\",\"\\/Uploads\\/2017-06-29\\/595494ca49dd6.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(170, 1, '20046', 1, 0, 23, 'TIMES光学镜架20046', '/Uploads/2017-06-29/595496c5046df.jpg', 'https://epeijing.cn/api/t0sac', '398.00', '398.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498715672345794.jpg&quot; style=&quot;&quot; title=&quot;1498715672345794.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498715672844786.jpg&quot; style=&quot;&quot; title=&quot;1498715672844786.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/595496c504f20.jpg\",\"\\/Uploads\\/2017-06-29\\/595496c5055bb.jpg\",\"\\/Uploads\\/2017-06-29\\/595496c505b1a.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(171, 1, 'L2080', 1, 0, 23, 'TIMES  光学镜架L2080', '/Uploads/2017-06-29/5954aa70b88ec.jpg', 'https://epeijing.cn/api/2Nw92', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498720835475251.jpg&quot; style=&quot;&quot; title=&quot;1498720835475251.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170629/1498720835198969.jpg&quot; style=&quot;&quot; title=&quot;1498720835198969.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-29\\/5954aa70b8dde.jpg\",\"\\/Uploads\\/2017-06-29\\/5954aa70b91f0.jpg\",\"\\/Uploads\\/2017-06-29\\/5954aa70b9578.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(172, 1, '5319', 1, 0, 23, 'TIMES光学镜架5319', '/Uploads/2017-06-30/5955dfbb18187.jpg', 'https://epeijing.cn/api/cu7q36', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800007895695.jpg&quot; style=&quot;&quot; title=&quot;1498800007895695.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800007612095.jpg&quot; style=&quot;&quot; title=&quot;1498800007612095.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/5955dfbb18679.jpg\",\"\\/Uploads\\/2017-06-30\\/5955dfbb18a92.jpg\",\"\\/Uploads\\/2017-06-30\\/5955dfbb18ff2.jpg\",\"\\/Uploads\\/2017-06-30\\/5955dfbb1940f.jpg\",\"\\/Uploads\\/2017-06-30\\/5955dfbb197e1.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(173, 1, 'M5211', 1, 0, 23, 'TIMES光学镜架M5211', '/Uploads/2017-06-30/5955e1597ae4e.jpg', 'https://epeijing.cn/api/bY3I9h', '498.00', '498.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800293954731.jpg&quot; style=&quot;&quot; title=&quot;1498800293954731.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800293828067.jpg&quot; style=&quot;&quot; title=&quot;1498800293828067.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/5955e1597b2da.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e1597b6c1.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e1597baae.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(174, 1, 'D8212', 1, 0, 23, 'TIMES光学镜架D8212', '/Uploads/2017-06-30/5955e24aec920.jpg', 'https://epeijing.cn/api/cnCCAV', '598.00', '598.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800635161710.jpg&quot; style=&quot;&quot; title=&quot;1498800635161710.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800636543879.jpg&quot; style=&quot;&quot; title=&quot;1498800636543879.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/5955e24aece1f.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e24aed21c.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e24aed5b6.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e24aedab0.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e24aeded2.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(175, 1, '8222', 1, 0, 23, 'TIMES光学镜架8222', '/Uploads/2017-06-30/5955e2b233326.jpg', 'https://epeijing.cn/api/bN4aCk', '598.00', '598.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800783150934.jpg&quot; style=&quot;&quot; title=&quot;1498800783150934.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800783332054.jpg&quot; style=&quot;&quot; title=&quot;1498800783332054.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/5955e2b233a4b.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e2b234075.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e2b234606.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(176, 1, 'D8224', 1, 0, 23, 'TIMES光学镜架D8224', '/Uploads/2017-06-30/5955e376e1ad4.jpg', 'https://epeijing.cn/api/XH0pq', '598.00', '598.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800986645462.jpg&quot; style=&quot;&quot; title=&quot;1498800986645462.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498800986985393.jpg&quot; style=&quot;&quot; title=&quot;1498800986985393.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/5955e376e1fd6.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e376e23f4.jpg\",\"\\/Uploads\\/2017-06-30\\/5955e376e27c2.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(177, 1, 'D8231', 1, 0, 23, 'TIMES光学镜架D8231', '/Uploads/2017-06-30/595619a5a5046.jpg', 'https://epeijing.cn/api/cervLF', '598.00', '598.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498814849838583.jpg&quot; style=&quot;&quot; title=&quot;1498814849838583.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498814849218792.jpg&quot; style=&quot;&quot; title=&quot;1498814849218792.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/595619a5a5533.jpg\",\"\\/Uploads\\/2017-06-30\\/595619a5a5918.jpg\",\"\\/Uploads\\/2017-06-30\\/595619a5a5da8.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(178, 1, 'D8235', 1, 0, 23, 'TIMES光学镜架D8235', '/Uploads/2017-06-30/59561a2a883e5.jpg', 'https://epeijing.cn/api/bZVPGI', '598.00', '598.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498814981286114.jpg&quot; style=&quot;&quot; title=&quot;1498814981286114.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498814981990466.jpg&quot; style=&quot;&quot; title=&quot;1498814981990466.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/59561a2a88c93.jpg\",\"\\/Uploads\\/2017-06-30\\/59561a2a890e2.jpg\",\"\\/Uploads\\/2017-06-30\\/59561a2a89488.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(179, 1, 'D8239', 1, 0, 23, 'TIMES光学镜架D8239', '/Uploads/2017-06-30/59561ab972f14.jpg', 'https://epeijing.cn/api/b34IPI', '598.00', '598.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498815128395406.jpg&quot; style=&quot;&quot; title=&quot;1498815128395406.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170630/1498815128626760.jpg&quot; style=&quot;&quot; title=&quot;1498815128626760.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-06-30\\/59561ab973454.jpg\",\"\\/Uploads\\/2017-06-30\\/59561ab9738d8.jpg\",\"\\/Uploads\\/2017-06-30\\/59561ab973ccc.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(180, 1, 'D8245', 1, 0, 23, 'TIMES光学镜架D8245', '/Uploads/2017-07-03/5959b474539f1.JPG', 'https://epeijing.cn/api/buos1t', '598.00', '598.00', '0.00', 3, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051069373301.jpg&quot; style=&quot;&quot; title=&quot;1499051069373301.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051069488385.jpg&quot; style=&quot;&quot; title=&quot;1499051069488385.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-03\\/5959b47453eef.JPG\",\"\\/Uploads\\/2017-07-03\\/5959b474542e3.JPG\",\"\\/Uploads\\/2017-07-03\\/5959b474546f0.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(181, 1, 'D8253', 1, 0, 23, 'TIMES光学镜架D8253', '/Uploads/2017-07-03/5959b5211a70a.jpg', 'https://epeijing.cn/api/bvGsvK', '598.00', '598.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051228873759.jpg&quot; style=&quot;&quot; title=&quot;1499051228873759.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051229251746.jpg&quot; style=&quot;&quot; title=&quot;1499051229251746.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-03\\/5959b5211ac3d.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b5211b075.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b5211b473.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b5211b919.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b5211bd21.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(182, 1, 'D8265', 1, 0, 23, 'TIMES光学镜镜框D8265', '/Uploads/2017-07-03/5959b59faffda.jpg', 'https://epeijing.cn/api/A8w0h', '598.00', '598.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051357594714.jpg&quot; style=&quot;&quot; title=&quot;1499051357594714.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170703/1499051357924649.jpg&quot; style=&quot;&quot; title=&quot;1499051357924649.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-03\\/5959b59fb0568.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b59fb0a48.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b59fb0f0f.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b59fb1326.jpg\",\"\\/Uploads\\/2017-07-03\\/5959b59fb16cc.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(183, 1, '20054', 1, 0, 23, 'TIMES光学镜架20054', '/Uploads/2017-07-07/595f451990567.JPG', '', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499415739820345.jpg&quot; style=&quot;&quot; title=&quot;1499415739820345.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499415739691292.jpg&quot; style=&quot;&quot; title=&quot;1499415739691292.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f451990b80.JPG\",\"\\/Uploads\\/2017-07-07\\/595f451991009.JPG\",\"\\/Uploads\\/2017-07-07\\/595f45199147d.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1);
INSERT INTO `commodity` (`commodityid`, `shopid`, `huohao`, `type`, `integral`, `classifyid`, `title`, `thumbnail`, `dai`, `original`, `current`, `money`, `sales`, `content`, `carrousel`, `carriageid`, `recommend`, `firstgraded`, `secondgraded`, `threegraded`, `status`) VALUES
(184, 1, '20036', 1, 0, 0, 'TIMES 光学镜架20036', '/Uploads/2017-07-07/595f49e5c86b7.JPG', '', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499416983977985.jpg&quot; style=&quot;&quot; title=&quot;1499416983977985.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499416983592722.jpg&quot; style=&quot;&quot; title=&quot;1499416983592722.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f49e5c8cba.JPG\",\"\\/Uploads\\/2017-07-07\\/595f49e5c9195.JPG\",\"\\/Uploads\\/2017-07-07\\/595f49e5c95df.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(185, 1, '8915', 1, 0, 0, 'TIMES光学镜架8915', '/Uploads/2017-07-07/595f4ba194f25.JPG', '', '498.00', '498.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499417909336644.jpg&quot; style=&quot;&quot; title=&quot;1499417909336644.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499417909789355.jpg&quot; style=&quot;&quot; title=&quot;1499417909789355.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f4ba1954bd.JPG\",\"\\/Uploads\\/2017-07-07\\/595f4ba195931.JPG\",\"\\/Uploads\\/2017-07-07\\/595f4ba195d30.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(186, 1, '72208', 1, 0, 0, 'TIMES 光学眼镜72208', '/Uploads/2017-07-07/595f5638d5c39.JPG', '', '498.00', '498.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499420141881519.jpg&quot; style=&quot;&quot; title=&quot;1499420141881519.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499420141827699.jpg&quot; style=&quot;&quot; title=&quot;1499420141827699.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f5638d6160.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5638d65c6.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5638d69aa.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(187, 1, 'R65056', 1, 0, 0, 'TIMES 光学镜架R65056', '/Uploads/2017-07-07/595f57f8b8890.JPG', '', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499420612761537.jpg&quot; style=&quot;&quot; title=&quot;1499420612761537.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499420612887859.jpg&quot; style=&quot;&quot; title=&quot;1499420612887859.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f57f8b8d80.JPG\",\"\\/Uploads\\/2017-07-07\\/595f57f8b92d0.JPG\",\"\\/Uploads\\/2017-07-07\\/595f57f8b9716.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(188, 1, '88081', 1, 0, 23, 'TIMES 光学镜架88081', '/Uploads/2017-07-07/595f5b266178b.JPG', 'https://epeijing.cn/api/clJHbn', '498.00', '498.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499421250286959.jpg&quot; style=&quot;&quot; title=&quot;1499421250286959.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499421250578215.jpg&quot; style=&quot;&quot; title=&quot;1499421250578215.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f5b2661c4a.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5b2662029.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5b266243f.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5b26627e5.JPG\",\"\\/Uploads\\/2017-07-07\\/595f5b2662b3b.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(189, 1, '89013', 1, 0, 23, 'TIMES 光学镜架89013', '/Uploads/2017-07-07/595f676281a15.JPG', '', '498.00', '498.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499424467656066.jpg&quot; title=&quot;1499424467656066.jpg&quot; alt=&quot;89013_01.jpg&quot;/&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499424477232512.jpg&quot; title=&quot;1499424477232512.jpg&quot; alt=&quot;89013_02.jpg&quot;/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f676281f5e.JPG\",\"\\/Uploads\\/2017-07-07\\/595f67628249e.JPG\",\"\\/Uploads\\/2017-07-07\\/595f676282852.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(190, 1, 'D8234', 1, 0, 23, 'TIMES 光学眼镜D8234', '/Uploads/2017-07-07/595f7bd2ec81a.JPG', '', '598.00', '598.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499425014575304.jpg&quot; style=&quot;&quot; title=&quot;1499425014575304.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499425021640439.jpg&quot; style=&quot;&quot; title=&quot;1499425021640439.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f7bd2ece9f.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7bd2ed332.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7bd2ed73f.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(191, 1, 'D8230', 1, 0, 23, 'TIMES 光学镜架D8230', '/Uploads/2017-07-07/595f7b35955a4.JPG', 'https://epeijing.cn/api/R9iyv', '598.00', '598.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499425314544007.jpg&quot; style=&quot;&quot; title=&quot;1499425314544007.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499425318428663.jpg&quot; style=&quot;&quot; title=&quot;1499425318428663.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f7b3595b2f.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7b3595fa5.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7b35963ac.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(192, 1, '8812', 1, 0, 23, 'TIMES 光学眼镜8812', '/Uploads/2017-07-07/595f6e4a6c227.JPG', '', '398.00', '398.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426318555134.jpg&quot; style=&quot;&quot; title=&quot;1499426318555134.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426322553766.jpg&quot; style=&quot;&quot; title=&quot;1499426322553766.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f6e4a6c7e9.JPG\",\"\\/Uploads\\/2017-07-07\\/595f6e4a6ccf5.JPG\",\"\\/Uploads\\/2017-07-07\\/595f6e4a6d180.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(193, 1, '1073', 1, 0, 23, 'TIMES 光学眼镜1073', '/Uploads/2017-07-07/595f6f4cde92e.JPG', '', '498.00', '498.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426539523297.jpg&quot; style=&quot;&quot; title=&quot;1499426539523297.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426542743962.jpg&quot; style=&quot;&quot; title=&quot;1499426542743962.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f6f4cdef81.JPG\",\"\\/Uploads\\/2017-07-07\\/595f6f4cdf42b.JPG\",\"\\/Uploads\\/2017-07-07\\/595f6f4cdf87a.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(194, 1, '8837', 1, 0, 23, 'TIMES 光学眼镜8837', '/Uploads/2017-07-07/595f7dd770627.JPG', '', '398.00', '398.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426802672690.jpg&quot; style=&quot;&quot; title=&quot;1499426802672690.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499426806118379.jpg&quot; style=&quot;&quot; title=&quot;1499426806118379.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f71257f08c.JPG\",\"\\/Uploads\\/2017-07-07\\/595f71257f558.JPG\",\"\\/Uploads\\/2017-07-07\\/595f71257f970.JPG\",\"\\/Uploads\\/2017-07-07\\/595f71257ff05.JPG\",\"\\/Uploads\\/2017-07-07\\/595f712580520.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(195, 1, '8807', 1, 0, 23, 'TIMES 光学眼镜8807', '/Uploads/2017-07-07/595f7c3975a30.JPG', '', '398.00', '398.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499427818777480.jpg&quot; style=&quot;&quot; title=&quot;1499427818777480.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499427822506135.jpg&quot; style=&quot;&quot; title=&quot;1499427822506135.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f740d2e1d7.JPG\",\"\\/Uploads\\/2017-07-07\\/595f740d2e6b6.JPG\",\"\\/Uploads\\/2017-07-07\\/595f740d2eaf5.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(196, 1, 'D8204', 1, 0, 23, 'TIMES 光学眼镜D8204', '/Uploads/2017-07-07/595f7574d9de9.JPG', 'https://epeijing.cn/api/Fak0d', '598.00', '598.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428097666122.jpg&quot; style=&quot;&quot; title=&quot;1499428097666122.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428100799382.jpg&quot; style=&quot;&quot; title=&quot;1499428100799382.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428103871711.jpg&quot; style=&quot;&quot; title=&quot;1499428103871711.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f7574da3a2.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7574da8d9.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7574dadb1.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7574db28b.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(197, 1, '20055', 1, 0, 23, 'TIMES 光学眼镜20055', '/Uploads/2017-07-07/595f765075cdc.JPG', '', '398.00', '398.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428400846504.jpg&quot; style=&quot;&quot; title=&quot;1499428400846504.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428404339243.jpg&quot; style=&quot;&quot; title=&quot;1499428404339243.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f7e30ab769.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7e30abcb9.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7e30ac11b.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(198, 1, '8835', 1, 0, 23, 'TIMES 光学眼镜8835', '/Uploads/2017-07-07/595f7db265c0f.JPG', '', '398.00', '398.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428527365504.jpg&quot; style=&quot;&quot; title=&quot;1499428527365504.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428530797686.jpg&quot; style=&quot;&quot; title=&quot;1499428530797686.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f76e76a700.JPG\",\"\\/Uploads\\/2017-07-07\\/595f76e76ab99.JPG\",\"\\/Uploads\\/2017-07-07\\/595f76e76af28.JPG\",\"\\/Uploads\\/2017-07-07\\/595f76e76b474.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(199, 1, '8805', 1, 0, 0, 'TIMES 光学眼镜8805', '/Uploads/2017-07-07/595f779c8b04d.JPG', '', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428722740527.jpg&quot; style=&quot;&quot; title=&quot;1499428722740527.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499428724880525.jpg&quot; style=&quot;&quot; title=&quot;1499428724880525.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f779c8b5e9.JPG\",\"\\/Uploads\\/2017-07-07\\/595f779c8bc7f.JPG\",\"\\/Uploads\\/2017-07-07\\/595f779c8c1a8.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(200, 1, 'D8215', 1, 0, 23, 'TIMES 光学镜架D8215', '/Uploads/2017-07-07/595f797961b8a.JPG', 'https://epeijing.cn/api/bfQ6Ns', '598.00', '598.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499429159926659.jpg&quot; style=&quot;&quot; title=&quot;1499429159926659.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170707/1499429163311794.jpg&quot; style=&quot;&quot; title=&quot;1499429163311794.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-07\\/595f797962255.JPG\",\"\\/Uploads\\/2017-07-07\\/595f7979626a2.JPG\",\"\\/Uploads\\/2017-07-07\\/595f797962a7d.JPG\",\"\\/Uploads\\/2017-07-07\\/595f79796300d.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(201, 1, 'DS2', 1, 0, 23, 'TIMES 光学镜架DS2', '/Uploads/2017-07-10/596368985f5db.JPG', '', '498.00', '498.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499686781688239.jpg&quot; style=&quot;&quot; title=&quot;1499686781688239.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499686781657498.jpg&quot; style=&quot;&quot; title=&quot;1499686781657498.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-10\\/596368985fbca.JPG\",\"\\/Uploads\\/2017-07-10\\/596368986091b.JPG\",\"\\/Uploads\\/2017-07-10\\/5963689860045.JPG\",\"\\/Uploads\\/2017-07-10\\/5963689860df8.JPG\",\"\\/Uploads\\/2017-07-10\\/5963689860446.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(202, 1, '99001', 1, 0, 23, 'TIMES 光学镜架99001', '/Uploads/2017-07-10/59636e2a9e00e.JPG', '', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688345990317.jpg&quot; style=&quot;&quot; title=&quot;1499688345990317.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688345654416.jpg&quot; style=&quot;&quot; title=&quot;1499688345654416.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-10\\/59636de4bcf63.JPG\",\"\\/Uploads\\/2017-07-10\\/59636de4bd4bd.JPG\",\"\\/Uploads\\/2017-07-10\\/59636de4bd963.JPG\",\"\\/Uploads\\/2017-07-10\\/59636de4bddfb.JPG\",\"\\/Uploads\\/2017-07-10\\/59636de4be223.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(203, 1, 'M5213', 1, 0, 23, 'TIMES 光学镜架M5213', '/Uploads/2017-07-10/59636ef325261.JPG', '', '498.00', '498.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688643962703.jpg&quot; style=&quot;&quot; title=&quot;1499688643962703.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688643627507.jpg&quot; style=&quot;&quot; title=&quot;1499688643627507.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-10\\/59636ef325829.JPG\",\"\\/Uploads\\/2017-07-10\\/59636ef325c97.JPG\",\"\\/Uploads\\/2017-07-10\\/59636ef326071.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(204, 1, '99003', 1, 0, 23, 'TIMES 光学镜架99003', '/Uploads/2017-07-10/59636fffa4986.JPG', '', '498.00', '498.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688914445793.jpg&quot; style=&quot;&quot; title=&quot;1499688914445793.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170710/1499688914586921.jpg&quot; style=&quot;&quot; title=&quot;1499688914586921.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-07-10\\/59636fffd8f0d.JPG\",\"\\/Uploads\\/2017-07-10\\/59636fffd941b.JPG\",\"\\/Uploads\\/2017-07-10\\/59636fffd9843.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(205, 1, '888888', 1, 0, 23, '申请城市代理人资格', '', '', '0.10', '0.10', '0.00', 17, '', '\"\"', 1, 2, '15.00', '10.00', '5.00', 1),
(207, 1, 'bc17189', 1, 0, 21, 'TIMES太阳镜bc17189', '/Uploads/2017-08-25/599fc2fff344e.jpg', '', '180.00', '180.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170825/1503643699391122.jpg&quot; style=&quot;&quot; title=&quot;1503643699391122.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170825/1503643699833819.jpg&quot; style=&quot;&quot; title=&quot;1503643699833819.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-08-25\\/599fc2fff3a4f.jpg\",\"\\/Uploads\\/2017-08-25\\/599fc2fff3ef0.jpg\",\"\\/Uploads\\/2017-08-25\\/599fc30000266.jpg\",\"\\/Uploads\\/2017-08-25\\/599fc30000704.jpg\",\"\\/Uploads\\/2017-08-25\\/599fc30001216.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(208, 1, 'H90186', 1, 0, 23, 'TIMES光学镜架 H90186', '/Uploads/2017-09-15/59bb31800799c.jpg', '', '298.00', '298.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440068237684.jpg&quot; style=&quot;&quot; title=&quot;1505440068237684.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440068598038.jpg&quot; style=&quot;&quot; title=&quot;1505440068598038.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-15\\/59bb318007e30.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb31800820a.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb3180085a0.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb318008a18.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb318008d4b.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(209, 1, 'S10014', 1, 0, 23, 'TIMES光学镜架 S10014', '/Uploads/2017-09-15/59bb32309e3f4.jpg', '', '298.00', '298.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440269412170.jpg&quot; style=&quot;&quot; title=&quot;1505440269412170.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440269338107.jpg&quot; style=&quot;&quot; title=&quot;1505440269338107.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-15\\/59bb32309e747.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb32309ea31.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb32309ed36.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb32309f091.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb32309f481.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(210, 1, 'S22107', 1, 0, 23, 'TIMES光学镜架 S22107', '/Uploads/2017-09-15/59bb3292965b3.jpg', '', '298.00', '298.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440353634126.jpg&quot; style=&quot;&quot; title=&quot;1505440353634126.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440353680484.jpg&quot; style=&quot;&quot; title=&quot;1505440353680484.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-15\\/59bb32929698c.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb329296d2f.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb3292970af.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb3292973e9.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb3292976b9.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(211, 1, 'S22223', 1, 0, 23, 'TIMES光学镜架 S22223', '/Uploads/2017-09-15/59bb330d36997.jpg', '', '298.00', '298.00', '0.00', 19, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440463637898.jpg&quot; style=&quot;&quot; title=&quot;1505440463637898.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170915/1505440463644121.jpg&quot; style=&quot;&quot; title=&quot;1505440463644121.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-15\\/59bb330d36da6.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb330d37193.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb330d37547.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb330d37901.jpg\",\"\\/Uploads\\/2017-09-15\\/59bb330d37c7f.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(212, 1, 'bc6098', 1, 0, 21, 'TIMES太阳镜bc6098', '/Uploads/2017-09-25/59c891a8300b9.jpg', 'https://epeijing.cn/api/cunVB0', '298.00', '298.00', '0.00', 4, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170921/1505983437310035.jpg&quot; style=&quot;&quot; title=&quot;1505983437310035.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170921/1505983437402631.jpg&quot; style=&quot;&quot; title=&quot;1505983437402631.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c891a830866.jpg\",\"\\/Uploads\\/2017-09-25\\/59c891a831041.jpg\",\"\\/Uploads\\/2017-09-25\\/59c891a831cac.jpg\",\"\\/Uploads\\/2017-09-25\\/59c891a8328fd.jpg\",\"\\/Uploads\\/2017-09-25\\/59c891a8335d0.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(213, 1, 'js10606', 1, 0, 21, 'TIMES太阳镜js10606', '/Uploads/2017-09-25/59c890e50cc03.jpg', 'https://epeijing.cn/api/bZjfRJ', '180.00', '180.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506316423533155.jpg&quot; style=&quot;&quot; title=&quot;1506316423533155.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506316424286032.jpg&quot; style=&quot;&quot; title=&quot;1506316424286032.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c890e50d485.jpg\",\"\\/Uploads\\/2017-09-25\\/59c890e50daf0.jpg\",\"\\/Uploads\\/2017-09-25\\/59c890e50e5b1.jpg\",\"\\/Uploads\\/2017-09-25\\/59c890e50f1b1.jpg\",\"\\/Uploads\\/2017-09-25\\/59c890e50f932.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(214, 1, 'js17137', 1, 0, 21, 'TIMES太阳镜js17137', '/Uploads/2017-09-25/59c892c10f0b8.jpg', 'https://epeijing.cn/api/b5Lwkj', '180.00', '180.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506316891781151.jpg&quot; style=&quot;&quot; title=&quot;1506316891781151.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506316891439204.jpg&quot; style=&quot;&quot; title=&quot;1506316891439204.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c892c10fca5.jpg\",\"\\/Uploads\\/2017-09-25\\/59c892c1105ec.jpg\",\"\\/Uploads\\/2017-09-25\\/59c892c110e08.jpg\",\"\\/Uploads\\/2017-09-25\\/59c892c11148c.jpg\",\"\\/Uploads\\/2017-09-25\\/59c892c111b65.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(215, 1, 'js3026', 1, 0, 21, 'TIMES太阳镜js3026', '/Uploads/2017-09-25/59c893c40b6e7.jpg', 'https://epeijing.cn/api/Y2091', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506317144464059.jpg&quot; style=&quot;&quot; title=&quot;1506317144464059.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506317144965498.jpg&quot; style=&quot;&quot; title=&quot;1506317144965498.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c893c40be55.jpg\",\"\\/Uploads\\/2017-09-25\\/59c893c40c6f0.jpg\",\"\\/Uploads\\/2017-09-25\\/59c893c40cd89.jpg\",\"\\/Uploads\\/2017-09-25\\/59c893c40d3a0.jpg\",\"\\/Uploads\\/2017-09-25\\/59c893c40d9fe.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(216, 1, 'js7005', 1, 0, 21, 'TIMES太阳镜js7005', '/Uploads/2017-09-25/59c894fac1125.jpg', 'https://epeijing.cn/api/cj5A3S', '338.00', '338.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506317455761283.jpg&quot; style=&quot;&quot; title=&quot;1506317455761283.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506317455440550.jpg&quot; style=&quot;&quot; title=&quot;1506317455440550.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c894fac1eae.jpg\",\"\\/Uploads\\/2017-09-25\\/59c894fac27bb.jpg\",\"\\/Uploads\\/2017-09-25\\/59c894fac2e7b.jpg\",\"\\/Uploads\\/2017-09-25\\/59c894fac3531.jpg\",\"\\/Uploads\\/2017-09-25\\/59c894fac3c65.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(217, 1, 'js925KH', 1, 0, 21, 'TIMES太阳镜js925KH', '/Uploads/2017-09-25/59c897e33ebf1.jpg', 'https://epeijing.cn/api/5CDpL', '180.00', '180.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318141675800.jpg&quot; style=&quot;&quot; title=&quot;1506318141675800.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318141370758.jpg&quot; style=&quot;&quot; title=&quot;1506318141370758.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c897e33f339.jpg\",\"\\/Uploads\\/2017-09-25\\/59c897e33f907.jpg\",\"\\/Uploads\\/2017-09-25\\/59c897e33ff42.jpg\",\"\\/Uploads\\/2017-09-25\\/59c897e3404e6.jpg\",\"\\/Uploads\\/2017-09-25\\/59c897e340b4a.jpg\"]', 0, 2, '0.00', '0.00', '0.00', 1),
(218, 1, 'bc17068', 1, 0, 21, 'TIMES太阳镜bc17068', '/Uploads/2017-09-25/59c8c8a349cb0.jpg', 'https://epeijing.cn/api/bO1UM6', '180.00', '180.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318516660815.jpg&quot; style=&quot;&quot; title=&quot;1506318516660815.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318516367935.jpg&quot; style=&quot;&quot; title=&quot;1506318516367935.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c8a34a45d.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c8a34aac5.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c8a34b12c.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c8a34b73b.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(219, 1, 'jsS1963', 1, 0, 21, 'TIMES太阳镜jsS1963', '/Uploads/2017-09-25/59c899d3b160e.jpg', 'https://epeijing.cn/api/RsluJ', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318642731193.jpg&quot; style=&quot;&quot; title=&quot;1506318642731193.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506318642543082.jpg&quot; style=&quot;&quot; title=&quot;1506318642543082.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c899d3b2303.jpg\",\"\\/Uploads\\/2017-09-25\\/59c899d3b2a53.jpg\",\"\\/Uploads\\/2017-09-25\\/59c899d3b3038.jpg\",\"\\/Uploads\\/2017-09-25\\/59c899d3b3625.jpg\",\"\\/Uploads\\/2017-09-25\\/59c899d3b3b21.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(220, 1, 'jsS1967', 1, 0, 21, 'TIMES太阳镜jsS1967', '/Uploads/2017-09-25/59c89b5084147.jpg', 'https://epeijing.cn/api/600qR', '180.00', '180.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506319081322173.jpg&quot; style=&quot;&quot; title=&quot;1506319081322173.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506319081757717.jpg&quot; style=&quot;&quot; title=&quot;1506319081757717.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c89b5084908.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89b5084f2f.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89b508579c.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89b5085dd3.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89b50863cd.jpg\"]', 0, 2, '0.00', '0.00', '0.00', 1),
(221, 1, 'jsS1980', 1, 0, 21, 'TIMES太阳镜jsS1980', '/Uploads/2017-09-25/59c89cffd2083.jpg', 'https://epeijing.cn/api/bh9myI', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506319484749509.jpg&quot; style=&quot;&quot; title=&quot;1506319484749509.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506319484508800.jpg&quot; style=&quot;&quot; title=&quot;1506319484508800.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c89cffd27eb.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89cffd3075.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89cffd3758.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89cffd3f36.jpg\",\"\\/Uploads\\/2017-09-25\\/59c89cffd4646.jpg\"]', 0, 2, '0.00', '0.00', '0.00', 1),
(222, 1, 'jsS1987', 1, 0, 21, 'TIMES太阳镜jsS1987', '/Uploads/2017-09-25/59c8a15a3f304.jpg', 'https://epeijing.cn/api/BfhWA', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506320633877118.jpg&quot; style=&quot;&quot; title=&quot;1506320633877118.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506320633773460.jpg&quot; style=&quot;&quot; title=&quot;1506320633773460.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8a15a3fc52.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a15a40344.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a15a40a79.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a15a41090.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a15a4171f.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(223, 1, 'jsS1993', 1, 0, 21, 'TIMES太阳镜jsS1993', '/Uploads/2017-09-25/59c8a272c73b6.jpg', 'https://epeijing.cn/api/bTEJJU', '180.00', '180.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506320889842379.jpg&quot; style=&quot;&quot; title=&quot;1506320889842379.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506320889369593.jpg&quot; style=&quot;&quot; title=&quot;1506320889369593.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8a272c823f.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a272c9330.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a272c9c9d.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a272ca4c7.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a272cac5e.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(224, 1, 'jsS1995', 1, 0, 21, 'TIMES太阳镜jsS1995', '/Uploads/2017-09-25/59c8a87a39704.jpg', 'https://epeijing.cn/api/SeGeC', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506322346542877.jpg&quot; style=&quot;&quot; title=&quot;1506322346542877.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506322346961775.jpg&quot; style=&quot;&quot; title=&quot;1506322346961775.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8a87a39ebd.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a87a3a54f.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a87a3ab59.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a87a3b15e.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8a87a3b6fb.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(225, 1, 'jsS1996', 1, 0, 21, 'TIMES太阳镜jsS1996', '/Uploads/2017-09-25/59c8aa65c7fba.jpg', 'https://epeijing.cn/api/6FVeW', '180.00', '180.00', '0.00', 4, '', '[\"\\/Uploads\\/2017-09-25\\/59c8aa65c87e2.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aa65c93e0.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aa65c9d23.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aa65ca4a4.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aa65cac03.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(226, 1, 'jsS1999', 1, 0, 21, 'TIMES太阳镜jsS1999', '/Uploads/2017-09-25/59c8ab7cef522.jpg', 'https://epeijing.cn/api/AuRH9', '180.00', '180.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506323188413365.jpg&quot; style=&quot;&quot; title=&quot;1506323188413365.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506323189787481.jpg&quot; style=&quot;&quot; title=&quot;1506323189787481.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8ab7cefd4c.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8ab7cf04dc.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8ab7cf0b74.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8ab7cf1172.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8ab7cf1854.jpg\"]', 0, 2, '0.00', '0.00', '0.00', 1),
(227, 1, 'jsS30013', 1, 0, 21, 'TIMES太阳镜jsS30013', '/Uploads/2017-09-25/59c8aeaf44e08.jpg', 'https://epeijing.cn/api/bm0Gum', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324039832734.jpg&quot; style=&quot;&quot; title=&quot;1506324039832734.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324039629357.jpg&quot; style=&quot;&quot; title=&quot;1506324039629357.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8aeaf45c06.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aeaf465e7.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aeaf46e03.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aeaf475aa.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8aeaf47c7e.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(228, 1, 'jsS30039', 1, 0, 21, 'TIMES太阳镜jsS30039', '/Uploads/2017-09-25/59c8b11edc63b.jpg', 'https://epeijing.cn/api/b1z1QR', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324647459006.jpg&quot; style=&quot;&quot; title=&quot;1506324647459006.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324647994171.jpg&quot; style=&quot;&quot; title=&quot;1506324647994171.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8b11edccb9.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b11edd442.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b11eddab6.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b11eddfe7.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b11ede493.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(229, 1, 'jsS30043', 1, 0, 21, 'TIMES太阳镜jsS30043', '/Uploads/2017-09-25/59c8b2454c351.jpg', 'https://epeijing.cn/api/KDOOv', '180.00', '180.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324943184798.jpg&quot; style=&quot;&quot; title=&quot;1506324943184798.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506324943775467.jpg&quot; style=&quot;&quot; title=&quot;1506324943775467.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8b2454cb04.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b2454d1cf.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b2454d9eb.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b2454e10c.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b2454e72c.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(230, 1, 'bcS30044', 1, 0, 21, 'TIMES太阳镜bcS30044', '/Uploads/2017-09-25/59c8b3f9911ae.jpg', 'https://epeijing.cn/api/BGj5b', '180.00', '180.00', '0.00', 9, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506325367266172.jpg&quot; style=&quot;&quot; title=&quot;1506325367266172.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506325367723226.jpg&quot; style=&quot;&quot; title=&quot;1506325367723226.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8b3f991cc7.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b3f9927cd.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b3f992e4d.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b3f9932fe.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b3f99371f.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(231, 1, 'jsS30048', 1, 0, 21, 'TIMES太阳镜jsS30048', '/Uploads/2017-09-25/59c8b4e963767.jpg', 'https://epeijing.cn/api/WMhlR', '180.00', '180.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506325659808225.jpg&quot; style=&quot;&quot; title=&quot;1506325659808225.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506325659646606.jpg&quot; style=&quot;&quot; title=&quot;1506325659646606.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8b4e964162.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b4e9648bd.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b4e964ffb.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b4e965632.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8b4e965d5b.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(232, 1, 'bcS30065', 1, 0, 21, 'TIMES太阳镜bcS30065', '/Uploads/2017-09-25/59c8bfa1ec82a.jpg', 'https://epeijing.cn/api/bIBne5', '180.00', '180.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506328390982600.jpg&quot; style=&quot;&quot; title=&quot;1506328390982600.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506328390675357.jpg&quot; style=&quot;&quot; title=&quot;1506328390675357.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8bf969da03.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8bf969e1b1.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8bf969e7fe.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8bf969ee67.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8bf969f650.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(233, 1, 'jsS30079', 1, 0, 21, 'TIMES太阳镜jsS30079', '/Uploads/2017-09-25/59c8c095d8f34.jpg', 'https://epeijing.cn/api/bIkl5Y', '180.00', '180.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506328616943103.jpg&quot; style=&quot;&quot; title=&quot;1506328616943103.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506328616503997.jpg&quot; style=&quot;&quot; title=&quot;1506328616503997.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c095d9500.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c095d9a38.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c095da1b5.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c095da7da.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c095dad68.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(234, 1, 'jsS925-2', 1, 0, 21, 'TIMES太阳镜jsS925-2', '/Uploads/2017-09-25/59c8c22d62365.jpg', 'https://epeijing.cn/api/bTcYCF', '180.00', '180.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506329094464858.jpg&quot; style=&quot;&quot; title=&quot;1506329094464858.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506329094809388.jpg&quot; style=&quot;&quot; title=&quot;1506329094809388.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c22d6307e.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c22d639ce.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c22d640b1.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c22d64764.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c22d64dbe.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(235, 1, 'qk115', 1, 0, 23, 'TIMES光学镜架 qk115', '/Uploads/2017-09-25/59c8c48461ae9.JPG', 'https://epeijing.cn/api/crQtlv', '198.00', '198.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506329649111316.jpg&quot; style=&quot;&quot; title=&quot;1506329649111316.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506329649553748.jpg&quot; style=&quot;&quot; title=&quot;1506329649553748.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c48461f53.JPG\",\"\\/Uploads\\/2017-09-25\\/59c8c484622f2.JPG\",\"\\/Uploads\\/2017-09-25\\/59c8c48462718.JPG\",\"\\/Uploads\\/2017-09-25\\/59c8c48462a75.JPG\",\"\\/Uploads\\/2017-09-25\\/59c8c48462f0c.JPG\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(236, 1, 'qk130', 1, 0, 23, 'TIMES光学镜架qk130', '/Uploads/2017-09-25/59c8c70e0da75.jpg', 'https://epeijing.cn/api/8IJsa', '198.00', '198.00', '0.00', 6, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506330319617194.jpg&quot; style=&quot;&quot; title=&quot;1506330319617194.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506330319607817.jpg&quot; style=&quot;&quot; title=&quot;1506330319607817.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c70e0dee5.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c70e0e256.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c70e0e5e1.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c70e0e994.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c70e0ed41.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(237, 1, 'qk9211', 1, 0, 23, 'TIMES光学镜架qk9211', '/Uploads/2017-09-25/59c8c809f3e84.jpg', 'https://epeijing.cn/api/bepmLo', '198.00', '198.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506330522375987.jpg&quot; style=&quot;&quot; title=&quot;1506330522375987.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20170925/1506330523286233.jpg&quot; style=&quot;&quot; title=&quot;1506330523286233.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-09-25\\/59c8c80a002fa.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c80a00920.jpg\",\"\\/Uploads\\/2017-09-25\\/59c8c80a00e83.jpg\"]', 1, 2, '15.00', '10.00', '0.00', 1),
(239, 1, 'qkJB1522', 1, 0, 23, 'TIMES2017新款光学镜qkJB1522', '/Uploads/2017-12-29/5a45bae9993d7.jpg', '', '398.00', '398.00', '0.00', 3, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514518787200770.jpg&quot; style=&quot;&quot; title=&quot;1514518787200770.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514518794596794.jpg&quot; style=&quot;&quot; title=&quot;1514518794596794.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45bae999d92.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45bae99a363.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45bae99a8d5.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45bae99ae54.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45bae99b34f.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(240, 1, 'bkJB1560', 1, 0, 23, 'TIMES光学镜架bkJB1560', '/Uploads/2017-12-29/5a45d96f96d17.jpg', '', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514527020365874.jpg&quot; style=&quot;&quot; title=&quot;1514527020365874.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514527020594815.jpg&quot; style=&quot;&quot; title=&quot;1514527020594815.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45d96f972e7.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45d96f978b1.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45d96f97dc5.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45d96f98306.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45d96f987a3.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(241, 1, 'qkJBD6102', 1, 0, 23, 'TIMES光学镜架qkJBD6102', '/Uploads/2017-12-29/5a45eeb8bb115.jpg', '', '398.00', '398.00', '0.00', 7, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514532456542564.jpg&quot; style=&quot;&quot; title=&quot;1514532456542564.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514532456761704.jpg&quot; style=&quot;&quot; title=&quot;1514532456761704.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45eeb8bb5e9.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45eeb8bbbf2.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45eeb8bc066.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45eeb8bc588.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45eeb8bcacc.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(242, 1, 'qkJBD6111', 1, 0, 23, 'TIMES光学镜架qkJBD6111', '/Uploads/2017-12-29/5a45f424f0399.jpg', '', '398.00', '398.00', '0.00', 6, '&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514533839237795.jpg&quot; title=&quot;1514533839237795.jpg&quot; alt=&quot;6111（微信）_01.jpg&quot;/&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514533862750092.jpg&quot; title=&quot;1514533862750092.jpg&quot; alt=&quot;6111（微信）_02.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45f424f08e5.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f424f0d8f.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f424f11fd.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f424f1667.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f424f1b9e.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(243, 1, 'qkJB10017', 1, 0, 23, 'TIMES光学镜架qkJB10017', '/Uploads/2017-12-29/5a45f6d7ac374.jpg', '', '398.00', '398.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514534511315885.jpg&quot; style=&quot;&quot; title=&quot;1514534511315885.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514534511750368.jpg&quot; style=&quot;&quot; title=&quot;1514534511750368.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45f6d7aca0b.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f6d7acf95.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f6d7ad5e1.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f6d7adb6e.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45f6d7ae167.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(244, 1, 'qkJB100023', 1, 0, 23, 'TIMES光学镜架qkJB100023', '/Uploads/2017-12-29/5a45fd77a3df5.jpg', '', '398.00', '398.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514536234904501.jpg&quot; style=&quot;&quot; title=&quot;1514536234904501.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20171229/1514536234295873.jpg&quot; style=&quot;&quot; title=&quot;1514536234295873.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2017-12-29\\/5a45fd77a4338.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45fd77a48ce.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45fd77a4d66.jpg\",\"\\/Uploads\\/2017-12-29\\/5a45fd77a52af.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(245, 1, 'qkJB100028', 1, 0, 23, 'TIMES光学镜架qkJB100028', '/Uploads/2017-12-29/5a4600038c358.jpg', '', '398.00', '398.00', '0.00', 3, '', '[\"\\/Uploads\\/2017-12-29\\/5a4600038c886.jpg\",\"\\/Uploads\\/2017-12-29\\/5a4600038cd01.jpg\",\"\\/Uploads\\/2017-12-29\\/5a4600038d1d8.jpg\",\"\\/Uploads\\/2017-12-29\\/5a4600038d707.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(246, 1, 'qkJB100037', 1, 0, 23, 'TIMES光学镜架qkJB100037', '/Uploads/2018-01-02/5a4afe21b935d.jpg', '', '398.00', '398.00', '0.00', 8, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864129290506.jpg&quot; style=&quot;&quot; title=&quot;1514864129290506.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864129357218.jpg&quot; style=&quot;&quot; title=&quot;1514864129357218.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2018-01-02\\/5a4afe21b9b39.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afe21ba028.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afe21ba468.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afe21ba9b7.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(247, 1, 'qkJB100040', 1, 0, 23, 'TIMES光学镜架qkJB100040', '/Uploads/2018-01-02/5a4afee8487dc.jpg', '', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864322486824.jpg&quot; style=&quot;&quot; title=&quot;1514864322486824.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864322706871.jpg&quot; style=&quot;&quot; title=&quot;1514864322706871.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2018-01-02\\/5a4afee848e61.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afee84939c.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afee8497e5.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4afee849ced.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(248, 1, 'qkJB100041', 1, 0, 23, 'TIMES光学镜架qkJB100041', '/Uploads/2018-01-02/5a4affacab66b.jpg', '', '398.00', '398.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864496873079.jpg&quot; style=&quot;&quot; title=&quot;1514864496873079.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864496444026.jpg&quot; style=&quot;&quot; title=&quot;1514864496444026.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2018-01-02\\/5a4affacabbc3.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4affacac0d2.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4affacac67a.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4affacacb25.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4affacacf59.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(249, 1, 'qkJB100057', 1, 0, 23, 'TIMES光学镜架qkJB100057', '/Uploads/2018-01-02/5a4b01898c3f4.jpg', '', '398.00', '398.00', '0.00', 5, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864971252834.jpg&quot; style=&quot;&quot; title=&quot;1514864971252834.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514864971433503.jpg&quot; style=&quot;&quot; title=&quot;1514864971433503.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2018-01-02\\/5a4b01898ca51.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b01898d065.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b01898d601.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b01898db9d.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b01898e0c2.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1),
(250, 1, 'qkJB170011', 1, 0, 23, 'TIMES光学镜架qkJB170011', '/Uploads/2018-01-02/5a4b02435ce12.jpg', '', '398.00', '398.00', '0.00', 4, '&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514865168310895.jpg&quot; style=&quot;&quot; title=&quot;1514865168310895.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180102/1514865168402566.jpg&quot; style=&quot;&quot; title=&quot;1514865168402566.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '[\"\\/Uploads\\/2018-01-02\\/5a4b02435d33a.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b02435d80a.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b02435dc3c.jpg\",\"\\/Uploads\\/2018-01-02\\/5a4b02435e178.jpg\"]', 1, 2, '0.00', '0.00', '0.00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `commodity_comment`
--

CREATE TABLE `commodity_comment` (
  `commodity_commentid` int(11) NOT NULL,
  `commodityid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `sku_value` varchar(45) NOT NULL COMMENT '属性值',
  `seller_content` varchar(255) NOT NULL COMMENT '卖家回复',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commodity_comment`
--

INSERT INTO `commodity_comment` (`commodity_commentid`, `commodityid`, `uid`, `content`, `sku_value`, `seller_content`, `time`) VALUES
(1, 81, 384, '很好的商品', '棕色', '', '2017-07-17 03:57:36'),
(2, 205, 15, '好', '绿色', '', '2018-01-26 08:15:49'),
(3, 205, 53, '好', '资格', '', '2018-01-26 08:32:43'),
(4, 205, 15, '好', '资格', '', '2018-01-30 02:17:47');

-- --------------------------------------------------------

--
-- Table structure for table `commodity_sku`
--

CREATE TABLE `commodity_sku` (
  `commodity_skuid` int(11) NOT NULL,
  `commodityid` int(11) NOT NULL,
  `shuxingji` text NOT NULL,
  `attr` varchar(100) NOT NULL,
  `stock` int(2) NOT NULL,
  `attr_money` decimal(10,2) NOT NULL,
  `bianma` varchar(50) NOT NULL COMMENT 'sku编码',
  `product_no` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '商品编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commodity_sku`
--

INSERT INTO `commodity_sku` (`commodity_skuid`, `commodityid`, `shuxingji`, `attr`, `stock`, `attr_money`, `bianma`, `product_no`) VALUES
(1992, 60, '[{\"attr\":\"颜色\",\"val\":[\"红色\"]}]', '红色', 555, '599.00', '', NULL),
(1993, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黑色,S', 885, '0.01', '', NULL),
(1994, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黑色,M', 79, '599.00', '', NULL),
(1995, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黑色,L', 57, '599.00', '', NULL),
(1996, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黑色,XL', 543, '599.00', '', NULL),
(1997, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '红色,S', 24, '599.00', '', NULL),
(1998, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '红色,M', 35, '599.00', '', NULL),
(1999, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '红色,L', 87, '599.00', '', NULL),
(2000, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '红色,XL', 85, '599.00', '', NULL),
(2001, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黄色,S', 68, '599.00', '', NULL),
(2002, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黄色,M', 68, '599.00', '', NULL),
(2003, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黄色,L', 35, '599.00', '', NULL),
(2004, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '黄色,XL', 42, '599.00', '', NULL),
(2005, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '绿色,S', 14, '599.00', '', NULL),
(2006, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '绿色,M', 22, '599.00', '', NULL),
(2007, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '绿色,L', 35, '599.00', '', NULL),
(2008, 58, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"红色\",\"黄色\",\"绿色\"]},{\"attr\":\"尺寸\",\"val\":[\"S\",\"M\",\"L\",\"XL\"]}]', '绿色,XL', 68, '599.00', '', NULL),
(2009, 57, '[{\"attr\":\"颜色\",\"val\":[\"红\"]}]', '红', 499, '100.00', '010', NULL),
(2010, 54, '[{\"attr\":\"尺寸\",\"val\":[\"XL\"]}]', 'XL', 579, '899.00', '', NULL),
(2011, 53, '[{\"attr\":\"尺寸\",\"val\":[\"L\"]}]', 'L', 666, '399.00', '', NULL),
(2074, 83, '[{\"attr\":\"颜色\",\"val\":[\"red\"]}]', 'red', 5, '5.00', '', NULL),
(2115, 113, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"白色\"]}]', '黑色', 12, '213.00', '123', ''),
(2116, 113, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"白色\"]}]', '白色', 1, '1123.00', '369', ''),
(2131, 108, '[{\"attr\":\"颜色\",\"val\":[\"撒旦\"]}]', '撒旦', 1, '1.00', '36969', ''),
(2132, 114, '[{\"attr\":\"颜色\",\"val\":[\"lanse \",\"黑色\"]}]', 'lanse ', 2, '1.00', '369', NULL),
(2146, 141, '[{\"attr\":\"颜色\",\"val\":[\"五颜六色\"]}]', '五颜六色', 1, '1231.00', '36999', ''),
(2147, 142, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 30, '299.00', '', NULL),
(2148, 143, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 30, '299.00', '', NULL),
(2149, 144, '[{\"attr\":\"颜色\",\"val\":[\"1\"]}]', '1', 1, '1.00', '1', NULL),
(2152, 146, '[{\"attr\":\"颜色\",\"val\":[\"墨绿\"]}]', '墨绿', 11, '1111.00', '213122', NULL),
(2153, 147, '[{\"attr\":\"颜色\",\"val\":[\"绿色\"]}]', '绿色', 1, '1.00', '111231', NULL),
(2154, 148, '[{\"attr\":\"颜色\",\"val\":[\"绿色\",\"黑色\"]}]', '绿色', 1, '1.00', '3696978942', NULL),
(2155, 148, '[{\"attr\":\"颜色\",\"val\":[\"绿色\",\"黑色\"]}]', '黑色', 1, '1.00', '', NULL),
(2156, 149, '[{\"attr\":\"颜色\",\"val\":[\"绿色\",\"黑色\"]}]', '绿色', 1, '1.00', '369871', NULL),
(2157, 149, '[{\"attr\":\"颜色\",\"val\":[\"绿色\",\"黑色\"]}]', '黑色', 1, '1.00', '', NULL),
(2158, 150, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"蓝色\",\"白色\"]}]', '黑色', 11, '111.00', '36987412', NULL),
(2159, 150, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"蓝色\",\"白色\"]}]', '蓝色', 11, '111.00', '', NULL),
(2160, 150, '[{\"attr\":\"颜色\",\"val\":[\"黑色\",\"蓝色\",\"白色\"]}]', '白色', 11, '111.00', '', NULL),
(2198, 165, '[{\"attr\":\"颜色\",\"val\":[\"墨绿\"]}]', '墨绿', 123, '123.00', '36945', NULL),
(2199, 166, '[{\"attr\":\"颜色\",\"val\":[\"1\"]}]', '1', 1, '1.00', '369963', NULL),
(2229, 183, '[{\"attr\":\"颜色\",\"val\":[\"C2-银色\"]}]', 'C2-银色', 0, '498.00', '', NULL),
(2236, 185, '[{\"attr\":\"颜色\",\"val\":[\"C1  -黑色\",\"C2-银色\"]}]', 'C1  -黑色', 0, '498.00', '', NULL),
(2237, 185, '[{\"attr\":\"颜色\",\"val\":[\"C1  -黑色\",\"C2-银色\"]}]', 'C2-银色', 0, '498.00', '', NULL),
(2238, 184, '[{\"attr\":\"颜色\",\"val\":[\"C1-琥珀色\"]}]', 'C1-琥珀色', 0, '398.00', '', NULL),
(2247, 186, '[{\"attr\":\"颜色\",\"val\":[\"A01-黑色\"]}]', 'A01-黑色', 0, '498.00', '', NULL),
(2322, 201, '[{\"attr\":\"颜色\",\"val\":[\"C22-琥珀色\",\"C201-黑色\"]}]', 'C22-琥珀色', 0, '498.00', '', NULL),
(2323, 201, '[{\"attr\":\"颜色\",\"val\":[\"C22-琥珀色\",\"C201-黑色\"]}]', 'C201-黑色', 0, '498.00', '', NULL),
(2326, 202, '[{\"attr\":\"颜色\",\"val\":[\"C1-H黑色\",\"C7-琥珀色\"]}]', 'C1-H黑色', 0, '498.00', '', NULL),
(2327, 202, '[{\"attr\":\"颜色\",\"val\":[\"C1-H黑色\",\"C7-琥珀色\"]}]', 'C7-琥珀色', 0, '498.00', '', NULL),
(2328, 203, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '498.00', '', NULL),
(2330, 189, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '498.00', '', NULL),
(2331, 204, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '498.00', '', NULL),
(2334, 187, '[{\"attr\":\"颜色\",\"val\":[\"A01-黑金色\"]}]', 'A01-黑金色', 0, '498.00', '', NULL),
(2335, 197, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '398.00', '', NULL),
(2338, 199, '[{\"attr\":\"颜色\",\"val\":[\"C3-琥珀\"]}]', 'C3-琥珀', 0, '398.00', '', NULL),
(2339, 198, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C4-琥珀\"]}]', 'C1-黑色', 0, '398.00', '', NULL),
(2340, 198, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C4-琥珀\"]}]', 'C4-琥珀', 0, '398.00', '', NULL),
(2345, 195, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '398.00', '', NULL),
(2346, 194, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C3-妃色花纹\",\"C4-琥珀花纹\"]}]', 'C1-黑色', 0, '398.00', '', NULL),
(2347, 194, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C3-妃色花纹\",\"C4-琥珀花纹\"]}]', 'C3-妃色花纹', 0, '398.00', '', NULL),
(2348, 194, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C3-妃色花纹\",\"C4-琥珀花纹\"]}]', 'C4-琥珀花纹', 0, '398.00', '', NULL),
(2349, 193, '[{\"attr\":\"颜色\",\"val\":[\"C10-花色\"]}]', 'C10-花色', 0, '498.00', '', NULL),
(2350, 192, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '398.00', '', NULL),
(2352, 190, '[{\"attr\":\"颜色\",\"val\":[\"C6-黑色\"]}]', 'C6-黑色', 0, '598.00', '', NULL),
(2353, 167, '[{\"attr\":\"颜色\",\"val\":[\"红色\"]}]', '红色', 9, '398.00', '', NULL),
(2360, 206, '[{\"attr\":\"份数\",\"val\":[\"red\",\"1\"]}]', 'red', 0, '0.00', '', NULL),
(2361, 206, '[{\"attr\":\"份数\",\"val\":[\"red\",\"1\"]}]', '1', 123, '213.00', '', NULL),
(2369, 208, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框黑腿\",\"C5-灰框金腿\"]}]', 'C1-黑框金腿', 0, '298.00', '', NULL),
(2370, 208, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框黑腿\",\"C5-灰框金腿\"]}]', 'C2-黑框黑腿', 0, '298.00', '', NULL),
(2371, 208, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框黑腿\",\"C5-灰框金腿\"]}]', 'C5-灰框金腿', 0, '298.00', '', NULL),
(2372, 209, '[{\"attr\":\"颜色\",\"val\":[\"C15-银框银腿\"]}]', 'C15-银框银腿', 0, '298.00', '', NULL),
(2373, 210, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框银腿\",\"C6-黑褐色\"]}]', 'C1-黑框金腿', 0, '298.00', '', NULL),
(2374, 210, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框银腿\",\"C6-黑褐色\"]}]', 'C2-黑框银腿', 0, '298.00', '', NULL),
(2375, 210, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑框金腿\",\"C2-黑框银腿\",\"C6-黑褐色\"]}]', 'C6-黑褐色', 0, '298.00', '', NULL),
(2384, 211, '[{\"attr\":\"颜色\",\"val\":[\"C12-黑框黑腿\",\"C13-金框黑腿\",\"C31-黑框黑腿\",\"C32-黑框黑腿\"]}]', 'C12-黑框黑腿', 0, '298.00', '', NULL),
(2385, 211, '[{\"attr\":\"颜色\",\"val\":[\"C12-黑框黑腿\",\"C13-金框黑腿\",\"C31-黑框黑腿\",\"C32-黑框黑腿\"]}]', 'C13-金框黑腿', 0, '298.00', '', NULL),
(2386, 211, '[{\"attr\":\"颜色\",\"val\":[\"C12-黑框黑腿\",\"C13-金框黑腿\",\"C31-黑框黑腿\",\"C32-黑框黑腿\"]}]', 'C31-黑框黑腿', 0, '298.00', '', NULL),
(2387, 211, '[{\"attr\":\"颜色\",\"val\":[\"C12-黑框黑腿\",\"C13-金框黑腿\",\"C31-黑框黑腿\",\"C32-黑框黑腿\"]}]', 'C32-黑框黑腿', 0, '298.00', '', NULL),
(2527, 145, '[{\"attr\":\"颜色\",\"val\":[\"C3-黑色\"]}]', 'C3-黑色', 0, '398.00', '', NULL),
(2528, 170, '[{\"attr\":\"颜色\",\"val\":[\"C2-豹纹\",\"C4-粉色豹纹\"]}]', 'C2-豹纹', 0, '398.00', '', NULL),
(2529, 170, '[{\"attr\":\"颜色\",\"val\":[\"C2-豹纹\",\"C4-粉色豹纹\"]}]', 'C4-粉色豹纹', 0, '398.00', '', NULL),
(2530, 168, '[{\"attr\":\"颜色\",\"val\":[\"C2-黑色\"]}]', 'C2-黑色', 0, '398.00', '', NULL),
(2531, 152, '[{\"attr\":\"颜色\",\"val\":[\"C2-黑色\"]}]', 'C2-黑色', 0, '398.00', '', NULL),
(2532, 169, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '498.00', '', NULL),
(2535, 172, '[{\"attr\":\"颜色\",\"val\":[\"C5-灰色\",\"C1-黑色\"]}]', 'C5-灰色', 0, '498.00', '', NULL),
(2536, 172, '[{\"attr\":\"颜色\",\"val\":[\"C5-灰色\",\"C1-黑色\"]}]', 'C1-黑色', 0, '498.00', '', NULL),
(2537, 188, '[{\"attr\":\"颜色\",\"val\":[\"C2-黑色\",\"C4-银灰色\"]}]', 'C2-黑色', 0, '498.00', '', NULL),
(2538, 188, '[{\"attr\":\"颜色\",\"val\":[\"C2-黑色\",\"C4-银灰色\"]}]', 'C4-银灰色', 0, '498.00', '', NULL),
(2539, 151, '[{\"attr\":\"颜色\",\"val\":[\"C8-黑色\"]}]', 'C8-黑色', 0, '398.00', '', NULL),
(2544, 174, '[{\"attr\":\"颜色\",\"val\":[\"C6-豹纹\"]}]', 'C6-豹纹', 0, '598.00', '', NULL),
(2545, 200, '[{\"attr\":\"颜色\",\"val\":[\"C7-典雅黑\",\"C8-红豹纹\"]}]', 'C7-典雅黑', 0, '598.00', '', NULL),
(2546, 200, '[{\"attr\":\"颜色\",\"val\":[\"C7-典雅黑\",\"C8-红豹纹\"]}]', 'C8-红豹纹', 0, '598.00', '', NULL),
(2547, 175, '[{\"attr\":\"颜色\",\"val\":[\"C7-黑色\"]}]', 'C7-黑色', 0, '598.00', '', NULL),
(2548, 196, '[{\"attr\":\"颜色\",\"val\":[\"C1-磨砂黑\",\"C5-钢琴黑\",\"C7-纯黑\",\"C8-琥珀\"]}]', 'C1-磨砂黑', 0, '598.00', '', NULL),
(2549, 196, '[{\"attr\":\"颜色\",\"val\":[\"C1-磨砂黑\",\"C5-钢琴黑\",\"C7-纯黑\",\"C8-琥珀\"]}]', 'C5-钢琴黑', 0, '598.00', '', NULL),
(2550, 196, '[{\"attr\":\"颜色\",\"val\":[\"C1-磨砂黑\",\"C5-钢琴黑\",\"C7-纯黑\",\"C8-琥珀\"]}]', 'C7-纯黑', 0, '598.00', '', NULL),
(2551, 196, '[{\"attr\":\"颜色\",\"val\":[\"C1-磨砂黑\",\"C5-钢琴黑\",\"C7-纯黑\",\"C8-琥珀\"]}]', 'C8-琥珀', 0, '598.00', '', NULL),
(2552, 176, '[{\"attr\":\"颜色\",\"val\":[\"C8-豹纹\"]}]', 'C8-豹纹', 0, '598.00', '', NULL),
(2553, 191, '[{\"attr\":\"颜色\",\"val\":[\"C8-豹纹\"]}]', 'C8-豹纹', 0, '598.00', '', NULL),
(2554, 177, '[{\"attr\":\"颜色\",\"val\":[\"C7-钢琴黑\"]}]', 'C7-钢琴黑', 0, '598.00', '', NULL),
(2555, 178, '[{\"attr\":\"颜色\",\"val\":[\"C7-黑色\"]}]', 'C7-黑色', 0, '598.00', '', NULL),
(2556, 179, '[{\"attr\":\"颜色\",\"val\":[\"C7-黑色\"]}]', 'C7-黑色', 0, '598.00', '', NULL),
(2557, 180, '[{\"attr\":\"颜色\",\"val\":[\"C9-透明色\"]}]', 'C9-透明色', 0, '598.00', '', NULL),
(2558, 181, '[{\"attr\":\"颜色\",\"val\":[\"C3-钢琴黑\",\"C2-青色\"]}]', 'C3-钢琴黑', 0, '598.00', '', NULL),
(2559, 181, '[{\"attr\":\"颜色\",\"val\":[\"C3-钢琴黑\",\"C2-青色\"]}]', 'C2-青色', 0, '598.00', '', NULL),
(2560, 182, '[{\"attr\":\"颜色\",\"val\":[\"C6-酒红色\",\"C7-黑色\"]}]', 'C6-酒红色', 0, '598.00', '', NULL),
(2561, 182, '[{\"attr\":\"颜色\",\"val\":[\"C6-酒红色\",\"C7-黑色\"]}]', 'C7-黑色', 0, '598.00', '', NULL),
(2562, 171, '[{\"attr\":\"颜色\",\"val\":[\"A01-黑框灰腿\"]}]', 'A01-黑框灰腿', 0, '0.00', '', NULL),
(2563, 173, '[{\"attr\":\"颜色\",\"val\":[\"C11-黑色\"]}]', 'C11-黑色', 0, '498.00', '', NULL),
(2569, 77, '[{\"attr\":\"颜色\",\"val\":[\"豹纹\"]}]', '豹纹', 7, '298.00', '', NULL),
(2570, 76, '[{\"attr\":\"颜色\",\"val\":[\"黑色C1\",\"蓝色C3\"]}]', '黑色C1', 7, '298.00', '', NULL),
(2571, 76, '[{\"attr\":\"颜色\",\"val\":[\"黑色C1\",\"蓝色C3\"]}]', '蓝色C3', 9, '298.00', '', NULL),
(2572, 71, '[{\"attr\":\"颜色\",\"val\":[\"豹纹黑\"]}]', '豹纹黑', 9, '398.00', '', NULL),
(2573, 63, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 16, '398.00', '', NULL),
(2574, 62, '[{\"attr\":\"颜色\",\"val\":[\"钢琴黑\"]}]', '钢琴黑', 27, '398.00', '', NULL),
(2575, 68, '[{\"attr\":\"颜色\",\"val\":[\"金属黑\"]}]', '金属黑', 13, '298.00', '', NULL),
(2577, 69, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 9, '398.00', '', NULL),
(2578, 64, '[{\"attr\":\"颜色\",\"val\":[\"豹纹\"]}]', '豹纹', 25, '398.00', '', NULL),
(2579, 65, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 11, '198.00', '', NULL),
(2580, 72, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 8, '298.00', '', NULL),
(2581, 73, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 5, '198.00', '', NULL),
(2583, 75, '[{\"attr\":\"颜色\",\"val\":[\"豹纹\"]}]', '豹纹', 7, '198.00', '', NULL),
(2584, 67, '[{\"attr\":\"颜色\",\"val\":[\"豹纹\"]}]', '豹纹', 12, '398.00', '', NULL),
(2585, 74, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 6, '198.00', '', NULL),
(2586, 70, '[{\"attr\":\"颜色\",\"val\":[\"花色\"]}]', '花色', 8, '398.00', '', NULL),
(2587, 66, '[{\"attr\":\"颜色\",\"val\":[\"紫色\"]}]', '紫色', 13, '198.00', '', NULL),
(2588, 61, '[{\"attr\":\"颜色\",\"val\":[\"酒红色\"]}]', '酒红色', 59, '398.00', '', NULL),
(2589, 238, '[{\"attr\":\"颜色\",\"val\":[\"蓝\"]}]', '蓝', 10, '9999.00', '', NULL),
(2624, 250, '[{\"attr\":\"颜色\",\"val\":[\"C5-黑银色\"]}]', 'C5-黑银色', 0, '398.00', '171211000087', 'timesqkJB170011C5'),
(2625, 249, '[{\"attr\":\"颜色\",\"val\":[\"C2-金色\",\"C4-玫瑰金\",\"C3-银色\",\"C6-黑金\"]}]', 'C2-金色', 0, '398.00', '171211000076', 'timesqkJB100057C2'),
(2626, 249, '[{\"attr\":\"颜色\",\"val\":[\"C2-金色\",\"C4-玫瑰金\",\"C3-银色\",\"C6-黑金\"]}]', 'C4-玫瑰金', 0, '398.00', '171211000078', 'timesqkJB100057C4'),
(2627, 249, '[{\"attr\":\"颜色\",\"val\":[\"C2-金色\",\"C4-玫瑰金\",\"C3-银色\",\"C6-黑金\"]}]', 'C3-银色', 0, '398.00', '171211000077', 'timesqkJB100057C3'),
(2628, 249, '[{\"attr\":\"颜色\",\"val\":[\"C2-金色\",\"C4-玫瑰金\",\"C3-银色\",\"C6-黑金\"]}]', 'C6-黑金', 0, '398.00', '171211000079', 'timesqkJB100057C6'),
(2629, 248, '[{\"attr\":\"颜色\",\"val\":[\"C5-银黑\",\"C4-玫瑰金\",\"C3-银色\"]}]', 'C5-银黑', 0, '398.00', '171211000075', 'timesqkJB100041C5'),
(2630, 248, '[{\"attr\":\"颜色\",\"val\":[\"C5-银黑\",\"C4-玫瑰金\",\"C3-银色\"]}]', 'C4-玫瑰金', 0, '398.00', '171211000074', 'timesqkJB100041C4'),
(2631, 248, '[{\"attr\":\"颜色\",\"val\":[\"C5-银黑\",\"C4-玫瑰金\",\"C3-银色\"]}]', 'C3-银色', 0, '398.00', '171211000073', 'timesqkJB100041C3'),
(2632, 247, '[{\"attr\":\"颜色\",\"val\":[\"C3-银色\"]}]', 'C3-银色', 0, '398.00', '171211000072', 'timesqkJB100040C3'),
(2633, 246, '[{\"attr\":\"颜色\",\"val\":[\"C3-银色\"]}]', 'C3-银色', 0, '398.00', '171211000071', 'timesqkJB100037C3'),
(2634, 245, '[{\"attr\":\"颜色\",\"val\":[\"C5-银色\"]}]', 'C5-银色', 0, '398.00', '171211000070', 'timesqkJB100028C5'),
(2636, 244, '[{\"attr\":\"颜色\",\"val\":[\"C4-玫瑰金\"]}]', 'C4-玫瑰金', 0, '398.00', '171211000069', 'timesqkJB100023C4'),
(2637, 243, '[{\"attr\":\"颜色\",\"val\":[\"C52-灰色\",\"C26-黑色\",\"C69-粉色\",\"C36-淡紫色\",\"C70-深紫色\"]}]', 'C52-灰色', 0, '398.00', '171211000093', 'timesqkJBS10017C52'),
(2638, 243, '[{\"attr\":\"颜色\",\"val\":[\"C52-灰色\",\"C26-黑色\",\"C69-粉色\",\"C36-淡紫色\",\"C70-深紫色\"]}]', 'C26-黑色', 0, '398.00', '171211000091', 'timesqkJBS10017C26'),
(2639, 243, '[{\"attr\":\"颜色\",\"val\":[\"C52-灰色\",\"C26-黑色\",\"C69-粉色\",\"C36-淡紫色\",\"C70-深紫色\"]}]', 'C69-粉色', 0, '398.00', '171211000094', 'timesqkJBS10017C69'),
(2640, 243, '[{\"attr\":\"颜色\",\"val\":[\"C52-灰色\",\"C26-黑色\",\"C69-粉色\",\"C36-淡紫色\",\"C70-深紫色\"]}]', 'C36-淡紫色', 0, '398.00', '171211000092', 'timesqkJBS10017C36'),
(2641, 243, '[{\"attr\":\"颜色\",\"val\":[\"C52-灰色\",\"C26-黑色\",\"C69-粉色\",\"C36-淡紫色\",\"C70-深紫色\"]}]', 'C70-深紫色', 0, '398.00', '171211000095', 'timesqkJBS10017C70'),
(2642, 242, '[{\"attr\":\"颜色\",\"val\":[\"C15-黑金色\",\"C2-黑银色\"]}]', 'C15-黑金色', 0, '398.00', '171211000089', 'timesqkJBD6111C15'),
(2643, 242, '[{\"attr\":\"颜色\",\"val\":[\"C15-黑金色\",\"C2-黑银色\"]}]', 'C2-黑银色', 0, '398.00', '171211000090', 'timesqkJBD6111C2'),
(2644, 241, '[{\"attr\":\"颜色\",\"val\":[\"C15-黑金色\"]}]', 'C15-黑金色', 0, '398.00', '171211000088', 'timesqkJBD6102C15'),
(2645, 240, '[{\"attr\":\"颜色\",\"val\":[\"C2-银色\",\"C11-黑色\"]}]', 'C2-银色', 0, '398.00', '171211000097', 'timesbkJB1560C2'),
(2646, 240, '[{\"attr\":\"颜色\",\"val\":[\"C2-银色\",\"C11-黑色\"]}]', 'C11-黑色', 0, '398.00', '171211000096', 'timesbkJB1560C11'),
(2647, 239, '[{\"attr\":\"颜色\",\"val\":[\"C14-黑金色\",\"C2-银色\",\"C11-黑银色\",\"C7-钢琴黑\"]}]', 'C14-黑金色', 0, '398.00', '171211000081', 'timesqkJB1522C14'),
(2648, 239, '[{\"attr\":\"颜色\",\"val\":[\"C14-黑金色\",\"C2-银色\",\"C11-黑银色\",\"C7-钢琴黑\"]}]', 'C2-银色', 0, '398.00', '171211000082', 'timesqkJB1522C2'),
(2649, 239, '[{\"attr\":\"颜色\",\"val\":[\"C14-黑金色\",\"C2-银色\",\"C11-黑银色\",\"C7-钢琴黑\"]}]', 'C11-黑银色', 0, '398.00', '171211000080', 'timesqkJB1522C11'),
(2650, 239, '[{\"attr\":\"颜色\",\"val\":[\"C14-黑金色\",\"C2-银色\",\"C11-黑银色\",\"C7-钢琴黑\"]}]', 'C7-钢琴黑', 0, '398.00', '171211000083', 'timesqkJB1522C7'),
(2651, 237, '[{\"attr\":\"颜色\",\"val\":[\"C0L.2-银色\"]}]', 'C0L.2-银色', 0, '198.00', '170315000004', 'timesqk9211c2'),
(2654, 236, '[{\"attr\":\"颜色\",\"val\":[\"C17-黑框金腿\",\"A01-金框\"]}]', 'C17-黑框金腿', 0, '198.00', '', ''),
(2655, 236, '[{\"attr\":\"颜色\",\"val\":[\"C17-黑框金腿\",\"A01-金框\"]}]', 'A01-金框', 0, '198.00', '', ''),
(2656, 235, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C17-黑框金腿\",\"C32 银框\"]}]', 'C1-黑色', 0, '198.00', '170315000064', 'timesqk115c1'),
(2657, 235, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C17-黑框金腿\",\"C32 银框\"]}]', 'C17-黑框金腿', 0, '198.00', '', ''),
(2658, 235, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C17-黑框金腿\",\"C32 银框\"]}]', 'C32 银框', 0, '198.00', '', ''),
(2659, 234, '[{\"attr\":\"颜色\",\"val\":[\"S52-茶色\"]}]', 'S52-茶色', 0, '180.00', '170421000054', 'timesjsS925-2S52'),
(2660, 233, '[{\"attr\":\"颜色\",\"val\":[\"C1-透明黄\",\"C21-透明蓝\",\"C4-透明粉\"]}]', 'C1-透明黄', 0, '180.00', '170421000033', 'timesjsS30079c1'),
(2661, 233, '[{\"attr\":\"颜色\",\"val\":[\"C1-透明黄\",\"C21-透明蓝\",\"C4-透明粉\"]}]', 'C21-透明蓝', 0, '180.00', '170421000034', 'timesjsS30079c21'),
(2662, 233, '[{\"attr\":\"颜色\",\"val\":[\"C1-透明黄\",\"C21-透明蓝\",\"C4-透明粉\"]}]', 'C4-透明粉', 0, '180.00', '170421000036', 'timesjsS30079c4'),
(2663, 232, '[{\"attr\":\"颜色\",\"val\":[\"C8-贝壳粉\",\"C6-灰色\"]}]', 'C8-贝壳粉', 0, '180.00', '170418000013', 'timesbcS30065c8'),
(2664, 232, '[{\"attr\":\"颜色\",\"val\":[\"C8-贝壳粉\",\"C6-灰色\"]}]', 'C6-灰色', 0, '180.00', '170417000026', 'timesbcS30065c6'),
(2665, 231, '[{\"attr\":\"颜色\",\"val\":[\"C66-绿色\",\"C101-淡紫色\"]}]', 'C66-绿色', 0, '180.00', '170420000054', 'timesjsS30048c66'),
(2666, 231, '[{\"attr\":\"颜色\",\"val\":[\"C66-绿色\",\"C101-淡紫色\"]}]', 'C101-淡紫色', 0, '180.00', '170420000055', 'timesjsS30048c101'),
(2667, 230, '[{\"attr\":\"颜色\",\"val\":[\"C30-经典黑\",\"C48-豹纹\"]}]', 'C30-经典黑', 0, '180.00', '170417000017', 'timesbcS30044c30'),
(2668, 230, '[{\"attr\":\"颜色\",\"val\":[\"C30-经典黑\",\"C48-豹纹\"]}]', 'C48-豹纹', 0, '180.00', '170417000018', 'timesbcS30044c48'),
(2669, 229, '[{\"attr\":\"颜色\",\"val\":[\"C52-茶色\",\"C126-婴儿粉\"]}]', 'C52-茶色', 0, '180.00', '170421000065', 'timesjsS30043c52'),
(2670, 229, '[{\"attr\":\"颜色\",\"val\":[\"C52-茶色\",\"C126-婴儿粉\"]}]', 'C126-婴儿粉', 0, '180.00', '170420000049', 'timesjsS30043c126'),
(2671, 228, '[{\"attr\":\"颜色\",\"val\":[\"C52-沙棕色\",\"C8-灰色\",\"C66-绿色\"]}]', 'C52-沙棕色', 0, '180.00', '170421000038', 'timesjsS30039c52'),
(2672, 228, '[{\"attr\":\"颜色\",\"val\":[\"C52-沙棕色\",\"C8-灰色\",\"C66-绿色\"]}]', 'C8-灰色', 0, '180.00', '170421000040', 'timesjsS30039c8'),
(2673, 228, '[{\"attr\":\"颜色\",\"val\":[\"C52-沙棕色\",\"C8-灰色\",\"C66-绿色\"]}]', 'C66-绿色', 0, '180.00', '170421000039', 'timesjsS30039c66'),
(2674, 227, '[{\"attr\":\"颜色\",\"val\":[\"C126 -婴儿粉\"]}]', 'C126 -婴儿粉', 0, '180.00', '170418000004', 'timesjsS30013c126'),
(2675, 226, '[{\"attr\":\"颜色\",\"val\":[\"C8-银色\",\"C58-水蓝色\"]}]', 'C8-银色', 0, '180.00', '170421000011', 'timesjsS1999c8'),
(2676, 226, '[{\"attr\":\"颜色\",\"val\":[\"C8-银色\",\"C58-水蓝色\"]}]', 'C58-水蓝色', 0, '180.00', '170421000010', 'timesjsS1999c58'),
(2677, 225, '[{\"attr\":\"颜色\",\"val\":[\"C126-粉色\",\"C61-经典黑\"]}]', 'C126-粉色', 0, '180.00', '170418000007', 'timesjsS1996c126'),
(2678, 225, '[{\"attr\":\"颜色\",\"val\":[\"C126-粉色\",\"C61-经典黑\"]}]', 'C61-经典黑', 0, '180.00', '170418000002', 'timesjsS1996c61'),
(2679, 224, '[{\"attr\":\"颜色\",\"val\":[\"C66-绿色\",\"C126-玫瑰粉\",\"C58-蔚蓝\"]}]', 'C66-绿色', 0, '180.00', '170417000031', 'timesjsS1995c66'),
(2680, 224, '[{\"attr\":\"颜色\",\"val\":[\"C66-绿色\",\"C126-玫瑰粉\",\"C58-蔚蓝\"]}]', 'C126-玫瑰粉', 0, '180.00', '170420000043', 'timesjsS1995c126'),
(2681, 224, '[{\"attr\":\"颜色\",\"val\":[\"C66-绿色\",\"C126-玫瑰粉\",\"C58-蔚蓝\"]}]', 'C58-蔚蓝', 0, '180.00', '170417000030', 'timesjsS1995c58'),
(2682, 223, '[{\"attr\":\"颜色\",\"val\":[\"C36-暗粉色\",\"C58-水蓝色\",\"C52-经典黑\"]}]', 'C36-暗粉色', 0, '180.00', '170421000005', 'timesjsS1993c36'),
(2683, 223, '[{\"attr\":\"颜色\",\"val\":[\"C36-暗粉色\",\"C58-水蓝色\",\"C52-经典黑\"]}]', 'C58-水蓝色', 0, '180.00', '170421000006', 'timesjsS1993c58'),
(2684, 223, '[{\"attr\":\"颜色\",\"val\":[\"C36-暗粉色\",\"C58-水蓝色\",\"C52-经典黑\"]}]', 'C52-经典黑', 0, '180.00', '170421000041', 'timesjsS1993C52'),
(2685, 222, '[{\"attr\":\"颜色\",\"val\":[\"C58-冰蓝色\",\"C8-银灰色\",\"C125-橘红色\"]}]', 'C58-冰蓝色', 0, '180.00', '170421000052', 'timesjsS1987C58'),
(2686, 222, '[{\"attr\":\"颜色\",\"val\":[\"C58-冰蓝色\",\"C8-银灰色\",\"C125-橘红色\"]}]', 'C8-银灰色', 0, '180.00', '170421000053', 'timesjsS1987C8'),
(2687, 222, '[{\"attr\":\"颜色\",\"val\":[\"C58-冰蓝色\",\"C8-银灰色\",\"C125-橘红色\"]}]', 'C125-橘红色', 0, '180.00', '170420000006', 'timesjsS1987c125'),
(2688, 221, '[{\"attr\":\"颜色\",\"val\":[\"C8-银灰色\",\"C67-华贵紫\",\"C58-冰蓝色\",\"C126-粉色\"]}]', 'C8-银灰色', 0, '180.00', '170421000018', 'timesjsS1980c8'),
(2689, 221, '[{\"attr\":\"颜色\",\"val\":[\"C8-银灰色\",\"C67-华贵紫\",\"C58-冰蓝色\",\"C126-粉色\"]}]', 'C67-华贵紫', 0, '180.00', '170421000017', 'timesjsS1980c67'),
(2690, 221, '[{\"attr\":\"颜色\",\"val\":[\"C8-银灰色\",\"C67-华贵紫\",\"C58-冰蓝色\",\"C126-粉色\"]}]', 'C58-冰蓝色', 0, '180.00', '170421000016', 'timesjsS1980c58'),
(2691, 221, '[{\"attr\":\"颜色\",\"val\":[\"C8-银灰色\",\"C67-华贵紫\",\"C58-冰蓝色\",\"C126-粉色\"]}]', 'C126-粉色', 0, '180.00', '170421000015', 'timesjsS1980c126'),
(2692, 220, '[{\"attr\":\"颜色\",\"val\":[\"C30-黑色\",\"C52-茶色\",\"C67-暗紫色\"]}]', 'C30-黑色', 0, '180.00', '170421000047', 'timesjsS1967C30'),
(2693, 220, '[{\"attr\":\"颜色\",\"val\":[\"C30-黑色\",\"C52-茶色\",\"C67-暗紫色\"]}]', 'C52-茶色', 0, '180.00', '170421000048', 'timesjsS1967C52'),
(2694, 220, '[{\"attr\":\"颜色\",\"val\":[\"C30-黑色\",\"C52-茶色\",\"C67-暗紫色\"]}]', 'C67-暗紫色', 0, '180.00', '170420000061', 'timesjsS1967c67'),
(2695, 219, '[{\"attr\":\"颜色\",\"val\":[\"C1-茶色\"]}]', 'C1-茶色', 0, '180.00', '', ''),
(2696, 218, '[{\"attr\":\"颜色\",\"val\":[\"C1-银灰色\"]}]', 'C1-银灰色', 0, '180.00', '170418000017', 'timesbc17068c1'),
(2697, 217, '[{\"attr\":\"颜色\",\"val\":[\"C126-婴儿粉\",\"C66-青绿色\"]}]', 'C126-婴儿粉', 0, '180.00', '170418000062', 'timesjs925KHc126'),
(2698, 217, '[{\"attr\":\"颜色\",\"val\":[\"C126-婴儿粉\",\"C66-青绿色\"]}]', 'C66-青绿色', 0, '180.00', '170421000051', 'timesjs925KHC66'),
(2699, 216, '[{\"attr\":\"颜色\",\"val\":[\"C1-经典黑\",\"C2-银灰色\",\"C3-冰蓝色\"]}]', 'C1-经典黑', 0, '338.00', '170321000006', 'timesjs7005C1'),
(2700, 216, '[{\"attr\":\"颜色\",\"val\":[\"C1-经典黑\",\"C2-银灰色\",\"C3-冰蓝色\"]}]', 'C2-银灰色', 0, '338.00', '170321000007', 'timesjs7005C2'),
(2701, 216, '[{\"attr\":\"颜色\",\"val\":[\"C1-经典黑\",\"C2-银灰色\",\"C3-冰蓝色\"]}]', 'C3-冰蓝色', 0, '338.00', '170321000008', 'timesjs7005C3'),
(2702, 215, '[{\"attr\":\"颜色\",\"val\":[\"C2-银灰色\",\"C9-钴蓝色\"]}]', 'C2-银灰色', 0, '180.00', '170418000074', 'timesjs3026c2'),
(2703, 215, '[{\"attr\":\"颜色\",\"val\":[\"C2-银灰色\",\"C9-钴蓝色\"]}]', 'C9-钴蓝色', 0, '180.00', '170418000075', 'timesjs3026c9'),
(2704, 214, '[{\"attr\":\"颜色\",\"val\":[\"C52-华贵紫\",\"C1-经典黑\"]}]', 'C52-华贵紫', 0, '180.00', '', ''),
(2705, 214, '[{\"attr\":\"颜色\",\"val\":[\"C52-华贵紫\",\"C1-经典黑\"]}]', 'C1-经典黑', 0, '180.00', '170418000025', 'timesjs17137c1'),
(2706, 213, '[{\"attr\":\"颜色\",\"val\":[\"C3-钴蓝色 \",\"C1-灰色\"]}]', 'C3-钴蓝色 ', 0, '180.00', '', ''),
(2707, 213, '[{\"attr\":\"颜色\",\"val\":[\"C3-钴蓝色 \",\"C1-灰色\"]}]', 'C1-灰色', 0, '180.00', '170418000021', 'timesjs10606c1'),
(2708, 212, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C2-银灰色\"]}]', 'C1-黑色', 0, '298.00', '170321000001', 'timesbc6098C1'),
(2709, 212, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\",\"C2-银灰色\"]}]', 'C2-银灰色', 0, '298.00', '170321000002', 'timesbc6098C2'),
(2710, 207, '[{\"attr\":\"颜色\",\"val\":[\"C1-黑色\"]}]', 'C1-黑色', 0, '180.00', '', ''),
(2711, 82, '[{\"attr\":\"颜色\",\"val\":[\"C13-琥铂色框灰色镜片\"]}]', 'C13-琥铂色框灰色镜片', 0, '228.00', '161213000032', 'timesbc80085c13'),
(2712, 81, '[{\"attr\":\"颜色\",\"val\":[\"C14-红棕色\"]}]', 'C14-红棕色', 0, '228.00', '161213000028', 'timesbc80084c14'),
(2713, 80, '[{\"attr\":\"颜色\",\"val\":[\"绿色\"]}]', '绿色', 0, '0.00', '', ''),
(2714, 79, '[{\"attr\":\"颜色\",\"val\":[\"黑色\"]}]', '黑色', 8, '228.00', '161213000012', 'timesbc14049c11'),
(2715, 78, '[{\"attr\":\"颜色\",\"val\":[\"粉色\"]}]', '粉色', 7, '298.00', '', ''),
(2721, 205, '[{\"attr\":\"颜色\",\"val\":[\"资格\"]}]', '资格', 9984, '0.10', '1111', '888888');

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '各类（1.现金券；2.满减）',
  `facevalue` int(11) NOT NULL COMMENT '面额',
  `starttime` int(11) NOT NULL COMMENT '开始日期',
  `endtime` int(11) NOT NULL COMMENT '结束日期',
  `condition` int(11) NOT NULL DEFAULT '0' COMMENT '条件（如果为现金券，值为0）',
  `num` int(11) NOT NULL COMMENT '数量',
  `coupon_path` varchar(255) NOT NULL COMMENT '图片路径',
  `addtime` int(11) NOT NULL COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券表';

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`id`, `type`, `facevalue`, `starttime`, `endtime`, `condition`, `num`, `coupon_path`, `addtime`) VALUES
(14, 1, 100, 1493136000, 1493395199, 0, 1, '/Uploads/coupon/201704268727cd.png', 1493192280),
(15, 1, 50, 1493136000, 1493395199, 0, 50, '/Uploads/coupon/201704260d89a3.png', 1493194720),
(16, 1, 51, 1493222400, 1493481599, 0, 2, '/Uploads/coupon/20170427addce9.png', 1493272522),
(17, 2, 20, 1495036800, 1496332799, 699, 5, '/Uploads/coupon/20170518f7e0a5.png', 1495093679),
(29, 1, 1, 1499875200, 1500047999, 0, 3, '/Uploads/coupon/20170713ea0372.png', 1499909646),
(30, 1, 1, 1499875200, 1500047999, 0, 2, '/Uploads/coupon/20170713147273.png', 1499915169);

-- --------------------------------------------------------

--
-- Table structure for table `custom_page`
--

CREATE TABLE `custom_page` (
  `id` int(11) NOT NULL,
  `json` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='自定义页面';

--
-- Dumping data for table `custom_page`
--

INSERT INTO `custom_page` (`id`, `json`) VALUES
(1, '[[{\"thumbnail\":\"\",\"title\":\"\\u7533\\u8bf7\\u57ce\\u5e02\\u4ee3\\u7406\\u4eba\\u8d44\\u683c\",\"current\":\"0.10\",\"original\":\"0.10\",\"commodityid\":\"205\"},{\"thumbnail\":\"\\/Uploads\\/2018-01-02\\/5a4b01898c3f4.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100057\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"249\"},{\"thumbnail\":\"\\/Uploads\\/2018-01-02\\/5a4affacab66b.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100041\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"248\"},{\"thumbnail\":\"\\/Uploads\\/2018-01-02\\/5a4afee8487dc.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100040\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"247\"},{\"thumbnail\":\"\\/Uploads\\/2018-01-02\\/5a4afe21b935d.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100037\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"246\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a4600038c358.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100028\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"245\"}],[{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45fd77a3df5.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b6100023\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"244\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45f6d7ac374.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b610017\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"243\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45f424f0399.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b66111\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"242\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45eeb8bb115.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b66102\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"241\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45d96f96d17.jpg\",\"title\":\"TIMES\\u5149\\u5b66\\u955c\\u67b61560\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"240\"},{\"thumbnail\":\"\\/Uploads\\/2017-12-29\\/5a45bae9993d7.jpg\",\"title\":\"TIMES2017\\u65b0\\u6b3e\\u5149\\u5b66\\u955c1522\",\"current\":\"398.00\",\"original\":\"398.00\",\"commodityid\":\"239\"}],[{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8c22d62365.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS925-2\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"234\"},{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8c095d8f34.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS30079\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"233\"},{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8bfa1ec82a.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS30065\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"232\"},{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8b4e963767.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS30048\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"231\"},{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8b2454c351.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS30043\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"229\"},{\"thumbnail\":\"\\/Uploads\\/2017-09-25\\/59c8b11edc63b.jpg\",\"title\":\"TIMES\\u592a\\u9633\\u955cS30039\",\"current\":\"180.00\",\"original\":\"180.00\",\"commodityid\":\"228\"}]]');

-- --------------------------------------------------------

--
-- Table structure for table `dividedinto`
--

CREATE TABLE `dividedinto` (
  `intoid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `fromuid` int(11) NOT NULL COMMENT '来源uid',
  `orderid` varchar(50) NOT NULL COMMENT '订单ID',
  `level` tinyint(2) NOT NULL DEFAULT '1' COMMENT '等级1、2、3',
  `money` decimal(10,2) NOT NULL COMMENT '分成金额',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1未处理2已付款',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分成记录表';

--
-- Dumping data for table `dividedinto`
--

INSERT INTO `dividedinto` (`intoid`, `shopid`, `uid`, `fromuid`, `orderid`, `level`, `money`, `status`, `time`) VALUES
(1, 1, 469, 12, '126', 1, '0.02', 1, '2018-01-25 07:32:25'),
(2, 1, 467, 797, '129', 1, '0.02', 1, '2018-01-26 07:54:07'),
(3, 1, 15, 798, '131', 1, '0.02', 1, '2018-01-26 08:22:26'),
(4, 1, 798, 799, '133', 1, '0.02', 1, '2018-01-26 09:04:39'),
(5, 1, 15, 799, '133', 2, '0.01', 1, '2018-01-26 09:04:39');

-- --------------------------------------------------------

--
-- Table structure for table `dividedinto_history`
--

CREATE TABLE `dividedinto_history` (
  `id` int(11) NOT NULL,
  `uid` varchar(40) NOT NULL COMMENT '用户ID',
  `adminid` int(11) NOT NULL COMMENT '操作人ID',
  `money` decimal(10,2) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分成记录表';

-- --------------------------------------------------------

--
-- Table structure for table `express`
--

CREATE TABLE `express` (
  `express_name` varchar(45) NOT NULL COMMENT '快递名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `express`
--

INSERT INTO `express` (`express_name`) VALUES
('圆通快递'),
('中通速递');

-- --------------------------------------------------------

--
-- Table structure for table `integral`
--

CREATE TABLE `integral` (
  `integralid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `snopid` int(11) NOT NULL,
  `integral` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `integral`
--

INSERT INTO `integral` (`integralid`, `shopid`, `uid`, `snopid`, `integral`, `time`) VALUES
(1, 1, 2, 3, '1198', '2017-03-16 06:59:05'),
(2, 1, 2, 7, '1198', '2017-03-16 07:02:22'),
(3, 1, 9, 9, '10', '2017-03-16 07:09:02'),
(4, 1, 12, 10, '1198', '2017-03-16 07:42:21'),
(5, 1, 1, 11, '1174', '2017-03-16 07:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `logid` bigint(20) NOT NULL,
  `shopid` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '管理员ID',
  `content` varchar(100) NOT NULL COMMENT '操作事件',
  `ip` varchar(30) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志表';

-- --------------------------------------------------------

--
-- Table structure for table `log_event`
--

CREATE TABLE `log_event` (
  `eventid` int(11) NOT NULL,
  `content` varchar(100) NOT NULL COMMENT '名称',
  `action` varchar(40) NOT NULL COMMENT '控制器方法'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `love`
--

CREATE TABLE `love` (
  `loveid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `commodityid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menuid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `level` tinyint(1) NOT NULL,
  `name` varchar(45) NOT NULL,
  `sort` int(5) NOT NULL,
  `value` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `orderid` int(11) NOT NULL,
  `uniqueid` varchar(32) NOT NULL COMMENT '唯一订单号',
  `type` tinyint(2) NOT NULL DEFAULT '1',
  `shopid` int(11) NOT NULL COMMENT '所属店铺',
  `uid` int(11) NOT NULL COMMENT '所属用户',
  `addressid` int(11) NOT NULL,
  `discount` decimal(6,0) NOT NULL,
  `money` decimal(10,2) NOT NULL COMMENT '订单总价',
  `carriage` decimal(6,2) NOT NULL COMMENT '运费',
  `beizhu` varchar(255) NOT NULL COMMENT '备注',
  `transaction` varchar(50) NOT NULL COMMENT '第三方订单号',
  `commercial` varchar(50) NOT NULL COMMENT '商户订单号',
  `evaluation_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评价状态 0未评价，1已评价，2已过期未评价',
  `order_state` tinyint(4) NOT NULL DEFAULT '10' COMMENT '订单状态：0(已取消)10(默认):待付款;20:待发货;30:待收货;;50：完成；60：退款中；70：退款完成',
  `refund_state` tinyint(3) NOT NULL DEFAULT '0' COMMENT '退款状态:0是无退款,1是退款申请中,2是退款完成',
  `return_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0为未退货，1为退货，2为退货完成',
  `refund_amount` decimal(10,2) NOT NULL COMMENT '退款金额',
  `is_fencheng` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1未分成2已分成',
  `pay_time` datetime NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endtime` datetime NOT NULL COMMENT '收货时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_commodity_snop`
--

CREATE TABLE `order_commodity_snop` (
  `snopid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `snopjson` text NOT NULL,
  `money` decimal(8,2) NOT NULL COMMENT '购买价格',
  `nums` tinyint(8) NOT NULL COMMENT '购买数量',
  `attr` varchar(80) NOT NULL COMMENT '购买规格',
  `is_refunds` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未退货1退货申请中，等待审核2同意，用户物流信息3拒绝4等待卖家收货5退货完成',
  `skuid` varchar(40) NOT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT '分享的标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_extend`
--

CREATE TABLE `order_extend` (
  `extendid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL COMMENT '所属订单ID',
  `express` varchar(45) NOT NULL COMMENT '快递公司',
  `couriernumber` varchar(45) NOT NULL COMMENT '物流单号',
  `addjson` text NOT NULL COMMENT '收货地址Json',
  `settime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_refunds`
--

CREATE TABLE `order_refunds` (
  `refundsid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1申请中2同意3拒绝',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款申请表';

-- --------------------------------------------------------

--
-- Table structure for table `order_return_goods`
--

CREATE TABLE `order_return_goods` (
  `returnid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL COMMENT '店铺ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `snopid` int(11) NOT NULL COMMENT '商品ID',
  `orderid` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `content` varchar(500) NOT NULL COMMENT '退货说明',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1申请中，等待审核2同意，用户物流信息3拒绝4等待卖家收货5退货完成',
  `express` varchar(20) NOT NULL COMMENT '物流公司',
  `logistics` varchar(40) NOT NULL COMMENT '物流单号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退货申请表';

-- --------------------------------------------------------

--
-- Table structure for table `province`
--

CREATE TABLE `province` (
  `provinceid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省';

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `shopid` int(11) NOT NULL COMMENT '店铺ID',
  `account` varchar(45) NOT NULL COMMENT '帐号',
  `password` varchar(45) NOT NULL COMMENT '密码',
  `role` int(3) NOT NULL COMMENT '角色组',
  `regtime` datetime NOT NULL COMMENT '店铺入驻时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`shopid`, `account`, `password`, `role`, `regtime`) VALUES
(1, 'haomaoguai', 'e10adc3949ba59abbe56e057f20f883e', 0, '2016-07-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `specifications`
--

CREATE TABLE `specifications` (
  `specificationsid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `specifications`
--

INSERT INTO `specifications` (`specificationsid`, `shopid`, `name`) VALUES
(2, 1, '颜色'),
(5, 1, '尺寸'),
(6, 1, '重量  (购买单品或组合满4斤包邮）'),
(7, 1, '份数'),
(10, 1, '等级'),
(11, 1, '包邮入口'),
(12, 1, '品名  (购买单品或组合满4斤包邮）');

-- --------------------------------------------------------

--
-- Table structure for table `suggest`
--

CREATE TABLE `suggest` (
  `suggestid` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `content` text NOT NULL COMMENT '内容',
  `phone` varchar(15) NOT NULL COMMENT '电话',
  `weixin` varchar(50) NOT NULL COMMENT '微信号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='建议表';

--
-- Dumping data for table `suggest`
--

INSERT INTO `suggest` (`suggestid`, `uid`, `content`, `phone`, `weixin`, `time`) VALUES
(1, 975, '我留个言看看', '18888888888', '18888888888', '2018-04-27 00:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `shopid` int(11) DEFAULT '0' COMMENT '所属店铺ID',
  `chatid` varchar(40) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `nickname` varchar(45) DEFAULT '' COMMENT '微信名称',
  `c_phone` varchar(15) CHARACTER SET utf8mb4 NOT NULL COMMENT '绑定手机',
  `integral` int(11) UNSIGNED DEFAULT '0' COMMENT '积分',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '推广总收益',
  `img` varchar(255) DEFAULT '' COMMENT '用户头像',
  `member` tinyint(5) NOT NULL COMMENT '0不是1银2金3至尊4消费次数超过1次',
  `isbuy` tinyint(2) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0未购买，1购买',
  `isfix` tinyint(2) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0未确定1确定',
  `type` tinyint(2) UNSIGNED DEFAULT '0' COMMENT '0为普通人1为推广员',
  `first` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '一级推荐人ID',
  `second` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '二级推荐人',
  `three` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '三级推荐人',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1正常，2删除',
  `is_get` mediumint(5) NOT NULL COMMENT '是否已领取会员卡 0:未领取 1:已领取',
  `regtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_optometry`
--

CREATE TABLE `user_optometry` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `c_code` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '验光单号',
  `c_clientcode` char(18) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '顾客卡号',
  `c_lball` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左球面度数',
  `c_rball` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右球面度数',
  `c_lpole` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左柱面度数',
  `c_rpole` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右柱面度数',
  `c_laxes` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左轴向',
  `c_raxes` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右轴向',
  `c_lspace` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左近瞳距',
  `c_lspace2` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左远瞳距',
  `c_rspace` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右近瞳距',
  `c_rspace2` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右远瞳距',
  `c_lhspace` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左瞳高',
  `c_rhspace` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右瞳高',
  `c_lcheck` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左矫正视力',
  `c_rcheck` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右矫正视力',
  `c_lsign` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左裸视力',
  `c_rsign` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右裸视力',
  `c_ladd` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左add',
  `c_radd` varchar(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右add',
  `c_llight` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左原光',
  `c_rlight` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右原光',
  `c_lfoot` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左全矫光度',
  `c_rfoot` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右全矫光度',
  `c_lcurvature` varchar(5) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '左曲率',
  `c_rcurvature` varchar(5) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '右曲率',
  `c_date` text COMMENT '验光日期',
  `c_empcode` char(6) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '验光师工号',
  `c_empname` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '验光师姓名',
  `c_space2` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '远瞳距'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `weixin_config`
--

CREATE TABLE `weixin_config` (
  `shopid` int(11) NOT NULL,
  `name` varchar(40) NOT NULL COMMENT '名称,比如:appid',
  `value` varchar(45) NOT NULL COMMENT '配置值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`addressid`),
  ADD KEY `uid_idx` (`uid`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_group`
--
ALTER TABLE `admin_group`
  ADD PRIMARY KEY (`gid`);

--
-- Indexes for table `admin_rule`
--
ALTER TABLE `admin_rule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_rule_cat`
--
ALTER TABLE `admin_rule_cat`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`articleid`);

--
-- Indexes for table `carousel`
--
ALTER TABLE `carousel`
  ADD PRIMARY KEY (`carouselid`);

--
-- Indexes for table `carousel_extend`
--
ALTER TABLE `carousel_extend`
  ADD PRIMARY KEY (`extendid`);

--
-- Indexes for table `carriage`
--
ALTER TABLE `carriage`
  ADD PRIMARY KEY (`carriageid`);

--
-- Indexes for table `carriage_extend`
--
ALTER TABLE `carriage_extend`
  ADD PRIMARY KEY (`carriage_extendid`),
  ADD KEY `carriageid_idx` (`carriageid`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartid`);

--
-- Indexes for table `cdkey`
--
ALTER TABLE `cdkey`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chatlog`
--
ALTER TABLE `chatlog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classify`
--
ALTER TABLE `classify`
  ADD PRIMARY KEY (`classifyid`);

--
-- Indexes for table `commodity`
--
ALTER TABLE `commodity`
  ADD PRIMARY KEY (`commodityid`),
  ADD UNIQUE KEY `huohao` (`huohao`);

--
-- Indexes for table `commodity_comment`
--
ALTER TABLE `commodity_comment`
  ADD PRIMARY KEY (`commodity_commentid`);

--
-- Indexes for table `commodity_sku`
--
ALTER TABLE `commodity_sku`
  ADD PRIMARY KEY (`commodity_skuid`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_page`
--
ALTER TABLE `custom_page`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dividedinto`
--
ALTER TABLE `dividedinto`
  ADD PRIMARY KEY (`intoid`);

--
-- Indexes for table `dividedinto_history`
--
ALTER TABLE `dividedinto_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `integral`
--
ALTER TABLE `integral`
  ADD PRIMARY KEY (`integralid`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`logid`);

--
-- Indexes for table `log_event`
--
ALTER TABLE `log_event`
  ADD PRIMARY KEY (`eventid`);

--
-- Indexes for table `love`
--
ALTER TABLE `love`
  ADD PRIMARY KEY (`loveid`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menuid`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`orderid`),
  ADD UNIQUE KEY `uniqueid` (`uniqueid`),
  ADD KEY `order_state` (`order_state`),
  ADD KEY `uniqueid_2` (`uniqueid`);

--
-- Indexes for table `order_commodity_snop`
--
ALTER TABLE `order_commodity_snop`
  ADD PRIMARY KEY (`snopid`),
  ADD KEY `orderid_idx` (`orderid`);

--
-- Indexes for table `order_extend`
--
ALTER TABLE `order_extend`
  ADD PRIMARY KEY (`extendid`);

--
-- Indexes for table `order_refunds`
--
ALTER TABLE `order_refunds`
  ADD PRIMARY KEY (`refundsid`);

--
-- Indexes for table `order_return_goods`
--
ALTER TABLE `order_return_goods`
  ADD PRIMARY KEY (`returnid`),
  ADD UNIQUE KEY `snopid` (`snopid`);

--
-- Indexes for table `province`
--
ALTER TABLE `province`
  ADD PRIMARY KEY (`provinceid`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`shopid`);

--
-- Indexes for table `specifications`
--
ALTER TABLE `specifications`
  ADD PRIMARY KEY (`specificationsid`),
  ADD KEY `shopid_idx` (`shopid`);

--
-- Indexes for table `suggest`
--
ALTER TABLE `suggest`
  ADD PRIMARY KEY (`suggestid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `openid` (`openid`);

--
-- Indexes for table `user_optometry`
--
ALTER TABLE `user_optometry`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `addressid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `admin_group`
--
ALTER TABLE `admin_group`
  MODIFY `gid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `admin_rule`
--
ALTER TABLE `admin_rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `admin_rule_cat`
--
ALTER TABLE `admin_rule_cat`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `articleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carousel`
--
ALTER TABLE `carousel`
  MODIFY `carouselid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `carousel_extend`
--
ALTER TABLE `carousel_extend`
  MODIFY `extendid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carriage`
--
ALTER TABLE `carriage`
  MODIFY `carriageid` int(11) NOT NULL AUTO_INCREMENT COMMENT '运费表ID', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `carriage_extend`
--
ALTER TABLE `carriage_extend`
  MODIFY `carriage_extendid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=322;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cdkey`
--
ALTER TABLE `cdkey`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chatlog`
--
ALTER TABLE `chatlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classify`
--
ALTER TABLE `classify`
  MODIFY `classifyid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commodity`
--
ALTER TABLE `commodity`
  MODIFY `commodityid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `commodity_comment`
--
ALTER TABLE `commodity_comment`
  MODIFY `commodity_commentid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `commodity_sku`
--
ALTER TABLE `commodity_sku`
  MODIFY `commodity_skuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2722;

--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `custom_page`
--
ALTER TABLE `custom_page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dividedinto`
--
ALTER TABLE `dividedinto`
  MODIFY `intoid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dividedinto_history`
--
ALTER TABLE `dividedinto_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `integral`
--
ALTER TABLE `integral`
  MODIFY `integralid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `logid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_event`
--
ALTER TABLE `log_event`
  MODIFY `eventid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `love`
--
ALTER TABLE `love`
  MODIFY `loveid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_commodity_snop`
--
ALTER TABLE `order_commodity_snop`
  MODIFY `snopid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_extend`
--
ALTER TABLE `order_extend`
  MODIFY `extendid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_refunds`
--
ALTER TABLE `order_refunds`
  MODIFY `refundsid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_return_goods`
--
ALTER TABLE `order_return_goods`
  MODIFY `returnid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `province`
--
ALTER TABLE `province`
  MODIFY `provinceid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `shopid` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺ID', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `specifications`
--
ALTER TABLE `specifications`
  MODIFY `specificationsid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `suggest`
--
ALTER TABLE `suggest`
  MODIFY `suggestid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_optometry`
--
ALTER TABLE `user_optometry`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
