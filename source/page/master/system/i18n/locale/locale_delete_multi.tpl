{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="system/i18n/locale/delete_multi" method="post" action="{grn_pageurl page='system/i18n/locale/command_locale_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <p id="explanation">{cb_msg module='grn.system.i18n.locale' key='Locale-26' replace='true'} <span id="locale-count" class="bold">{$count}</span> {cb_msg module='grn.system.i18n.locale' key='Locale-27' replace='true'}</p>
 <p>
  {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-28' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.tmp}
  {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-29' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.tmp}
 </p>  
{foreach from=$locale_ids item=locale_id}
<input type="hidden" name="locale-id[]" value="{$locale_id}" />
{/foreach}  
</form>
{include file="grn/system_footer.tpl"}
