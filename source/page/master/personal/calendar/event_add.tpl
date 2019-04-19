{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/calendar/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-25' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-26' replace='true'}</th>
  <td>{grn_select_date prefix='' date=$date form_name=$form_name}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-27' replace='true'}</th>
  <td>{grn_select name='type' options=$types}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_personal_calendar_GRN_PRS_CA_28'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-28' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_28 necessary=TRUE}</th>
  <td>{capture name='grn_personal_calendar_GRN_PRS_CA_29'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-29' replace='true'}{/capture}{validate form=$form_name field="detail" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_29 append="validation_errors"}{grn_textarea name="detail" value="" cols="70" rows="5"}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_personal_calendar_GRN_PRS_CA_30'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-30' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_30}
  {grn_button_cancel page='personal/calendar/calendar_view' bdate=$date}
  </td>
 </tr>
</table>
</p>
</form>

{include file='grn/personal_footer.tpl'}
