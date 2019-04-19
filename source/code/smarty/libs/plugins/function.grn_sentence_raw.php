<?php
require_once('grn/ui.csp');

/**
 * @name   grn_sentence_raw
 *  イメージ付(外部)キャプションの出力
 *
 * @date   2005/2/9
 * @author KAMBE,Shinichi
 * @option string  caption           リンクキャプション
 * @option integer truncated_caption キャプションをtruncateする文字数
 * @option string  caption_module    キャプションモジュール
 * @option string  caption_key       キャプションキー
 * @option string  fragment          flagment
 * @option string  postfix           postfix
 * @option string  class             class名
 * @option string  image             イメージファイル名
 * @option string  alt               IMAGEタグのALT属性
 * @option array   params            その他のパラメータ
 * @option boolean skip_params       パラメータチェック処理をスキップするかどうか
 *
 * @date   2005/2/18
 * @author SHIMADA Kunihiko
 */

function smarty_function_grn_sentence_raw($params, &$smarty)
{
    $function_name = "grn_sentence_raw";

    $skip_params = false;
    if (@ $params['skip_params'] === true) {
        $skip_params = true;
    }

    if ( ! $skip_params) {
        $params = grn_ui_link_params($params, $function_name, $smarty);
    }

    //--get parames
    $caption = $params['caption'];
    $class = @ $params['class'];
    $image = @ $params['image'];
    $image_direct = @ $params['_image_direct'];
    $alt = @ $params['alt'];

    if (is_null($image_direct)) {
        $image_direct = true;
    }

    $return_string = '';
    $img_tag = '';
    if ($image) {
        $image_params = ['image' => $image, 'alt' => $alt];
        if ($image_direct) {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_image_raw'));
            $img_tag = smarty_function_grn_image_raw($image_params, $smarty);
        } else {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_image'));
            $img_tag = smarty_function_grn_image($image_params, $smarty);
        }
    }

    $return_string .= '<span class="' . htmlspecialchars($class) . '">'
                      . $img_tag . $caption . '</span>';

    return $return_string;

}

