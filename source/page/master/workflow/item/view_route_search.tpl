{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
 {capture name='route_data_container_selector'}.js_route_data_container_{$item.iid}{/capture}
  <td nowrap class="{$item_class} js_customization_input_item_{$item.code} js_route_data_container_{$item.iid}">
 {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {capture name='route_search_route'}item_{$item.iid}_route{/capture}
 {capture name='route_search_fare'}item_{$item.iid}_fare{/capture}
 {if $item.required == 1}
  {assign var='required_mark' value='*'}
  {if $settings.search_type == 0 || $settings.search_type == 1}
   {capture name='grn_workflow_GRN_GR_WKF_IT_504'}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-504' replace='true'}{/capture}{validate form=$form_name field=$smarty.capture.route_search_route criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_GRN_GR_WKF_IT_504 append="validation_errors"}
  {/if}
  {if $settings.search_type == 0 || $settings.search_type == 2}
   {capture name='grn_workflow_GRN_GR_WKF_IT_505'}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-505' replace='true'}{/capture}{validate form=$form_name field=$smarty.capture.route_search_fare criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_GRN_GR_WKF_IT_505 append="validation_errors"}
  {/if}
 {else}
  {assign var='required_mark' value=''}
 {/if}
 {if $settings.search_type == 0}
  {capture name=validate_numeric}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-506' replace='true'}{/capture}
  {validate form=$form_name field=$smarty.capture.route_search_fare criteria="grn_workflow_isNumber" message=$smarty.capture.validate_numeric append="validation_errors" empty=true}
  {grn_text name=$smarty.capture.route_search_route value=$item.text size='35' form_name=$form_name}<span class="attention">{$required_mark}</span>
  {grn_text name=$smarty.capture.route_search_fare value=$item.number size='8' disable_return_key=true}<font color="#0000ff">#</font><span class="attention">{$required_mark}</span>&nbsp;{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-507' replace='true'}
  {capture name='grn_workflow_GRN_GR_WKF_IT_508'}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-508' replace='true'}{/capture}{grn_cbwebsrv_route caption=$smarty.capture.grn_workflow_GRN_GR_WKF_IT_508 route_data_container_selector=$smarty.capture.route_data_container_selector route_name_field=$smarty.capture.route_search_route route_fare_field=$smarty.capture.route_search_fare}
 {elseif $settings.search_type == 1}
  {grn_text name=$smarty.capture.route_search_route value=$item.text size='35' form_name=$form_name}<span class="attention">{$required_mark}</span>
  {capture name='grn_workflow_GRN_GR_WKF_IT_509'}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-509' replace='true'}{/capture}{grn_cbwebsrv_route caption=$smarty.capture.grn_workflow_GRN_GR_WKF_IT_509 route_data_container_selector=$smarty.capture.route_data_container_selector route_name_field=$smarty.capture.route_search_route}
 {elseif $settings.search_type == 2}
  {capture name=validate_numeric}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-510' replace='true'}{/capture}
  {validate form=$form_name field=$smarty.capture.route_search_fare criteria="grn_workflow_isNumber" message=$smarty.capture.validate_numeric append="validation_errors" empty=true}
  {grn_text name=$smarty.capture.route_search_fare value=$item.number size='8' disable_return_key=true}<font color="#0000ff">#</font><span class="attention">{$required_mark}</span>&nbsp;{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-511' replace='true'}
  {capture name='grn_workflow_GRN_GR_WKF_IT_512'}{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-512' replace='true'}{/capture}{grn_cbwebsrv_route caption=$smarty.capture.grn_workflow_GRN_GR_WKF_IT_512 route_data_container_selector=$smarty.capture.route_data_container_selector route_fare_field=$smarty.capture.route_search_fare}
 {/if}
 {if $item.option_string_type == 2}{$item.option_string|escape}<br>{/if}
  </td>
{else}
  <td class="{$item_class}">
 {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {if $settings.search_type == 0}
  <b>{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-513' replace='true'}</b>{$item.text|escape}<br>
  <b>{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-514' replace='true'}</b>{$item.number|escape}&nbsp;{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-515' replace='true'}
 {elseif $settings.search_type == 1}
  <b>{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-516' replace='true'}</b>{$item.text|escape}
 {elseif $settings.search_type == 2}
  <b>{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-517' replace='true'}</b>{$item.number|escape}&nbsp;{cb_msg module='grn.workflow' key='GRN_GR_WKF_IT-518' replace='true'}
 {/if}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{/if}