<?php
namespace Home\Model;
use Think\Model;
class SuggestModel extends Model {

    protected $_validate = array(
        array('content','require','建议不能为空！'),
    );

    protected $_map = array(

    );

    protected $_auto = array(

    );

}