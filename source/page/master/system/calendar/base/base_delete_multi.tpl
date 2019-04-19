{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/base/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.i18n.base' key='confirm_delete_multi_before' replace='true'} <span class="bold">{$base_count}</span> {cb_msg module='grn.system.i18n.base' key='confirm_delete_multi_after' replace='true'}</p>
 <p>
  {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='yes' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.tmp}
  {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.tmp}
 </p>
{foreach from=$base_ids item=base_id}
<input type="hidden" name="base-id[]" value="{$base_id}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}
