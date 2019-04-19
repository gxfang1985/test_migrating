{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='order[]' options=$mailaccounts}
  <!----->
 </div><!--action_end--->
</div>
<p>
 <input class="margin" type="submit" value="{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-252' replace='true'}" onclick="grn_onsubmit_common(this.form);">
 {grn_button_cancel page='mail/personal/account_list'}
</p>
</form>
{include file='grn/personal_footer.tpl'}
