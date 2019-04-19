<?php
require_once('grn/ui.csp');

/**
 * @name   grn_link
 *  イメージ付リンクの出力
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 * @option string  caption           リンクキャプション
 * @option integer truncated_caption キャプションをtruncateする文字数
 * @option string  caption_module    キャプションモジュール
 * @option string  caption_key       キャプションキー
 *
 * @param  string  page              画面名
 *
 * @option string  script            JavaScript
 * @option string  fragment          flagment
 * @option string  postfix           postfix
 * @option string  class             class名
 * @option string  image             イメージファイル名
 * @option boolean image_direct      外部イメージファイルか否か
 * @option string  alt               IMAGEタグのALT属性
 * @option string  target            AタグのTARGET属性
 * @option string  title             AタグのTITLE属性
 * @option boolean disabled          無効化するかどうか
 * @option boolean unread            未読かどうか
 * @option boolean br                改行するかどうか
 * @option string  element_id        AタグのID属性
 * @option array   params            その他のパラメータ
 *
 * @date   2005/1/13
 * @author K.Tokuta
 */

function smarty_function_grn_link($params, &$smarty)
{
    $function_name = 'grn_link';

    $params = grn_ui_link_params($params, $function_name, $smarty);

    //--get parames
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

    if (array_key_exists('url_params', $params)) {
        $url_params = (array)$params['url_params'];
    } else {
        $url_params = [];
    }

    if (array_key_exists('page_direct', $params)) {
        $page_direct = $params['page_direct'];
    } else {
        $page_direct = false;
    }

    if ( ! $page_direct) {
        unset($url_params['page_direct']);
        $page = cb_pageurl($page, $url_params, $fragment, $postfix);
        $params['page'] = $page;
    }

    $params['skip_params'] = true;

    static $include_grn_link_raw = false;
    if ($include_grn_link_raw === false) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_link_raw'));
        $include_grn_link_raw = true;
    }

    return smarty_function_grn_link_raw($params, $smarty);
}

