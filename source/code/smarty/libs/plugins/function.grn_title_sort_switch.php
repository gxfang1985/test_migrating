<?php

/**
 * @name   grn_title_sort_switch
 *      ソート　表示形式ボタン切り替えバージョン
 *      onClick で表示切り替え
 *
 * @date     2004/11/26
 * @author   Okahashi
 *
 * @date     2005.1
 * @author   Eiji TAEN
 *  grn_title_sortに合わせ、大幅変更
 *
 * @option   string    title           タイトル
 * @option   string    page            画面名
 * @option   string    class           ボタンのclass
 * @option   boolean   reverse         降順フラグ
 * @option   boolean   disable         アイコンの状態
 * @option   array     button_params   ボタン押下時に利用するパラメータ
 * @option   array     sort_params     ソート時に利用するパラメータ
 * @option   boolean   button_link     ボタンのリンクの状態
 * @option   boolean   sort_link       ソートのリンクの状態
 *
 * Examples;
 *  {grn_title_sort_switch title="選択状態(ボタンリンクあり・降順)" page=$page_info.all}
 *  {grn_title_sort_switch title="非選択状態(リンクあり)" page=$page_info.all disable=true}
 *  {grn_title_sort_switch title="選択状態(リンクなし)" page=$page_info.all link=false}
 */

function smarty_function_grn_title_sort_switch($params, &$smarty)
{
    // title
    $title = '';
    if (array_key_exists('title', $params)) {
        $title = $params['title'];
        unset($params['title']);
    }

    // page
    $page = '';
    if (array_key_exists('page', $params)) {
        $page = $params['page'];
        unset($params['page']);
    }

    // button class
    $button_class = '';
    if (array_key_exists('class', $params)) {
        $button_class = $params['class'];
        unset($params['class']);
    }

    // state
    $image_class = 'sortdown16.gif';
    if (array_key_exists('reverse', $params)) {
        if ($params['reverse']) {
            $image_class = 'sortup16.gif';
        }
    }

    // disable
    if (array_key_exists('disable', $params)) {
        if ($params['disable']) {
            $image_class = 'sortdown16_n.gif';
        }
        unset($params['disable']);
    }

    // button params
    $button_params = [];
    if (array_key_exists('button_params', $params)) {
        $button_params = $params['button_params'];
        unset($params['button_params']);
    }

    // sort params
    $sort_params = [];
    if (array_key_exists('sort_params', $params)) {
        $sort_params = $params['sort_params'];
        unset($params['sort_params']);
    }

    // button link
    $button_disabled = '';
    if (array_key_exists('button_link', $params)) {
        if ( ! $params['button_link']) {
            $button_disabled = ' disabled';
        }
        unset($params['button_link']);
    }

    // sort link
    $sort_page = cb_pageurl($page, $sort_params);
    if (array_key_exists('sort_link', $params)) {
        if ( ! $params['sort_link']) {
            $sort_disabled = '#';
        }
        unset($params['sort_link']);
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

    return '<input class=\'' . htmlspecialchars($button_class)
           . '\' type=\'button\' value=\'' . htmlspecialchars($title)
           . '\' onClick=\'location.href="' . cb_pageurl($page, $button_params)
           . '"\'' . htmlspecialchars($button_disabled) . '><a href=\''
           . $sort_page . '\' title=\'' . cb_msg('grn.common', 'sort') . '\'>'
           . $img_tag . '</a>';
}

