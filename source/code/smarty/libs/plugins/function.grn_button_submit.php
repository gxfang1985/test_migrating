<?php

/**
 * @name grn_button_submit
 *
 * @description サブミットボタン
 *
 * @date        2004/10/30
 * @author      KAMBE,Shinichi
 * @option      string   caption    リンクキャプション
 * @option      string   page       画面名
 * @option      string   class      クラス
 * @option      string   onclick    submit前に実行する動作
 * @option      boolean  disabled   禁止状態
 * @option      string   button_type  INPUTタイプ
 * @option      string   style      スタイル
 *
 * @date        2004/11/29
 * @author      I.okahashi
 *
 * @date        2005/1/20
 * @author      K.Tokuta
 *
 */

function smarty_function_grn_button_submit($params, &$smarty)
{
    $function_name = 'grn_button_submit';

    // caption
    $caption = @ $params['caption'];
    unset($params['caption']);

    // class
    $class = @ $params['class'];
    unset($params['class']);

    // onclick
    $onclick = @ $params['onclick'];
    unset($params['onclick']);

    // disabled
    $disabled = (@ $params['disabled']) ? ' disabled' : '';
    unset($params['disabled']);

    // disabled
    $type = (@ $params['button_type']) ? $params['button_type'] : 'button';
    unset($params['button_type']);

    // disabled
    $style = (@ $params['style']) ? $params['style'] : '';
    unset($params['style']);

    if ($type != 'submit' && $type != 'button') {
        return htmlspecialchars($function_name) . ": invalid type ("
               . htmlspecialchars($type) . ")";
    }

    $location = null;

    // page
    if (array_key_exists('page', $params)) {
        $page = $params['page'];
        unset($params['page']);
        // cb_pageurlは内部でhtmlspecialcharsを実行している。
        $location = 'location.href=\'' . cb_pageurl($page, $params) . '\';';
    } elseif ($type != 'submit') {
        $location = 'submit(this.form)';
    }

    //insert id for button
    $id = '';
    if (array_key_exists('id', $params)) {
        $id = 'id="' . htmlspecialchars($params['id']) . '"';
    }

    if (is_null($location)) {
        if (strlen($onclick)) {
            $return_string
                = sprintf('<input class="%s" type="%s" value="%s" onClick="%s" style="%s" %s %s>',
                htmlspecialchars($class),
                htmlspecialchars($type),
                htmlspecialchars($caption),
                htmlspecialchars($onclick),
                htmlspecialchars($style),
                htmlspecialchars($disabled),
                $id);
        } else {
            $return_string
                = sprintf('<input class="%s" type="%s" value="%s" style="%s" %s %s>',
                htmlspecialchars($class),
                htmlspecialchars($type),
                htmlspecialchars($caption),
                htmlspecialchars($style),
                htmlspecialchars($disabled),
                $id);
        }
    } else {
        $return_string
            = sprintf('<input class="%s" type="%s" value="%s" onClick="%s%s" style="%s" %s %s>',
            htmlspecialchars($class),
            htmlspecialchars($type),
            htmlspecialchars($caption),
            htmlspecialchars($onclick),
            $location,
            htmlspecialchars($style),
            htmlspecialchars($disabled),
            $id);
    }

    return $return_string;
}

