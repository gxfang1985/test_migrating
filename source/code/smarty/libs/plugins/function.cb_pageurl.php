<?php
/**
 *  Smarty関数版 cb_paeurl
 *
 * @author HATA,Shinya
 * @date   2003/8/21
 *
 * @param  string  page        スクリプト名
 *
 * @option string  fragment    URLの#以降の内容
 * @option string  postfix     スクリプト名の後の /-/ に続けて記述する内容
 * @option mixed   (var)       URL引数
 */
function smarty_function_cb_pageurl($params, &$smarty)
{
    $page = $params['page'];

    if (array_key_exists('fragment', $params)) {
        $fragment = $params['fragment'];
    } else {
        $fragment = null;
    }

    if (array_key_exists('postfix', $params)) {
        $postfix = $params['postfix'];
    } else {
        $postfix = null;
    }

    unset($params['page'], $params['fragment'], $params['postfix']);

    return cb_pageurl($page, $params, $fragment, $postfix);
}

