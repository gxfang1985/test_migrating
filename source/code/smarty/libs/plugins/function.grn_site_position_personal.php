<?php
/**
 * @name   grn_site_position_personal
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
 *  {grn_site_position_personal positions=$site_position}
 */

function smarty_function_grn_site_position_personal($parameters, &$smarty)
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
    $link_array = [];
    require_once('function.grn_image.php');

    if ($app) {
        $link_array[] = '<a href="' . cb_pageurl('personal/application_list')
                        . '">'
                        . smarty_function_grn_image(['image' => 'function20.gif'],
                $smarty)
                        . htmlspecialchars(grn_get_page_display_name('personal/application_list'))
                        . '</a>';
        $link_array[] = '<a href="' . cb_pageurl('personal/application_list',
                ['app_id' => $app_id]) . '">'
                        . htmlspecialchars($app->getName()) . '</a>';
    } elseif ($logic) {
        $link_array[]
            = smarty_function_grn_image(['image' => 'adminbasic20.gif'],
                $smarty) . '<a href="' . cb_pageurl('personal/common_list')
              . '">'
              . htmlspecialchars(grn_get_page_display_name('personal/common_list'))
              . '</a>';
        $link_array[] = '<a href="' . cb_pageurl('personal/common_list',
                ['id' => $logic->getId()]) . '">'
                        . htmlspecialchars($logic->getName()) . '</a>';
    }
    if ($positions[0]['page'] == 'index') {
        $positions = array_slice($positions, 1);
    }
    if (sizeof($positions) == 1
        && $positions[0]['name'] == cb_msg('grn.personal', 'common_list')
    ) {
        $link_array[]
            = smarty_function_grn_image(['image' => 'adminbasic20.gif'],
                $smarty) . htmlspecialchars($positions[0]['name']);

        $positions = array_slice($positions, 1);
    }

    if (sizeof($positions) == 1
        && $positions[0]['name'] == cb_msg('grn.personal', 'application_list')
    ) {
        $link_array[] = smarty_function_grn_image(['image' => 'function20.gif'],
                $smarty) . htmlspecialchars($positions[0]['name']);

        $positions = array_slice($positions, 1);
    }

    foreach ($positions as $site_info) {
        $name = $site_info['name'];
        $page = @ $site_info['page'];
        unset($site_info['name']);
        unset($site_info['page']);
        if ($page == 'personal/common_list') {
            $link_array[] = '<a href="' . cb_pageurl($page, $site_info) . '">'
                            . smarty_function_grn_image(['image' => 'adminbasic20.gif'],
                    $smarty) . htmlspecialchars($name) . '</a>';
        } elseif ($page == 'personal/application_list') {
            $link_array[] = '<a href="' . cb_pageurl($page, $site_info) . '">'
                            . smarty_function_grn_image(['image' => 'function20.gif'],
                    $smarty) . htmlspecialchars($name) . '</a>';
        } else {
            if (strlen($page) > 0) {
                $link_array[] = '<a href="' . cb_pageurl($page, $site_info)
                                . '">' . htmlspecialchars($name) . '</a>';
            } else {
                $link_array[] = htmlspecialchars($name);
            }
        }
    }
    $max_link = count($link_array);
    foreach ($link_array as $key => $value) {
        if ($key < $max_link - 1) {
            $link .= "<span class='globalNavi-item-grn'>" . $value . "</span>";
            $link .= "<span class='globalNavi-item-grn-image'></span>";
        } else {
            $link .= "<span class='globalNavi-item-last-grn'>" . $value
                     . "</span>";
        }
    }

    return '<div class="global_navi">&nbsp;' . $link . '</div>';
}


