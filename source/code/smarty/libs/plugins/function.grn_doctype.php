<?php
function smarty_function_grn_doctype($params)
{
    $t = new GRN_Smarty();
    $t->assign('trim',
        array_key_exists('trim', $params) ? $params['trim'] : false);

    return $t->fetch("grn/doctype.tpl");
}
