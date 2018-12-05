<?php
/**
 * This file is part of workerman.
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the MIT-LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @author walkor<walkor@workerman.net>
 * @copyright walkor<walkor@workerman.net>
 * @link http://www.workerman.net/
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 */

/**
 * 用于检测业务代码死循环或者长时间阻塞等问题
 * 如果发现业务卡死，可以将下面declare打开（去掉//注释），并执行php start.php reload
 * 然后观察一段时间workerman.log看是否有process_timeout异常
 */
//declare(ticks=1);

/**
 * 聊天主逻辑
 * 主要是处理 onMessage onClose 
 */
use \GatewayWorker\Lib\Gateway;
use \GatewayWorker\Lib\Db;

class Events
{
   
   /**
    * 有消息时
    * @param int $client_id
    * @param mixed $message
    */
   public static function onMessage($client_id, $data)
   {
       $message = json_decode($data, true);
       $message_type = $message['type'];

       echo($data);

       switch ($message_type) {
           case 'login':
               $uid = $message['id'];
               $dbl = Db::instance('db');//数据库链接

               //设置session
               $_SESSION = [
                   'username' => $message['username'],
                   'avatar' => $message['avatar'],
                   'id' => $uid,
               ];

               
               //将当前链接与uid绑定
               Gateway::bindUid($client_id, $uid);
               //通知当前客户端初始化
               $init_message = array(
                   'message_type' => 'login',
                   'id' => $uid,
                   'username' => $message['username'],
               );
               Gateway::sendToClient($client_id, json_encode($init_message));

               //查询最近一周有无要推送的离线消息
               $time = time() - 7 * 3600 * 24;
               $resMsg = $dbl->select('id,fromid,fromname,fromavatar,timeline,content')->from('chatlog')
                   ->where("toid= {$uid} and timeline > {$time} and type= 'friend'and needsend = 1")
                   ->query();
               //var_export($resMsg);
               if (!empty($resMsg)) {

                   foreach ($resMsg as $key => $vo) {

                       $log_message = [
                           'message_type' => 'logmessage',
                           'data' => [
                               'username' => $vo['fromname'],
                               'avatar' => $vo['fromavatar'],
                               'id' => $vo['fromid'],
                               'type' => 'friend',
                               'content' => htmlspecialchars($vo['content']),
                               'timestamp' => $vo['timeline'] * 1000,
                           ]
                       ];

                       Gateway::sendToUid($uid, json_encode($log_message));

                       //设置推送状态 为已推送
                       $dbl->query("UPDATE `chatlog` SET `needsend` = '0' WHERE id=" . $vo['id']);
                   }
               }
               return;
               break;
           case 'chatMessage':
               $dbl = Db::instance('db');  //数据库链接
               //聊天消息
               $type = $message['data']['to']['type'];
               $to_id = $message['data']['to']['id'];
               $uid = $_SESSION['id'];

               $chat_message = [
                   'message_type' => 'chatMessage',
                   'data' => [
                       'username' => $_SESSION['username'],
                       'avatar' => $_SESSION['avatar'],
                       'id' => $type === 'friend' ? $uid : $to_id,
                       'type' => $type,
                       'content' => htmlspecialchars($message['data']['mine']['content']),
                       'timestamp' => time() * 1000,
                   ]
               ];
               //聊天记录数组
               $param = [
                   'fromid' => $uid,
                   'toid' => $to_id,
                   'fromname' => $_SESSION['username'],
                   'fromavatar' => $_SESSION['avatar'],
                   'content' => htmlspecialchars($message['data']['mine']['content']),
                   'timeline' => time(),
                   'needsend' => 0
               ];
               switch ($type) {
                   //私聊
                   case 'friend':
                       //插入
                       $param['type'] = 'friend';
                       if (empty(Gateway::getClientIdByUid($to_id))) {
                           $param['needsend'] = 1;//用户不在线，标记此消息推送
                       }
                       $dbl->insert('chatlog')->cols( $param )->query();
                       return Gateway::sendToUid($to_id, json_encode($chat_message));
               }
               return;
               break;
           case 'ping':
               return;
           default:
               echo "unknown message $data" . PHP_EOL;
       }
   }
   
   /**
    * 当客户端断开连接时
    * @param integer $client_id 客户端id
    */
   public static function onClose($client_id)
   {
       // debug
       echo "client:{$_SERVER['REMOTE_ADDR']}:{$_SERVER['REMOTE_PORT']} gateway:{$_SERVER['GATEWAY_ADDR']}:{$_SERVER['GATEWAY_PORT']}  client_id:$client_id onClose:''\n";
       
       // 从房间的客户端列表中删除
       if(isset($_SESSION['room_id']))
       {
           $room_id = $_SESSION['room_id'];
           $new_message = array('type'=>'logout', 'from_client_id'=>$client_id, 'from_client_name'=>$_SESSION['client_name'], 'time'=>date('Y-m-d H:i:s'));
           Gateway::sendToGroup($room_id, json_encode($new_message));
       }
   }
  
}
