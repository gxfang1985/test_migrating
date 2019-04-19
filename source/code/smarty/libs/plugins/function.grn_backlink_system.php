<?php
/**
 * @name   grn_backlink_system
 * @description show site position
 *
 */

function smarty_function_grn_backlink_system($parameters, &$smarty)
{
    $page_fragments = explode('/', cb_get_pagename());
    $app_id = $page_fragments[0];
    $app = null;
    $logic = null;

    if ((count($page_fragments) > 1) && ($page_fragments[0] === 'system')) {
        require_once('grn/system_logic.csp');
        $tmp_id = $page_fragments[1];
        $system = GRN_System::getInstance();
        $logic = $system->getLogic($tmp_id);
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
            $msg = cb_msg('fw.ui', 'backlink',
                ['app_name' => htmlspecialchars($name)]);

            return '<a class="footer_back_grn" href="' . cb_pageurl($page,
                    $site_info) . '">' . $msg . '</a>';
            break;
        }
        $ct++;
    }

    if ($app) {
        $msg = cb_msg('fw.ui', 'backlink',
            ['app_name' => htmlspecialchars($app->getDefaultName())]);

        return '<a class="footer_back_grn" href="'
               . cb_pageurl('system/application_list', ['app_id' => $app_id])
               . '">' . $msg . '</a>';
    } elseif ($logic) {
        $msg = cb_msg('fw.ui', 'backlink',
            ['app_name' => htmlspecialchars($logic->getName())]);

        return '<a class="footer_back_grn" href="'
               . cb_pageurl('system/common_list', ['id' => $logic->getId()])
               . '">' . $msg . '</a>';
    }
}

