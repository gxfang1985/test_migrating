{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-27' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='mail/personal/_filter_add.tpl'  button_file='mail/personal/_filter_modify_buttons.tpl'}
<input type="hidden" name="aid" value="{$set.aid}">
<input type="hidden" name="mfid" value="{$filter.mfid}">
</form>
{include file='grn/personal_footer.tpl'}
