{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file='grn/html/wm.js'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p></p>
    <div class="explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-284' replace='true'}</div>
    <p></p>
    {include file="grn/show_validation_errors.tpl"}
    {include file='mail/personal/_account_add.tpl' button_file='mail/personal/_account_add_buttons.tpl'}
</form>
{include file='grn/personal_footer.tpl'}
