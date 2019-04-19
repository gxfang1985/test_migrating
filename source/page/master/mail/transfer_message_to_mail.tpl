{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{*{grn_title title=$page_title class=$page_info.parts[0]}*}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='grn/_ajax_submit_check_error.tpl'}
{include file="mail/_send.tpl" button_file="mail/_send_buttons.tpl"}
</form>
{include file="grn/footer.tpl"}
