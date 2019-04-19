{assign var='form_name' value='weather'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if $disabled_services.weather}
{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-26' replace='true'}
{else}
<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-27' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 {capture name='message_nodata_found'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-71' replace='true'}{/capture}
 {capture name='message_service_disabled'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-70' replace='true'}{/capture}
 {include file='grn/_calendar_extension_modify_six_kinds_of_day.tpl' type='six_kinds_of_day' field_name='six_kinds_of_day'
 checked=$six_kinds_of_day disable=$disabled_services.six_kinds_of_day is_event_receive=$is_received_six_kind_of_days_data
 message_nodata=$smarty.capture.message_nodata_found message_disabled=$smarty.capture.message_service_disabled}
 {include file='grn/_calendar_extension_modify_weather.tpl' location_list=$location_list message_nodata=$smarty.capture.message_nodata_found}

 <tr>
  <td></td>
  <td>
       {capture name='grn_cbwebsrv_portlet_GRN_WBS_PO_36'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-36' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cbwebsrv_portlet_GRN_WBS_PO_36}
 {if $display == 'set-system'}
       {capture name='grn_cbwebsrv_portlet_GRN_WBS_PO_37'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-37' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cbwebsrv_portlet_GRN_WBS_PO_37 page='portal/system/view' pid=$portlet.pid}
 {elseif $display == 'set-operation'}
       {capture name='grn_cbwebsrv_portlet_GRN_WBS_PO_38'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-38' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cbwebsrv_portlet_GRN_WBS_PO_38 page='portal/operation/view' pid=$portlet.pid}
 {else}
       {capture name='grn_cbwebsrv_portlet_GRN_WBS_PO_39'}{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-39' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cbwebsrv_portlet_GRN_WBS_PO_39 page='portal/personal/view' pid=$portlet.pid}
 {/if}
  </td>
 </tr>
</table>
{/if}

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
