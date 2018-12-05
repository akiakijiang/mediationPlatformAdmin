<?php
namespace MiniApi\Controller;
use Think\Controller;

class PublicController extends Controller
{
    public function _initialize()
    {
        \Think\Log::record(sprintf("\nRAW:%s\nPOST:%s\nGET:%s\nSERVER: %s",
            file_get_contents('php://input'),
            http_build_query($_POST),
            http_build_query($_GET),
            json_encode($_SERVER)
        ), \Think\Log::DEBUG);
        error_reporting( E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED);
    }
}