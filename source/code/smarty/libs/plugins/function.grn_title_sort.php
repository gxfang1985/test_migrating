<?php
require_once('fw/i18n.csp');

/**
 * @name   grn_title_sort
 *  ソート
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 *
 * @param  string  title       タイトル
 * @param  string  page        画面名
 * @param  array   params      その他の必要なパラメータ
 * @param  reverse             降順フラグ
 * @param  link                リンクの状態
 * @param  disable             アイコンの状態
 *
 * @date   2004/11/18
 * @author Y.Tanaka
 *
 * @date   2004/12/6
 * @author Kei Tokuta
 *
 * Examples;
 *  {grn_title_sort title="選択状態(リンクあり・降順)" page=$page_info.all link=true reverse=true}
 *  {grn_title_sort title="非選択状態(リンクあり)" page=$page_info.all disable=true link=true}
 *  {grn_title_sort title="選択状態(リンクなし)" page=$page_info.all link=false}
 */

function smarty_function_grn_title_sort($params, &$smarty)
{
    // title
    $title = $params['title'];
    unset($params['title']);

    // page
    $page = $params['page'];
    unset($params['page']);

    // state
    $image_class = 'sortdown16';
    if (array_key_exists('reverse', $params)) {
        if ($params['reverse']) {
            $image_class = 'sortup16';
        }
    }

    // disable
    if (array_key_exists('disable', $params)) {
        if ($params['disable']) {
            $image_class .= '_n';
        }
        unset($params['disable']);
    }

    $image_class .= '.gif';

    // link
    $link = true;
    if (array_key_exists('link', $params)) {
        if ( ! $params['link']) {
            $link = false;
        }
        unset($params['link']);
    }

    // other params
    if (array_key_exists('params', $params)) {
        $user_params = $params['params'];
        unset($params['params']);
        if ($user_params) {
            $params += $user_params;
        }
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    if (array_key_exists('flag_mail', $params)) {
        $img_tag = smarty_function_grn_image([
            'image' => $image_class,
            'alt'   => cb_msg('grn.common',
                'sort'),
            'class' => 'mail-sortDate-grn'
        ], $smarty);
    } else {
        $img_tag = smarty_function_grn_image([
            'image' => $image_class,
            'alt'   => cb_msg('grn.common',
                'sort')
        ], $smarty);
    }
    if ($link) {
        $link_tag = '<a href="' . cb_pageurl($page, $params) . '" title="'
                    . cb_msg('grn.common', 'sort') . '">' . $img_tag . '</a>';
    } else {
        $link_tag = '<a name="#" title="' . cb_msg('grn.common', 'sort') . '">'
                    . $img_tag . '</a>';
    }

    $return_string = htmlspecialchars($title) . $link_tag;

    return $return_string;
}

