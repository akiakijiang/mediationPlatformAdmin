<?php
namespace Admin\Controller;
use Think\Controller;
class CouponController extends PublicController {

    protected $model;
    protected $cdkey;
    protected $shopid;
    protected $pk;

    public function _initialize(){
        $this->model = D('Coupon');
        $this->cdkey = M("Cdkey");
        $this->shopid = session('admin.shopid');
        $this->pk = $this->model->getpk();
    }

    /**
     * 方法功能：优惠券列表
     */
    public function lists(){
        $count      = $this->model->count();
        $Page       = new \Think\Page($count,5);
        $show       = $Page->show();
        $classify = $this->model->order("addtime desc")->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('page',$show);
        $this->assign('data',json_encode($classify));
        $this->display();
    }

    /**
     * 方法功能：添加优惠券主方法/确认发放
     */
    public function handle(){
        $data = I('post.');
//        dump($data);
//        exit;



        if ($res = $this->model->create($data)) {

            if(!$data['id']){
                $path = "/Uploads/coupon/".date("Ymd").substr(implode(null,str_split(substr(uniqid(),7,13),1)),0,8).".png";//生成路径
                $couponImage = getCouponImage($res,"./".$path);//生成优惠券图片
                $res['coupon_path'] = $path;
                $id = $this->model->add($res);
                if ($id != false) {
                    //添加兑换码
                    $cdkey['cid'] = $id;
                    for($i=1;$i<=$res["num"];$i++){
                        $cdkey["cdkey"] = substr(md5(date("Ymd").substr(implode(null,str_split(substr(uniqid(),7,13),1)),0,8).$i),10,10);
                        $this->cdkey->add($cdkey);
                    }
                    retJson("200","添加成功！");
                }else {
                    retJson("404","添加失败！");
                }
            }else{
                $res = $this->model->is_issue($data['id']);
                if($res){
                    retJson("404",$res);
                }
                if ($this->cdkey->where(["id"=>$data['id']])->setField("is_issue",1) !== false) {
                    retJson("200","发放成功！");
                }else {
                    retJson("404","发放失败！");
                }
            }
        }else{
            retJson("404",$this->model->getError());
        }
    }

    /**
     * 方法功能：添加优惠券页面
     */
    public function add(){
        $this->display();
    }

    /**
     * 方法功能：查看优惠券页面
     */
    public function edit(){
        $id = I('get.id',0);
        $map[$this->pk] = $id;
        $data = $this->model->where($map)->find();
        $data["cdkey"] = $this->cdkey->where(["cid"=>$id])->select();

        $this->assign('data',$data);
        $this->display('add');
    }

    /**
     * 方法功能：导出优惠券
     */
    public function excel(){
        $cid = I("post.excel/d",0);
        if($cid){
            $data = $this->cdkey->field("cdkey,is_issue,getuid")->where(['cid'=>$cid])->select();
//            $objPHPExcel = new \PHPExcel\Spreadsheet();

            $objPHPExcel = new \PHPExcel();
            $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
            $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(15);
            $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
            $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(10);
            $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A1', 'ID')
                ->setCellValue('B1', '兑换码')
                ->setCellValue('C1', '是否发放')
                ->setCellValue('D1', '是否领取');

            foreach ($data as $k=>$v){
                $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue('A'.($k+2) , $k+1)
                    ->setCellValue('B'.($k+2) , $v['cdkey'])
                    ->setCellValue('C'.($k+2) , ($v['is_issue']==1?"已发放":"未发放"))
                    ->setCellValue('D'.($k+2) , ($v['getuid']!=0?"已领取":"未领取"));
            }

            $objPHPExcel->getActiveSheet()->setTitle('兑换码表');//设置文件的标题
            $objPHPExcel->getActiveSheetIndex(0);//设置当前工作表
            header("Content-Type:application/vnd.ms-execl");
            header('Content-Disposition:attachment;filename="兑换码表.xls"');
            header("Cache-Control:max-age=0");
            header("Cache-Control:max-age=1");
            header("Expires:Mon,26 Jul 1997 05:00:00 GMT");//data in the past
            header("Last-Modified:".gmdate('D, d M Y H:i:s').' GMT');//always modified
            header("Cache-Control: cache,must-revalidate");//HTTP/1.1
            header("Pragma: public");//HTTP/1.0
//            $objWriter = \PHPExcel\IOFactory::createWriter($objPHPExcel,'Excel5');
            $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $objWriter->save('php://output');
        }
    }

    /**
     * 方法功能：删除优惠券主方法
     */
    public function del(){
        $id = I('get.id',0);
        if($this->cdkey->where("cid=$id and is_issue=1")->select()){//是否已发放
            retJson("404","部分兑换码已发放或已领取！");
        }
        $image = $this->model->where(["id"=>$id])->getField("coupon_path");//查图片名
        if($this->model->where(["id"=>$id])->delete()){
            $this->cdkey->where(["cid"=>$id])->delete();
            unlink("./".$image);                                        //删除图片文件
            retJson("200","删除成功！");
        }else{
            retJson("404","删除失败!");
        }
    }


    public function fa(){
        $id= I('post.id');
        $save['is_issue'] = 1;
        if ($this->cdkey->where(["c_id"=>$id])->setField("is_issue",1) !== false) {
            retJson("200","发放成功！");
        }else {
            retJson("404","发放失败！");
        }
    }
}