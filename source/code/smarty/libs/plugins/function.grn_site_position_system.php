<?php
/**
 * @name   grn_site_position_system
 * @description show site position
 *
 * @date        2004/10/20
 * @author      M.Oomori
 *
 *  Example.
 * ----- hoge.csp
 * $t->assign(
 *    'site_position',
 *    array(
 *        array( 'page'=>"bulletin/index" , 'name'=>grn_get_page_display_name( 'bulletin/index' ),
 *        array( 'page'=>"bulletin/send1" , 'name'=>grn_get_page_display_name( 'bulletin/send1' ) , 'cid=123')
 *    )
 * );
 * ----- hoge.tpl
 *  {* positionに渡した配列を順に読んで、page, nameの組でひとつずつ位置階層を書いてゆく。pageが""の場合、nameだけ出力 *}
 *  {grn_site_position_system positions=$site_position}
 */

function smarty_function_grn_site_position_system($parameters, &$smarty)
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

    $positions = [];
    if (isset($parameters['positions'])) {
        $positions = (array)$parameters['positions'];
    }

    $link_array = [];
    if ($app) {
        $link_array[] = '<a href="' . cb_pageurl('system/application_list')
                        . '">'
                        . htmlspecialchars(grn_get_page_display_name('system/application_list'))
                        . '</a>';
        $link_array[] = '<a href="' . cb_pageurl('system/application_list',
                ['app_id' => $app_id]) . '">'
                        . htmlspecialchars($app->getDefaultName()) . '</a>';
    } elseif ($logic) {
        $link_array[] = '<a href="' . cb_pageurl('system/common_list') . '">'
                        . htmlspecialchars(grn_get_page_display_name('system/common_list'))
                        . '</a>';
        $link_array[] = '<a href="' . cb_pageurl('system/common_list',
                ['id' => $logic->getId()]) . '">'
                        . htmlspecialchars($logic->getName()) . '</a>';
    }
    foreach ($positions as $site_info) {
        $name = $site_info['name'];

        $page = null;
        if (isset($site_info['page'])) {
            $page = $site_info['page'];
        }

        unset($site_info['name']);
        unset($site_info['page']);
        if (strlen($page) > 0) {
            $link_array[] = '<a href="' . cb_pageurl($page, $site_info) . '">'
                            . htmlspecialchars($name) . '</a>';
        } else {
            $link_array[] = htmlspecialchars($name);
        }
    }

    return '<div class="global_navi">&nbsp;' . implode(' &gt; ', $link_array)
           . '</div>';
}


