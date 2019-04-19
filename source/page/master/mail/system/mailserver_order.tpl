{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='order[]' options=$mailservers}
  <!----->
 </div>
</div>
<p>
 {capture name='grn_mail_system_GRN_MAIL_SY_119'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-119' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_119 onclick='grn_onsubmit_common(this.form);'}
 {grn_button_cancel page='mail/system/mailserver'}
</p>
</form>
{include file='grn/system_footer.tpl'}
