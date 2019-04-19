{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-386' replace='true'}</div></p>
{include file="grn/show_validation_errors.tpl"}
 {include file='mail/system/_user_account_add.tpl' button_file='mail/system/_user_account_modify_buttons.tpl' system_page=true}
<input type="hidden" name="aid" value="{$aid}">
</form>
{include file='grn/system_footer.tpl'}
