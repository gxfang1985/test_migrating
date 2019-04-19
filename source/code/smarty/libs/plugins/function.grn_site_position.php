<?php
/**
 * @name   grn_site_position
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
 *  {grn_site_position positions=$site_position}
 */

function smarty_function_grn_site_position($parameters, &$smarty)
{
    if (array_key_exists('positions', $parameters)) {
        $positions = (array)$parameters['positions'];
    } else {
        $positions = [];
    }
    $app_name = explode('/', $positions[0]['page']);
    $app_name = $app_name[0];

    $link_array = [];
    foreach ($positions as $site_info) {
        $name = $site_info['name'];
        unset($site_info['name']);

        // page
        $page = null;
        if (array_key_exists('page', $site_info)) {
            $page = $site_info['page'];
            unset($site_info['page']);
        }

        // fragment
        $fragment = null;
        if (array_key_exists('fragment', $site_info)) {
            $fragment = $site_info['fragment'];
            unset($site_info['fragment']);
        }

        // icon
        $icon = null;
        if (array_key_exists('icon', $site_info)) {
            $icon = $site_info['icon'];
            unset($site_info['icon']);
        }

        $isHidden = false;
        if (array_key_exists('isHidden', $site_info)) {
            $isHidden = $site_info['isHidden'];
            unset($site_info['isHidden']);
        }

        ## ここから表示。
        $site_info_string = "";

        if (strlen($page) > 0) {
            $site_info_string .= '<a href="' . cb_pageurl($page, $site_info,
                    $fragment) . '">';
        }

        if (is_array($icon)) {
            require_once $smarty->_get_plugin_filepath('function', 'grn_image');
            $site_info_string .= smarty_function_grn_image($icon, $smarty);
        }

        $site_info_string .= htmlspecialchars($name);

        if (strlen($page) > 0) {
            $site_info_string .= '</a>';
        }

        if ($isHidden) {
            require_once $smarty->_get_plugin_filepath('function', 'grn_image');
            $site_info_string .= ' <span class="globalNavi-private-grn ">' .
                                 cb_msg("fw.common", "private-left-parenthesis")
                                 .
                                 '<span class="icon-space-pale-private-grn"></span>'
                                 .
                                 cb_msg("fw.common", "private") .
                                 cb_msg("fw.common",
                                     "private-right-parenthesis") . '</span>';
        }

        $link_array[] = $site_info_string;
    }

    $link = '';
    // if( count($link_array) )
    // {
    // $link = implode('&nbsp;&gt;&nbsp;', $link_array);
    // }
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

    $image_param = ['image' => grn_site_position_app2image($app_name)];
    require_once('function.grn_image.php');

    return '<div class="global_navi">&nbsp;'
           . smarty_function_grn_image($image_param, $smarty) . $link
           . '</div>';
}

function grn_site_position_app2image($app_name)
{
    $app2image = [
        'portal'       => 'portal20.gif',
        'space'        => 'space20.png',
        'link'         => 'linklist20.gif',
        'schedule'     => 'schedule20.gif',
        'message'      => 'msg20.gif',
        'bulletin'     => 'bulletin20.gif',
        'cabinet'      => 'file20.gif',
        'memo'         => 'memo20.gif',
        'phonemessage' => 'where20.gif',
        'timecard'     => 'timecard20.gif',
        'todo'         => 'todo20.gif',
        'address'      => 'person20.gif',
        'mail'         => 'mail20.gif',
        'workflow'     => 'workflow20.gif',
        'report'       => 'report20.gif',
        'rss'          => 'rss20.gif',
        'notification' => 'notify20.gif',
        'star'         => 'star20.gif',
    ];
    if (array_key_exists($app_name, $app2image)) {
        return $app2image[$app_name];
    } else {
        return '';
    }
}

