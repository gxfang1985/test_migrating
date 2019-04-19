<?php

/**
 * @name   grn_saas_support_link
 * Display support link for Partner Cloud.
 *
 *  For example
 *  <pre>{grn_appname app_id="sample"}
 */
function smarty_function_grn_saas_support_link($params, &$smarty)
{
    global $G_config_common;

    $support_link = $G_config_common->get('SaaS', 'support_link');
    $enable_support_link = true;
    if (is_numeric($support_link) && 1 === (int)$support_link) {
        $enable_support_link = false;
    }

    $link = '';
    if (true === $enable_support_link) {
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
        $saas_license_user = $uum->checkSaasLincense();
        $active_count = $uum->getActiveUserCount() - 1;
        if ($active_count <= $saas_license_user) {
            if ( ! $support_link) {
                $support_link = cb_pageurl('system/support/support');
            } else {
                $support_link = htmlspecialchars($support_link);
            }
            $link = '<li><a href="' . $support_link . '">'
                    . cb_msg('grn.common', 'support')
                    . '</a></li>';
        }
    }

    return $link;
}
