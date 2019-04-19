<?php
require_once 'fw/ui.csp';

/**
 * @name   grn_path_link
 *  イメージ付リンクの出力
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 *
 * @param  string  caption         リンクキャプション
 * @param  integer truncated_caption キャプションをtruncateする文字数
 * @param  string  caption_module  キャプションモジュール
 * @param  string  caption_key     キャプションキー
 * @param  string  page            画面名
 * @param  string  fragment        URLフラグメント
 * @param  string  script          JavaScript
 * @param  string  class           イメージファイル名
 *
 * @option string  target          AタグのTARGET属性
 * @option boolean disabled        無効化するかどうか
 * @option boolean focus           選択状態かどうか
 * @option boolean unread          未読かどうか
 * @date   2004/12/22 追加変更(Okahashi)
 * @option string  setup           購読かどうか
 * @option string  unread_num      未読数
 * @option string  all_num         総数
 *
 */

function smarty_function_grn_path_link($params, &$smarty)
{
    //-- create url parameters for cb_pageurl
    $url_params = $params;
    unset($url_params['caption']);
    unset($url_params['truncated_caption']);
    unset($url_params['caption_module']);
    unset($url_params['caption_key']);
    unset($url_params['page']);
    unset($url_params['fragment']);
    unset($url_params['postfix']);
    unset($url_params['class']);
    unset($url_params['target']);
    unset($url_params['disabled']);
    unset($url_params['focus']);
    unset($url_params['unread']);
    unset($url_params['setup']);
    unset($url_params['unread_num']);
    unset($url_params['all_num']);
    unset($url_params['script']);

    //--get parames
    // is_truncated_caption
    $truncated_caption = (int)$params['truncated_caption'];
    // caption
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
        if ($truncated_caption) {
            $caption = mb_strimwidth($caption, 0, $truncated_caption, '...');
        }
        $caption = htmlspecialchars($caption);
    } else {
        $caption_module = $params['caption_module'];
        $caption_key = $params['caption_key'];
        $caption = cb_msg($caption_module, $caption_key);
    }
    // page
    $page = $params['page'];
    $fragment = @$params['fragment'];
    $postfix = @ $params['postfix'];
    $script = @$params['script'];
    // class
    $class = @ $params['class'];
    // target
    $target = @ $params['target'];
    $target_area = $target ? (' target="' . htmlspecialchars($target) . '"')
        : '';
    // disabled
    $disabled = @ $params['disabled'];
    // focus
    $focus = (boolean)@ $params['focus'];
    // unread
    $unread = @ $params['unread'];
    // setup
    if ($params['setup']) {
        $setup = '*';
    }
    // unread_num
    $unread_num = @ $params['unread_num'];
    // all_num
    $all_num = @ $params['all_num'];

    if ($disabled) {
        return '<div><a class="' . htmlspecialchars($class) . '" name="#">'
               . $caption . htmlspecialchars($setup) . '</a>&nbsp;</div>';
    } else {
        $pageurl = $script ? htmlspecialchars($script)
            : cb_pageurl($page, $url_params, $fragment, $postfix);

        if ( ! is_null($unread_num) && ! is_null($all_num) && $all_num > 0) {
            if ($focus) {
                return '<a class="' . htmlspecialchars($class) . '" href="'
                       . $pageurl . '"' . $target_area . '>' . $caption
                       . htmlspecialchars($setup) . '</a>';
            } else {
                if ($unread) {
                    return '<a class="' . htmlspecialchars($class) . '" href="'
                           . $pageurl . '"' . $target_area
                           . '><span class="bold">' . $caption
                           . htmlspecialchars($setup) . '</span></a>';
                } else {
                    return '<a class="' . htmlspecialchars($class) . '" href="'
                           . $pageurl . '"' . $target_area . '>' . $caption
                           . htmlspecialchars($setup) . '</a>';
                }
            }
        } else {

            if ($focus) {
                return '<a class="' . htmlspecialchars($class) . '" href="'
                       . $pageurl . '"' . $target_area . '>' . $caption
                       . htmlspecialchars($setup) . '</a>';
            } else {
                if ($unread) {
                    return '<a class="' . htmlspecialchars($class) . '" href="'
                           . $pageurl . '"' . $target_area
                           . '><span class="bold">' . $caption
                           . htmlspecialchars($setup) . '</span></a>';
                } else {
                    return '<a class="' . htmlspecialchars($class) . '" href="'
                           . $pageurl . '"' . $target_area . '>' . $caption
                           . htmlspecialchars($setup) . '</a>';
                }
            }
        }
    }
}

