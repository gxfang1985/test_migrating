{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/_ajax_submit_check_error.tpl'}
{grn_load_javascript file="grn/html/wm.js"}
<div class="mainarea-mail">
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_preview'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="mail/_preview.tpl" button_file="mail/_preview_buttons.tpl" submit_page='mail/command_preview'}
<input type="hidden" name="baid" value="{$baid}">
<input type="hidden" name="bcid" value="{$bcid}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="tmpid" value="{$mail.mid}">
<input type="hidden" name="signid" value="{$signid}">
<input type="hidden" name="draft_id" value="{$draft_id}">
<input type="hidden" name="sign_position" value="{$sign_position}">
<input type="hidden" name="data" value="{$mail.data}">
<input type="hidden" name="data_plain_text" value="{$mail.data_plain_text}">
<input type="hidden" name="action" value="{$action}">
</form>
</div>
{include file="grn/footer.tpl"}
