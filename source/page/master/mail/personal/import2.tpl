{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-129' replace='true'}</th>
  <td>{grn_sentence caption=$set.account image='mailaccount20.gif'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-130' replace='true'}</th>
  <td>{grn_mail_get_folder_name folder_id=$set.cid}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-131' replace='true'}</th>
  <td>{if $set.format eq 'eml'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-132' replace='true'}{else}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-135' replace='true'}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-136' replace='true'}</th>
  <td>{grn_format_filesize size=$set.size unit='KB'}</td>
 </tr>
</table>

<p>
<div class="explanation">
    {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-137' replace='true'}<span class="bold">{$set.filename|escape}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-139' replace='true'}<br>
    {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-141' replace='true'}
</div>

    {capture name='grn_mail_personal_GRN_MAIL_PE_142'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-142' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_142 onclick="cmd.value='yes';"}
    {capture name='grn_mail_personal_GRN_MAIL_PE_143'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-143' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_143 onclick="cmd.value='no';"}

<input type="hidden" name="cmd">
<input type="hidden" name="aid" value="{$set.aid}">
<input type="hidden" name="cid" value="{$set.cid}">
<input type="hidden" name="file" value="{$set.file}">
<input type="hidden" name="format" value="{$set.format}">
</form>
{include file='grn/personal_footer.tpl'}
