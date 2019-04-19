<?php

require_once('fw/session_manager.csp');

function smarty_function_grn_get_update_notification_time_header(
    $params,
    $smarty
) {
    $session_manager = CB_SessionManager::getInstance();
    $session = $session_manager->getSession('notification');
    $last_time_update = $session->get("last_time_update");

    global $G_config_common;
    $update_notification_time = $G_config_common->get('Global',
        'update_notification_time');

    if ($update_notification_time && $update_notification_time > 0) {
        $update_notification_time = 60 * $update_notification_time;
        if ((time() - $last_time_update) < $update_notification_time) {
            $update_notification_time = $update_notification_time - (time()
                                                                     - $last_time_update);
        }
    } else {
        $update_notification_time = 0;
    }

    return $update_notification_time * 1000;
}
