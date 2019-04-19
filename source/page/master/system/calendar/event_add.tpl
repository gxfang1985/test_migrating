{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_event_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="scid" value="{$scid}">

<p><div class="explanation">{cb_msg module='grn.system.calendar' key='GRN_SY_CA-7' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-8' replace='true'}</th>
  <td>{grn_select_date prefix='' date=$date form_name=$form_name}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-9' replace='true'}</th>
  <td>{grn_select name='type' options=$types}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_calendar_GRN_SY_CA_10'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-10' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_calendar_GRN_SY_CA_10 necessary=TRUE}</th>
  <td>{capture name='grn_system_calendar_GRN_SY_CA_11'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-11' replace='true'}{/capture}{validate form=$form_name field="detail" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_calendar_GRN_SY_CA_11 append="validation_errors"}{grn_textarea name="detail" value="" cols="50" rows="5"}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_calendar_GRN_SY_CA_12'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-12' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_12}
       {grn_button_cancel page='system/calendar/systemcalendar_list' scid=$scid}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
