<?php
/**
 * @name   grn_backlink_personal
 * @description show site position
 *
 */

function smarty_function_grn_backlink_personal($parameters, &$smarty)
{
    $page_fragments = explode('/', cb_get_pagename());
    $app_id = $page_fragments[0];
    $app = null;
    $logic = null;

    if ((count($page_fragments) > 1) && ($page_fragments[0] === 'personal')) {
        require_once('grn/personal_logic.csp');
        $tmp_id = $page_fragments[1];
        $personal = GRN_Personal::getInstance();
        $logic = $personal->getLogic($tmp_id);
    }

    if (strlen($app_id) > 0) {
        require_once('grn/application.csp');
        $locator = GRN_ApplicationLocator::instance();
        $app = $locator->getInstance($app_id);
    }

    $positions = (array)@ $parameters['positions'];
    $result = array_reverse($positions);
    $ct = 0;

    foreach ($result as $site_info) {
        $name = $site_info['name'];
        $page = @ $site_info['page'];
        unset($site_info['name']);
        unset($site_info['page']);
        if ($ct == 1) {
            $msg = cb_msg('fw.ui', 'backlink', ['app_name' => $name]);

            return '<a class="footer_back_grn" href="' . cb_pageurl($page,
                    $site_info) . '">' . $msg . '</a>';
            break;
        }
        $ct++;
    }
    if ($app) {
        $msg = cb_msg('fw.ui', 'backlink', ['app_name' => $app->getName()]);

        return '<a class="footer_back_grn" href="'
               . cb_pageurl('personal/application_list', ['app_id' => $app_id])
               . '">' . $msg . '</a>';
    } elseif ($logic) {
        $msg = cb_msg('fw.ui', 'backlink', ['app_name' => $logic->getName()]);

        return '<a class="footer_back_grn" href="'
               . cb_pageurl('personal/common_list', ['id' => $logic->getId()])
               . '">' . $msg . '</a>';
    }
}

