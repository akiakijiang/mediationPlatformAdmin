<?php
namespace MiniApi\Logic;
use Think\Cache\Driver\Hredis;
use Think\Model;

class UserLogic extends Model
{

    protected $appId;
    protected $appSecret;
    protected $session_key;
    protected $redis;
    protected $defaultMemberId = "130000000";

    public function __construct()
    {
        parent::__construct();
        $this->appId = C('MINI_APP_ID');
        $this->appSecret = C('MINI_APP_SECRET');
        $this->redis = new Hredis();

    }

    public function login($params)
    {
        $code       = $params['code'];
        $signature  = $params['signature'];
        $rawData    = $params['rawData'];
        $encryptedData = $params['encryptedData'];
        $iv         = $params['iv'];
        $phone      = $params['phone'];

        if (!$code || !$signature || !$rawData || !$encryptedData || !$iv)
        {
            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }

        $get_openid_res = $this->getUserOpenId($code);

        if ($get_openid_res['status'] != 200) {
            return $get_openid_res;
        }

        //校验
        if (!$this->checkUserInfo($signature, $rawData)) {
            return ['status' => 500, 'info' => '获取用户不合法', 'data' => []];
        }

        $res = $this->decryptUserInfo($encryptedData, $iv);

        if ($res['status'] != 200) {
            return $res;
        }

        $data = $res['data'];

        //生成第三方3rd_session，用于第三方服务器和小程序之间做登录态校验
        $session3rd = $this->get3rdSession($get_openid_res['openid']);

        $data['session3rd'] = $session3rd;

        //判断是否是新老用户
        $openid = $get_openid_res['openid'];

        $user_model = D("User");
        $user_info = $user_model->where(['openid' => $openid])->find();

        if (empty($user_info)) {

            $insert_data['phone']       = $phone;
            $insert_data['openid']      = $openid;
            $insert_data['unionid']     = $get_openid_res['unionid'];
            $insert_data['nick_name']   = base64_encode($data['nickName']);
            $insert_data['gender']      = $data['gender'];
            $insert_data['create_time'] = time();
            $insert_res = $user_model->data($insert_data)->add();

            if ($insert_res === false) {
                return ['status' => 500, 'info' => '注册失败', 'data' => []];
            }

            $update_data['member_id'] = $this->generateMemID($insert_res);
            $update_data['update_time'] = time();
            $update_res = $user_model->where(['openid' => $openid])->data($update_data)->save();

        } else {
            $uid = $user_info['uid'];

            if (!$user_info['member_id']) {
                $update_data['member_id'] = $this->generateMemID($uid);
                $update_data['update_time'] = time();
                $update_res = $user_model->where(['uid' => $uid])->data($update_data)->save();
            }
        }


        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }

    public function getUserOpenId($code)
    {
        if (!$code) {
            return ['status' => 500, 'info' => '请上传code参数', 'data' => []];
        }

        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$this->appId}&secret={$this->appSecret}&js_code={$code}&grant_type=authorization_code";

        $res = httpRequest($url);

        if (!$res || $res['errcode'] != 0 ) {
            \Think\Log::record("获取openid失败" . json_encode($res), \Think\Log::ERR);
            return ['status' => 500, 'info' => '获取openid失败', 'data' => []];
        }

        //结果有openid, session_key, unionid
        $this->session_key = $res['session_key'];

        $openid = $res['openid'];

        $data['openid'] = $openid;

        $data['unionid'] = $res['unionid'];

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }




    public function checkUserInfo($signature, $rawData)
    {

        $signatureSha1 = sha1($rawData . $this->session_key);

        if ($signature == $signatureSha1) {
            return true;
        } else {
            return false;
        }
    }

    public function decryptUserInfo($encryptedData, $iv)
    {
        $data = '';

        $wx_data = new \WXBizDataCrypt($this->appId, $this->session_key);

        $errCode = $wx_data->decryptData($encryptedData, $iv, $data);

        if ($errCode == 0) {
            return ['status' => 200, 'info' => 'ok', 'data' => $data];
        } else {
            return ['status' => $errCode, 'info' => 'ok', 'data' => []];
        }
    }

    private function get3rdSession($openid)
    {
        $session3rd = $this->randomFromDev(16);

        $this->redis->set($session3rd, $openid . $this->session_key);
        $this->redis->expire($session3rd, 2592000);

        return $session3rd;
    }

    private function randomFromDev($len) {
        $fp = @fopen('/dev/urandom','rb');
        $result = '';

        if ($fp !== false) {
            $result .= @fread($fp, $len);
            @fclose($fp);
        } else {
            trigger_error('Can not open /dev/urandom.');
        }
        // convert from binary to string
        $result = base64_encode($result);
        // remove none url chars
        $result = strtr($result, '+/', '-_');
        return substr($result, 0, $len);
    }


    //生成会员ID
    protected function generateMemID($uid)
    {
        $date = date("Ymd", time());
        $member_id = (int)$this->defaultMemberId  +  $uid;
        return $member_id;
    }


    /**
     * 更换手机号
     * @param $old_phone
     * @param $new_phone
     * @return array
     */
    public function changeUserPhone($old_phone, $new_phone)
    {
        if (!$old_phone || !$new_phone) {
            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }


        if (strcmp($old_phone, $new_phone) == 0) {
            return ['status' => 500, 'info' => '您输入的新旧手机号重复了', 'data' => []];
        }

        $where['phone'] = $old_phone;

        $update_data['phone'] = $new_phone;

        $user_info = D("User")->where($where)->find();

        if (empty($user_info)) {
            return ['status' => 500, 'info' => '您提供的旧手机号有误', 'data' => []];
        }


        $change_res = D("User")->where($where)->data($update_data)->save();
        if ($change_res === false) {
            return ['status' => 500, 'info' => '更改失败', 'data' => []];
        }

        return ['status' => 200, 'info' => '更改成功', 'data' => []];
    }


    public function getMyComments($params)
    {

        $uid = $params['uid'];
        $index = $params['index']?$params['index']: 0;
        $defalut_limt = 5;
        $limit = "$index, $defalut_limt";
        if (!$uid) {
            return ['status' => 500, 'info' => '缺少必要参数', 'data' => []];
        }

        $where['s.uid'] = $uid;

        $comment_res   = D("User")->getComments($where, $limit);

        if (empty($comment_res)) {
            return ['status' => 500, 'info' => '暂无数据', 'data' => []];
        }

        $data['index'] = $index;

        $list = [];

        $i = 0;
        foreach ($comment_res as $val) {
            $list[$i]['shop_id']        = $val['shop_id'];
            $list[$i]['shop_title']     = $val['shop_title'];
            $list[$i]['content']        = $val['content'];
            $list[$i]['star']           = $val['star'];
            $list[$i]['create_time']   = date('Y-m-d', $val['create_time']);
            $i++;
        }

        $data['comment_list'] = $list;

        return ['status' => 200, 'info' => 'ok', 'data' => $data];

    }

}