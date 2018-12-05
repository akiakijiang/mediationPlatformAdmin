<?php
namespace Api\Controller;

use Think\Controller;

class LinkController extends Controller
{
    public function getLinks()
    {

        $list = D("Link", "Logic")->getLinks();

        succReturn($list['data']);

    }


}