<?php
function smarty_function_grn_favour_notify_all_number($params, &$smarty)
{
    require_once('fw/session_manager.csp');
    $session_manager = CB_SessionManager::getInstance();
    $session = $session_manager->getSession('notification');
    $number_of_all = $session->get('favour_notify_number');
    if ($number_of_all > 20) {
        $number_of_all = "20+";
    }
    $favour_menu_title = cb_msg('grn.favour', 'favour_header_menu_title')
                         . cb_msg('grn.favour',
            'favour_header_menu_left_parenthesis')
                         . $number_of_all . cb_msg('grn.favour',
            'favour_header_menu_right_parenthesis');

    $t = new GRN_Smarty();
    $t->assign('number_of_favour', $number_of_all);
    $t->assign('favour_menu_title', $favour_menu_title);

    return $t->fetch('grn/favour_all_number.tpl');
}

