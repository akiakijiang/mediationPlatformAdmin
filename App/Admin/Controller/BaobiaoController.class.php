<?php
namespace Admin\Controller;
use Think\Controller;
class BaobiaoController extends PublicController {

    protected $model;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        //$this->model = D('Menu');
        $this->shopid = session('admin.shopid');
        //$this->pk = $this->model->getpk();
    }

    public function user(){
        $end = date("Y-m-d",strtotime('+1 days'));//默认结束时间为当天
        $start = date('Y-m-d', strtotime('-15 days'));//默认开始时间为7天前
        $data = M()->query("SELECT nickname,regtime FROM user Where DATE_FORMAT(regtime,'%Y-%m-%d') >= '$start' and DATE_FORMAT(regtime,'%Y-%m-%d')<= '$end'");
        $nub = array_column($data,'nub');

        $all_date = get_all_day($end,$start);

        foreach ($all_date as $k => $v){
            $nub[$k] = 0;
            foreach ($data as $k1 => $v1){
                if(date("Y-m-d",strtotime($v1['regtime'])) == $v){
                    $nub[$k]++;
                }
            }
        }

        $this->assign('alldate',json_encode($all_date));
        $this->assign('nub',json_encode($nub));
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：打款统计
     */
    public function money(){
        $get = I('get.');

        if(!is_null($get['end']) || !is_null($get['start'])){
            $end = $get['end'];
            $start = $get['start'];
        }else{
            $end = date("Y-m-d",strtotime('+1 days'));//默认结束时间为当天
            $start = date('Y-m-d', strtotime('-15 days'));//默认开始时间为7天前
        }

        $data = M()->query("SELECT time,money FROM dividedinto Where DATE_FORMAT(time,'%Y-%m-%d') >= '$start' and DATE_FORMAT(time,'%Y-%m-%d')<= '$end' and status=2");
        $all_date = get_all_day($end,$start);

        foreach ($all_date as $k => $v){
            $money[$k] = 0;
            foreach ($data as $k1 => $v1){
                if(date("Y-m-d",strtotime($v1['time'])) == $v){
                    $money[$k] = $money[$k] + $v1['money'];
                }
            }
        }

        $this->assign('alldate',json_encode($all_date));
        $this->assign('itime',array($end,$start));
        $this->assign('nub',json_encode($money));
        $this->display();
    }

    /**
     * 开发者：akiaki
     * 方法功能：计算销售量，销售额
     */
    public function xiaoshou(){
        $get = I('get.');

        if(!is_null($get['end']) || !is_null($get['start'])){
            $end = $get['end'];
            $start = $get['start'];
        }else{
            $end = date("Y-m-d",strtotime('+1 days'));//默认结束时间为当天
            $start = date('Y-m-d', strtotime('-15 days'));//默认开始时间为7天前
        }

        $all_date = get_all_day($end,$start);

        $map['pay_time'] = array(array('gt',$start),array('lt',$end));
        $data = D('order')->where($map)->relation('snop')->field('pay_time,orderid,money,refund_amount')->select();

        foreach ($data as $k => $v){
            $data[$k]['nub'] = 0;
            foreach ($data[$k]['snop'] as $k1 => $v1){
                $data[$k]['nub'] = $data[$k]['nub'] + $v1['nums'];
            }
            unset($data[$k]['snop']);
        }

        foreach ($all_date as $k => $v){
            $nub[$k] = 0;
            $money[$k] = 0;
            $return[$k] = 0;
            foreach ($data as $k1 => $v1){
                if(date("Y-m-d",strtotime($v1['pay_time'])) == $v){
                    $nub[$k] = $nub[$k] + $v1['nub'];
                    $money[$k] = $money[$k] + $v1['money'];
                    $return[$k] = $return[$k] + $v1['refund_amount'];
                }
            }
        }

        $this->assign('alldate',json_encode($all_date));
        $this->assign('itime',array($end,$start));
        $this->assign('nub',json_encode($nub));
        $this->assign('money',json_encode($money));
        $this->assign('return',json_encode($return));
        $this->display();
    }




}