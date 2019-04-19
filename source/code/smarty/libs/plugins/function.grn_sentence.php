<?php
require_once('grn/ui.csp');

/**
 * @name   grn_sentence
 *  イメージ付キャプションの出力
 *
 * @date   2005/2/9
 * @author KAMBE,Shinichi
 * @option string  caption           キャプション
 * @option integer truncated_caption キャプションをtruncateする文字数
 * @option string  caption_module    キャプションモジュール
 * @option string  caption_key       キャプションキー
 * @option string  fragment          flagment
 * @option string  postfix           postfix
 * @option string  class             class名
 * @option string  image             イメージファイル名
 * @option string  alt               IMAGEタグのALT属性
 * @option array   params            その他のパラメータ
 *
 * @date   2005/2/18
 * @author SHIMADA Kunihiko
 */

function smarty_function_grn_sentence($params, &$smarty)
{
    $function_name = "grn_sentence";

    $params = grn_ui_link_params($params, $function_name, $smarty);

    //--get parames
    $fragment = @ $params['fragment'];
    $postfix = @ $params['postfix'];

    $params['_image_direct'] = false;
    $params['skip_params'] = true;

    require_once($smarty->_get_plugin_filepath('function', 'grn_sentence_raw'));

    return smarty_function_grn_sentence_raw($params, $smarty);
}

