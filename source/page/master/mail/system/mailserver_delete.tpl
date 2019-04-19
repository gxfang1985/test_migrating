{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-434' replace='true'}<span class="bold">{grn_sentence image='mailserver20.gif' caption=$set.title}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-435' replace='true'}
 </p>
 <p>
  {capture name='grn_mail_system_GRN_MAIL_SY_436'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-436' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_436}
  {capture name='grn_mail_system_GRN_MAIL_SY_437'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-437' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_437 page='mail/system/mailserver_view' msid=$set.msid}
 </p>
<input type="hidden" name="msid" value="{$set.msid}">
</form>
{include file='grn/system_footer.tpl'}
