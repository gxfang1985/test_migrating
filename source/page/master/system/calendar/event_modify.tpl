{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_event_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="event" value="{$calendar.event.id}">

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-65' replace='true'}</th>
  <td>{grn_select_date prefix='' date=$calendar.event.date form_name=$form_name}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-66' replace='true'}</th>
  <td>{grn_select name='type' options=$calendar.event.types}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_calendar_GRN_SY_CA_67'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-67' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_calendar_GRN_SY_CA_67 necessary=TRUE}</th>
  <td>{capture name='grn_system_calendar_GRN_SY_CA_68'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-68' replace='true'}{/capture}{validate form=$form_name field="detail" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_calendar_GRN_SY_CA_68 append="validation_errors"}{grn_textarea name="detail" value=$calendar.event.detail rows="5"}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_calendar_GRN_SY_CA_69'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-69' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_69}
       {grn_button_cancel page='system/calendar/event_view' event=$calendar.event.id scid=$calendar.id}
  </td>
 </tr>
</table>

<input type="hidden" name="scid" value="{$calendar.id}">
</form>

{include file='grn/system_footer.tpl'}
