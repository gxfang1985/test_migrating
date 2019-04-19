{assign var="form_name" value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="refresh" value="">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-76' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_portlet_GRN_SCH_PO_77'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-77' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_77}
       {if $display == 'set-system'}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_78'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-78' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_78 page='portal/system/view' pid=$portlet.pid}
       {elseif $display == 'set-operation'}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_79'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-79' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_79 page='portal/operation/view' pid=$portlet.pid}
       {else}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_80'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-80' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_80 page='portal/personal/view' pid=$portlet.pid}
       {/if}
  </td>
 </tr>
</table>

</form>
