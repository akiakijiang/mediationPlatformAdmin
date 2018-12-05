<?php
namespace Admin\Controller;
use Think\Controller;
class AutoController extends Controller {

    /**
     * 开发者：huangwei
     * 方法功能：自动任务
     */
    public function autodo(){
        $this->pingjia();//自动关闭评价入口
        $this->shouhuo();//自动收货
        $this->close_order();
    }

    /**
     * 开发者：huangwei
     * 方法功能：商家发货后7天自动确认收货
     * 做了修改 ----------------  付款后7天自动确认收货
     */
    public function shouhuo(){
        $Order = D('order');
        $map['order_state'] = "30";
        $map['return_status'] = array('neq',"1");
        $data = $Order->where($map)->relation(true)->select();

        $Order->startTrans();
        foreach ($data as $k => $v){
            if((time() - strtotime($v['pay_time'])) > 7*24*60*60 && $v['pay_time']!="0000-00-00 00:00:00"){
                //开始执行7天自动收货
                $save['order_state'] = 50;
                $save['is_fencheng'] = 2;
                $save['endtime'] = date("Y-m-d H:i:s");
                $Order->where(array('uniqueid'=>$v['uniqueid']))->save($save);

                $snop = M('order_commodity_snop')->where(array('orderid'=>$v['orderid']))->field('snopjson,snopid,money,nums')->select();//获取该订单下商品列表
                $integral = 0;//默认积分0
                $my_notice = D('Home/order_commodity_snop')->cale($v['orderid'],$v['uid']);  //计算有哪些用户需要微信通知的

                foreach ($my_notice as $k1 => $v1){//添加分成记录
                    if($v1['money'] != 0){
                        $add2['shopid'] = $v['shopid'];
                        $add2['uid'] = $v1['id'];
                        $add2['orderid'] = $v['orderid'];
                        $add2['level'] = $k1+1;
                        $add2['fromuid'] = $v['uid'];
                        $add2['money'] = $v1['money'];
                        if(!D('dividedinto')->add($add2)){//增加用户推广金额
                            $Order->rollback();
                            retJson("404","操作失败1");
                        }
                        if(!M('user')->where(array('id'=>$v1['id']))->setInc('money',$v1['money'])){
                            $Order->rollback();
                            retJson("404","操作失败2");
                        }
                    }
                }

                foreach ($snop as $k1 => $v1){
                    $snop[$k1]['snopjson'] = json_decode($v1['snopjson'],true);
                    if($snop[$k1]['snopjson']['type'] != 2){
//                        $integral = $integral + $snop[$k1]['snopjson']['integral']*$v1['money']*$v1['money']*0.01;//计算该订单总积分值
                        $integral = $integral + $snop[$k1]['snopjson']['integral']*$v1['money']*$v1['nums']*0.01;//计算该订单总积分值
                        //判断是否积分商品,非积分商品执行下面的
                        $add['shopid'] = $v['shopid'];
                        $add['uid'] = $v['uid'];
                        $add['snopid'] = $v1['snopid'];
//                        $add['integral'] = round($snop[$k1]['snopjson']['integral']*$v1['money']*$v1['nums']*0.01);
                        $add['integral'] = round($snop[$k1]['snopjson']['integral']*$v1['money']*$v1['nums']*0.01);
                        if($add['integral']>0){
                            if(!M('integral')->add($add)){
                                $Order->rollback();
                                retJson("404","操作失败2");
                            }
                        }
                        if(!M('integral')->add($add)){
                            $Order->rollback();
                        }
                    }
                }

                if($integral != 0){
                    //积分商品订单无需更新用户积分
                    if(D('Home/user')->update_integral($v['uid'],round($integral))){
                        $Order->commit();//提交
                    }else{
                        $Order->rollback();
                    };//更新用户积分数据
                }else{
                    $Order->commit();//提交
                }
            }
        }
        $Order->rollback();
    }

    /**
     * 开发者：huangwei
     * 方法功能：收货后7天关闭评价入口(不管自动收货还是手动)
     */
    public function pingjia(){
        $Order = D('order');
        $map['order_state'] = "50";//订单状态为已完成
        $map['evaluation_state'] = "0";//订单未评价
        $map['endtime'] = array('lt',date("Y-m-d H:i:s",strtotime("-7 day")));//收货后7天

        $Order->where($map)->setField('evaluation_state',2);//设置为过期
    }

    /**
     * 开发者：huangwei
     * 方法功能：订单超过24小时自动关闭
     */
    public function close_order(){
        $order = M('order');
        $map['order_state'] = "10";//待付款订单
        $map['create_time'] = array('lt',date("Y-m-d H:i:s",strtotime("-1 day")));
        $data = $order->where($map)->field('orderid')->select();//超过1天的订单时间
        if(count($data)>0){
            foreach ($data as $k => $v){
                $temp[] = $v['orderid'];
            }
            $map1['orderid']  = array('in',$temp);
            $save['order_state'] = "0";
            $order->where($map1)->save($save);
        }
    }

}