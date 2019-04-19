<?php
require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @name   grn_image
 *
 *  IMG タグの出力
 *
 * @date   2003/8/26
 * @author HATA,Shinya
 *
 * @param  string  image       イメージファイル名
 *
 * @option string  alt         IMGタグのALT属性
 * @option boolean skip_params パラメータチェック処理をスキップするかどうか
 *
 *  共通のタグオプション（border="0" 等）を出力する。<br>
 *  ブラウザ毎の対応を吸収
 *  <li>align=“absmiddle” border=“0” (for IE, NS6/7)
 *  <li>border=“0” (for NS4) <br>
 *  IMG タグの onClick イベントハンドラに関しては、
 *  Netscape 4.x が対応していないため、 grn_image においてもサポートしない。
 *  代わりに、grn_image_onclick にて実現する。<br>
 *  alt_module および alt_key を alt の代わりに国際化対応のために利用できる。<br>
 *  デフォルトではIMGタグのSRC属性に common.ini の Global セクションの app_path の値
 *  （例では '/cbfw'）を先頭に付加する（例：image='write20.gif' だと
 *  &lt;img src="/cbfw/write20.gif" ...&gt; となる）
 *
 *  記述例
 *  <pre>{grn_image image='write20.gif' alt='登録する'}</pre>
 *  出力例
 *  <pre>&lt;img src="/cbfw/write20.gif" align="absmiddle"  border="0" alt="登録する"&gt;</pre>
 *
 * @date   2005/1/13
 * @author K.Tokuta
 */
function smarty_function_grn_image($params, &$smarty)
{
    $function_name = "grn_image";

    $params = grn_ui_image_params($params, $function_name, $smarty);

//    $browser = cb_ui_get_browser();

    $app_path = cb_get_app_path();

    $image = $params['image'];

    $alt = null;
    if (isset($params['alt'])) {
        $alt = $params['alt'];
    }

    $direct = null;
    if (isset($params['direct'])) {
        $direct = $params['direct'];
    }

    if ( ! $direct) {
        $image = "{$app_path}/grn/image/cybozu/{$image}";
    } else {
        require_once('grn/controller.csp');
        $image = grn_safe_url($params['image']);
    }
    $params['image'] = $image;
    $params['skip_params'] = true;

    static $include_grn_image_raw = false;
    if ($include_grn_image_raw === false) {
        require_once $smarty->_get_plugin_filepath('function', 'grn_image_raw');
        $include_grn_image_raw = true;
    }

    return smarty_function_grn_image_raw($params, $smarty);
}

