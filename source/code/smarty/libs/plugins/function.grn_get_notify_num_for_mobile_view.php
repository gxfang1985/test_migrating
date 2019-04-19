<?php

require_once('fw/session_manager.csp');

function smarty_function_grn_get_notify_num_for_mobile_view($params, $smarty)
{
    if (array_key_exists('isAppMenu', $params)) {
        $is_app_menu = $params['isAppMenu'];
    } else {
        $is_app_menu = false;
    }

    $mid = null;
    if (array_key_exists('mid', $params)) {
        $mid = $params['mid'];
    }

    if (grn\grn\Validate::isNull($mid)) {
        return '';
    }

    $session_manager = CB_SessionManager::getInstance();
    $session = $session_manager->getSession('notification');
    $each_notification_number = $session->get("each_notification_number");

    require_once("notification/application.csp");
    $app_locator = GRN_ApplicationLocator::instance();
    $notification_app = $app_locator->getInstance(GRN_NOTIFICATION_APP_ID);


    if ($mid == "notification") {
        $count
            = _constructNotificationNumber($session->get('notification_number'));
    } elseif (is_array($each_notification_number)
              && array_key_exists($mid, $each_notification_number)
              && $notification_app
    ) {
        $count = _constructNotificationNumber($each_notification_number[$mid]);
    } else {
        $count = 0;
    }

    if ($is_app_menu) {
        return '<span ' . ($count == 0 ? 'style="display:none;" ' : '')
               . 'class="mobile_notify_num_grn" id="' . $mid . '_notify_num">'
               . $count . '</span>';
    } else {
        return '<span ' . ($count == 0 ? 'style="display:none;" ' : '')
               . 'class="mobile_notify_sum_grn" id="mobile_footer_bar_notify_num" mid="'
               . $mid . '" >' . $count . '</span>';
    }
}

function _constructNotificationNumber($count)
{
    if (grn\grn\Validate::isNumber($count) && $count > 0) {
        return $count > 99 ? '99+' : $count;
    } else {
        return 0;
    }
}
