{assign var="form_name" value="notification"}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<br>
<div class="sub_title">{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-51' replace='true'}</div>

<p>
<img src="{$app_path}/grn/image/cybozu/order_top20.gif?{$build_date}" border="0" align="absmiddle">
<img src="{$app_path}/grn/image/cybozu/order_up20.gif?{$build_date}" border="0" align="absmiddle">
<img src="{$app_path}/grn/image/cybozu/order_down20.gif?{$build_date}" border="0" align="absmiddle">
<img src="{$app_path}/grn/image/cybozu/order_bottom20.gif?{$build_date}" border="0" align="absmiddle">
{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-52' replace='true'}
</p>
<table>
 <tr>
  <td>
    <img src="{$app_path}/grn/image/cybozu/order_top20.gif?{$build_date}" border="0" align="absmiddle" onclick="OrderTop('{$form_name}', 'list[]')"><br><br>
   <img src="{$app_path}/grn/image/cybozu/order_up20.gif?{$build_date}" border="0" align="absmiddle" onclick="OrderUp('{$form_name}', 'list[]')"><br><br>
   <img src="{$app_path}/grn/image/cybozu/order_down20.gif?{$build_date}" border="0" align="absmiddle" onclick="OrderDown('{$form_name}', 'list[]')"><br><br>
   <img src="{$app_path}/grn/image/cybozu/order_bottom20.gif?{$build_date}" border="0" align="absmiddle" onclick="OrderBottom('{$form_name}', 'list[]')">
  </td>
  <td>
   <select name="list[]" size="10" multiple>

{foreach from=$apps_list_for_display key=module_id item=app_name}
    <option value='{$module_id}'>{$app_name}</option>
{/foreach}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
  </td>
 </tr>
</table>

<table class="std_form">
 <tr>
  <td colspan="2"><br>
   <div class="sub_title">{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-1' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-2' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-3' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-4' replace='true'}
{if $common_settings.display_item.abstract}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_5'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-5' replace='true'}{/capture}{grn_checkbox name="abstract" id="abstract" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_5}
{else}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_6'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-6' replace='true'}{/capture}{grn_checkbox name="abstract" id="abstract" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_6}
{/if}
{if $common_settings.display_item.sender_name}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_7'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-7' replace='true'}{/capture}{grn_checkbox name="sender_name" id="sender_name" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_7}
{else}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_8'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-8' replace='true'}{/capture}{grn_checkbox name="sender_name" id="sender_name" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_8}
{/if}
{if $common_settings.display_item.timestamp}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_9'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-9' replace='true'}{/capture}{grn_checkbox name="timestamp" id="timestamp" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_9}
{else}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_10'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-10' replace='true'}{/capture}{grn_checkbox name="timestamp" id="timestamp" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_10}
{/if}
  </td>
 </tr>

{foreach from=$module_settings item=setting key=module_id name=module_settings}
 <tr>
  <td colspan="2"><br>
   <div class="sub_title">{$setting.name|escape}</div>
  </tr>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-11' replace='true'}
  </th>
  <td>
 {if $setting.system_display_type}
  {if $setting.system_display_type !== 'number' }
       {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-12' replace='true'}<br>
  {else}
       {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-13' replace='true'}<br>
  {/if}
       <input type="hidden" name="display_type_{$setting.html_escaped_id}" value="{$setting.display_type}">
       <span class="attention">{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-14' replace='true'}</span>
 {else}
  {if $setting.display_type !== 'number' }
       {capture name='grn_notification_portlet_GRN_NTFC_PO_15'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-15' replace='true'}{/capture}{grn_radio name="display_type_`$setting.html_escaped_id`" id="`$setting.html_escaped_id`_0" value="index" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_15 checked=true}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_16'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-16' replace='true'}{/capture}{grn_radio name="display_type_`$setting.html_escaped_id`" id="`$setting.html_escaped_id`_1" value="number" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_16}
  {else}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_17'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-17' replace='true'}{/capture}{grn_radio name="display_type_`$setting.html_escaped_id`" id="`$setting.html_escaped_id`_0" value="index" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_17}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_18'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-18' replace='true'}{/capture}{grn_radio name="display_type_`$setting.html_escaped_id`" id="`$setting.html_escaped_id`_1" value="number" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_18 checked=true}
  {/if}
 {/if}
  </td>
 </tr>
 {if ! $setting.system_display_type || $setting.system_display_type !== 'number' }
 <tr>
  <th nowrap>
      {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-19' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name="rows_`$setting.html_escaped_id`" padding='&nbsp;' options=$rows_numbers selected=$setting.rows}
 {else}
    <input type="hidden" name="rows_{$setting.html_escaped_id}" value="{$setting.rows}">
 {/if}
  </td>
 </tr>

{/foreach}

 <tr>
  <td></td>
  <td>
       {capture name='grn_notification_portlet_GRN_NTFC_PO_20'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-20' replace='true'}{/capture}{grn_button_submit class="margin" onclick="grn_onsubmit_common(this.form);" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_20}
{if $display == 'set-system'}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_21'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-21' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_21 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_22'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-22' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_22 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_notification_portlet_GRN_NTFC_PO_23'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-23' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_23 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid"     value="{$portlet.pid}">
<input type="hidden" name="plid"    value="{$portlet.plid}">
<input type="hidden" name="ppid"    value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
