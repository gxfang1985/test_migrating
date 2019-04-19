<?php
function smarty_function_grn_notification_all_number($params, &$smarty)
{
    require_once('fw/session_manager.csp');
    $session_manager = CB_SessionManager::getInstance();
    $session = $session_manager->getSession('notification');
    $number_of_all = $session->get("notification_number");
    if ($number_of_all > 99) {
        $number_of_all = "99+";
    }
    $notification_menu_title = cb_msg('grn.notification',
            'notification_header_menu_title')
                               . cb_msg('grn.notification',
            'notification_header_menu_left_parenthesis')
                               . $number_of_all . cb_msg('grn.notification',
            'notification_header_menu_right_parenthesis');

    $t = new GRN_Smarty();
    $t->assign('number_of_notification', $number_of_all);
    $t->assign('notification_menu_title', $notification_menu_title);

    return $t->fetch('grn/notification_all_number.tpl');
}

