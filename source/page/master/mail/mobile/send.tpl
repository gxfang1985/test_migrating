{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='form_name' value=$smarty.template|basename}
{include file="mail/mobile/_mobile_mail_head.tpl" isNormal="1"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/mobile/command_'|cat:$page_info.last}" enctype="multipart/form-data">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cmd">
<input type="hidden" name="aid" value="{$aid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="uid" value="{$uid}">
<input type="hidden" name="from_index" value="{$from_index}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">
<input type="hidden" name="hiDragging" id="hiDragging">
<input type="hidden" name="hiAcceptDrop" id="hiAcceptDrop">
{include file="mail/mobile/_send.tpl" button_file="mail/mobile/_send_buttons.tpl"}
</form><!-- end of content-->
