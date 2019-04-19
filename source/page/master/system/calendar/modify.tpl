{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_calendar_GRN_SY_CA_1'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_calendar_GRN_SY_CA_1 necessary=TRUE}</th>
  <td>{capture name='grn_system_calendar_GRN_SY_CA_2'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-2' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_system_calendar_GRN_SY_CA_2 append="validation_errors"}{grn_text necessary=true name="title" value=$calendar.title size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_calendar_calendar_code'}{cb_msg module='grn.system.calendar' key='calendar_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_calendar_calendar_code necessary=TRUE}</th>
  <td>{capture name='grn_system_calendar_require_code'}{cb_msg module='grn.system.calendar' key='require_code' replace='true'}{/capture}{validate form=$form_name field="code" criteria="notEmpty" message=$smarty.capture.grn_system_calendar_require_code append="validation_errors"}{grn_text necessary=true name="code" value=$calendar.code size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_calendar_GRN_SY_CA_3'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-3' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_3}
       {grn_button_cancel page='system/calendar/view' scid=$calendar.id}
  </td>
 </tr>
</table>

<input type="hidden" name="scid" value="{$calendar.id}">
</form>

{include file='grn/system_footer.tpl'}
