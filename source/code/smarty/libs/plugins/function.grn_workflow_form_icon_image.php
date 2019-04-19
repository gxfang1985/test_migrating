<?php
require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @name   grn_image
 *
 *  IMG タグの出力
 *
 * @date    2006/1/20
 * @author  Y.Nakamura
 *
 * @param  string  icon_type       //アイコン種別(0:組み込み/1:URL指定)
 *
 * @option  string  icon_id        //組み込みアイコン番号
 * @option  string  icon_url       //外部アイコンURL
 *
 *  記述例
 *  <pre>{grn_workflow_form_icon_image icon_type='0' icon_id='1' icon_url=''}</pre>
 *  出力例
 *  <pre>&lt;img src="/cbgrn/workflow_form20_1.gif" align="absmiddle"  border="0" alt="組み込みアイコン１"&gt;</pre>
 *
 */
function smarty_function_grn_workflow_form_icon_image($params, &$smarty)
{
    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));

    $function_name = "grn_workflow_form_icon_image";

    //Check Neccesary
    if ( ! array_key_exists('icon_type', $params)) {
        return htmlspecialchars($function_name)
               . ": missing icon_type parameter";
    }
    if ($params['icon_type'] === '' || is_null($params['icon_type'])) {
        return htmlspecialchars($function_name)
               . ": missing icon_type parameter";
    }

    //Check Icon Type
    if ($params['icon_type'] == 0) {
        //Icon Type Embedded
        $suffix = ($params['icon_id'] == 0) ? '' : '_' . $params['icon_id'];
        $image = sprintf('workflow_form20%s.gif', $suffix);
        $alt = cb_msg(GRN_WORKFLOW_MODULE_ID, $image);

        $embedded_params = [];
        $embedded_params['image'] = $image;
        $embedded_params['alt'] = $alt;

        return smarty_function_grn_image($embedded_params, $smarty);
    } else {
        //Icon Type URL
        $url_params = [];
        $url_params['image'] = htmlspecialchars($params['icon_url']);

        return smarty_function_grn_image_raw($url_params, $smarty);
    }
}

