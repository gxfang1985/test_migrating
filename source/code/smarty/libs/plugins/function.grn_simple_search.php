<?php

/**
 * @name   grn_simple_search
 *  簡易検索フォームの出力
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 *
 * @param  string  caption     ボタンキャプション
 * @param  string  action      ACTION先
 * @param  string  form_target FORMタグのTARGET属性
 * @param  string  name        INPUTタグのNAME属性
 * @param  string  page        詳細検索画面名
 * @param  string  a_target    AタグのTARGET属性
 * @param  bool    detail_search   詳細検索の有無
 * @param  bool    disabled    検索の禁止
 *
 */

function smarty_function_grn_simple_search($params, &$smarty)
{
    // caption
    if (array_key_exists('caption', $params)) {
        $caption = htmlspecialchars($params['caption']);
    }
    unset($params['caption']);

    // action
    $action = $params['action'];
    unset($params['action']);

    // form_target
    if (array_key_exists('form_target', $params)) {
        $form_target = $params['form_target'];
    } else {
        $form_target = null;
    }
    $form_target_area = $form_target ? (' target="'
                                        . htmlspecialchars($form_target) . '"')
        : '';
    unset($params['form_target']);

    if (array_key_exists('name', $params)) {
        $name = $params['name'];
    } else {
        $name = null;
    }
    unset($params['name']);

    // page
    $page = $params['page'];
    unset($params['page']);

    $detail_search = true;
    if (isset($params['detail_search']) && ! (bool)$params['detail_search']) {
        $detail_search = false;
    }
    unset($params['detail_search']);

    // a_target
    if (array_key_exists('a_target', $params)) {
        $a_target = $params['a_target'];
    } else {
        $a_target = null;
    }
    $a_target_area = $a_target ? (' target="' . $a_target . '"') : '';
    unset($params['a_target']);

    $form = '<div class="search_navi"><form name="search" action="'
            . cb_pageurl($action) . '"' . $form_target_area . '>';
    foreach ($params as $hidden_name => $hidden_value) {
        $form .= '<input type="hidden" name="' . htmlspecialchars($hidden_name)
                 . '" value="' . htmlspecialchars($hidden_value) . '">';
    }

    // disabled
    $disabled = (@ $params['disabled']) ? ' disabled' : '';
    unset($params['disabled']);

    $detail = '';
    if ($detail_search) {
        $msg = cb_msg('grn.common', 'simple_search_detail');
        if ($disabled == ' disabled') {
            $detail = '<font size="-1"><span name="#">' . $msg
                      . '</span></font>&nbsp;';
        } else {
            $detail = '<font size="-1"><a href="' . cb_pageurl($action, $params)
                      . '" ' . htmlspecialchars($disabled) . '>' . $msg
                      . '</a></font>&nbsp;';
        }
    }

    return $form . '<input type="text" name="' . htmlspecialchars($name)
           . '" size="20" maxlength="100" ' . htmlspecialchars($disabled)
           . '>&nbsp;<input class="small" type="submit" value="' . $caption
           . "\" " . htmlspecialchars($disabled)
           . ">&nbsp;{$detail}</form></div>";
}

