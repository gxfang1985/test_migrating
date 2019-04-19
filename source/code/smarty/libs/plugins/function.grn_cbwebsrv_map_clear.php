<?php

/**
 *
 * @param string form_name
 * @param string map_tid
 * @param string map_img_tid
 * // option
 * @param string caption
 * @param string map_img_name
 */
function smarty_function_grn_cbwebsrv_map_clear($parameters, &$smarty)
{
    // check license
    require_once('cbwebsrv/tool_define.csp');
    require_once('cbwebsrv/common.csp');
    if ( ! grn_cbwebsrv_is_available_service(GRN_CBWEBSRV_SERVICE_MAP)) {
        return;
    }

    $function_name = "grn_map_clear";

    $form_name = @ $parameters['form_name'];
    if (is_null($form_name) || strlen($form_name) === 0) {
        return htmlspecialchars($function_name)
               . ': missing $form_name parameter';
    }

    $map_img_tid = @ $parameters['map_img_tid'];
    if (is_null($map_img_tid) || strlen($map_img_tid) === 0) {
        return htmlspecialchars($function_name)
               . ': missing $mag_img_tid parameter';
    }

    $map_tid = @ $parameters['map_tid'];
    if (is_null($map_tid) || strlen($map_tid) === 0) {
        return htmlspecialchars($function_name)
               . ': missing $map_tid parameter';
    }

    $caption = @ $parameters['caption'];
    $caption = htmlspecialchars($caption);

    $target_image = 'form.' . $map_img_tid;
    $target_object = 'form.' . $map_tid;

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $image = 'map20.gif';
    if (isset($parameter['map_img_name'])) {
        $image = $parameter['map_img_name'];
    }

    // 出力に関係のある変数をエスケープ
    $image = htmlspecialchars($image);
    $app_path = htmlspecialchars($app_path);
    $form_name = htmlspecialchars($form_name);

    $str = '';
    if (array_key_exists('module', $parameters)
        && strlen($parameters['module']) > 0
        && $parameters['module'] == 'schedule'
    ) {
        $str .= ' <span class="mLeft15 aButtonStandard-grn"><a href="javascript:void(0);" onclick="ClearMapImage();"><span>'
                . $caption . '</span></a></span>';
    } else {
        $str .= '<input type="button" value="' . $caption
                . '" onclick="ClearMapImage();">';
    }

    $script_str
        .= <<< EOD
<script language="JavaScript" type="text/javascript"><!--
        function ClearMapImage()
        {
            var form = document.forms["$form_name"];
            if( form ){
                if( $target_image ){
                    $target_image.src = "{$app_path}/grn/image/cybozu/{$image}";
                }

                if( $target_object ){
                    $target_object.value = "";
                }
            }
        }
//--></script>
EOD;

    return $script_str . $str;
}


