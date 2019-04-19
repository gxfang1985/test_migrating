<?php
/**
 * @name grn_change_order
 * 順番変更リストボックス
 *
 * @date   2004/10/26
 * @author M.Oomori
 *
 * @param options an array of numbers
 * @param selected initially selected option
 * @param pudding left-side pudding in front of a number
 *
 * Example;
 * {grn_select_numbers options=$numbers_on_onepage selected=10 pudding='&nbsp;'}
 */

function smarty_function_grn_change_order($parameters, &$smarty)
{
    //// under implementation

    $function_name = "grn_change_order";

    $form_name = htmlspecialchars($parameters['form_name']);
    if ($form_name == "") {
        return htmlspecialchars($function_name) . ": form_name is empty";
    }
    $select_name = htmlspecialchars($parameters['select_name']);
    if ($select_name == "") {
        return htmlspecialchars($function_name) . ": select_name is empty";
    }
    $options = $parameters['options'];
    if ( ! is_array($options)) {
        return htmlspecialchars($function_name) . ": options is not valid";
    }

    global $G_config_common;
    $wwwroot = $G_config_common->get('Global', 'app_path');
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    $msg_guide = cb_msg('fw.ui', 'change_order_guide');
    $return_string
        = <<<EOD
<p>
<img src="$wwwroot/grn/image/cybozu/order_top20.gif?$build_date" border="0" align="absmiddle">
<img src="$wwwroot/grn/image/cybozu/order_up20.gif?$build_date" border="0" align="absmiddle">
<img src="$wwwroot/grn/image/cybozu/order_down20.gif?$build_date" border="0" align="absmiddle">
<img src="$wwwroot/grn/image/cybozu/order_bottom20.gif?$build_date" border="0" align="absmiddle">
$msg_guide
</p>
<table>
 <tr>
  <td>
    <img src="$wwwroot/grn/image/cybozu/order_top20.gif?$build_date" border="0" align="absmiddle" onclick="OrderTop('$form_name', '$select_name')"><br><br>
   <img src="$wwwroot/grn/image/cybozu/order_up20.gif?$build_date" border="0" align="absmiddle" onclick="OrderUp('$form_name', '$select_name')"><br><br>
   <img src="$wwwroot/grn/image/cybozu/order_down20.gif?$build_date" border="0" align="absmiddle" onclick="OrderDown('$form_name', '$select_name')"><br><br>
   <img src="$wwwroot/grn/image/cybozu/order_bottom20.gif?$build_date" border="0" align="absmiddle" onclick="OrderBottom('$form_name', '$select_name')">
  </td>
  <td>
   <select name="$select_name" size="10" multiple>
EOD;

    foreach ($options as $key => $option) {
        $return_string .= "<option value='" . htmlspecialchars($key) . "'>"
                          . htmlspecialchars($option) . "\n";
    }

    $return_string
        .= <<<EOD
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
  </td>
 </tr>
</table>        
EOD;

    return $return_string;
}
