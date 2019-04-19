<?php

require_once('fw/session_manager.csp');

function smarty_function_grn_get_update_discussion_comment_count_time(
    $params,
    $smarty
) {
    global $G_config_common;
    $update_discussion_comment_time = $G_config_common->get('Global',
        'update_discussion_comment_count_time');

    if ($update_discussion_comment_time === false) {
        //default 30,000 ms
        return 30 * 1000;
    } elseif ($update_discussion_comment_time
              && $update_discussion_comment_time > 0
    ) {
        return intval($update_discussion_comment_time) * 1000;
    } else {
        return 0;
    }
}
