{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.notification.personal' key='GRN_NTFC_PE-1' replace='true'} 
{cb_msg module='grn.notification.personal' key='GRN_NTFC_PE-2' replace='true'} 
</div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.notification.personal' key='GRN_NTFC_PE-3' replace='true'}</th>
  <td>{capture name='grn_notification_personal_GRN_NTFC_PE_4'}{cb_msg module='grn.notification.personal' key='GRN_NTFC_PE-4' replace='true'}{/capture}{grn_checkbox name='not_use' id='not_use' value='1' checked=$not_use caption=$smarty.capture.grn_notification_personal_GRN_NTFC_PE_4}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_notification_personal_GRN_NTFC_PE_5'}{cb_msg module='grn.notification.personal' key='GRN_NTFC_PE-5' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_personal_GRN_NTFC_PE_5}
  {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
