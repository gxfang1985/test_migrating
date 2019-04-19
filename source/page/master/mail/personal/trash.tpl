{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-157' replace='true'}</th>
  <td>{capture name='grn_mail_personal_GRN_MAIL_PE_158'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-158' replace='true'}{/capture}{grn_checkbox name='use' id='checkbox_id' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_158 checked=$set.use}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-159' replace='true'}</th>
  <td>{grn_select_numbers select_name=$select1.name options=$select1.options selected=$set.set_day padding='&nbsp;'}&nbsp;{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-160' replace='true'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_mail_personal_GRN_MAIL_PE_161'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-161' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_161}
      {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
