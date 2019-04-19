{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/calendar/command_event_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-51' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-52' replace='true'}</th>
  <td>{grn_select_date prefix='' date=$calendar.event.date form_name=$form_name}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-53' replace='true'}</th>
  <td>{grn_select name='type' options=$calendar.event.types}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_personal_calendar_GRN_PRS_CA_54'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-54' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_54 necessary=TRUE}</th>
  <td>{capture name='grn_personal_calendar_GRN_PRS_CA_55'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-55' replace='true'}{/capture}{validate form=$form_name field="detail" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_55 append="validation_errors"}{grn_textarea name="detail" value=$calendar.event.detail cols="70" rows="5"}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_personal_calendar_GRN_PRS_CA_56'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-56' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_56}
  {grn_button_cancel page='personal/calendar/event_view' event=$calendar.event.id}
  </td>
 </tr>
</table>
</p>
<input type="hidden" name="event" value="{$calendar.event.id}">
</form>

{include file='grn/personal_footer.tpl'}
