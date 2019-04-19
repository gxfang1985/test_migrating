{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file="cabinet/_delete_multi.tpl" delete='force'}
{capture name='tmp'}{cb_msg module="fw.ui" key="yes"}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.tmp}
{capture name='tmp'}{cb_msg module="fw.ui" key="no"}{/capture}{grn_button_cancel caption=$smarty.capture.tmp}
</form>
{include file="grn/system_footer.tpl"}
