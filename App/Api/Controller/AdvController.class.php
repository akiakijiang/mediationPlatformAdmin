<?php
namespace Api\Controller;

use Think\Controller;

class AdvController extends Controller
{
    public function getAdvs()
    {

        $list = D("Adv", "Logic")->getAdvs();

        succReturn($list['data']);

    }


}