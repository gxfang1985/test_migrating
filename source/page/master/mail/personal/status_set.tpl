{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-144' replace='true'}</th>
  <td>
{if $set.use == '1'}
  {capture name='grn_mail_personal_GRN_MAIL_PE_145'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-145' replace='true'}{/capture}{grn_checkbox name='use' id='checkbox_id' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_145 checked=TRUE}
{else}
  {capture name='grn_mail_personal_GRN_MAIL_PE_146'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-146' replace='true'}{/capture}{grn_checkbox name='use' id='checkbox_id' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_146}
{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_mail_personal_GRN_MAIL_PE_147'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-147' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_147}
      {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
