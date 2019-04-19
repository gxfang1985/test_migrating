{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_log_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="priority" value="{$priority|escape}">
<input type="hidden" name="category" value="{$category|escape}">
 <p>{cb_msg module='grn.system.logging' key='GRN_SY_LO-79' replace='true'}<span class="bold">{$category_name}</span>{cb_msg module='grn.system.logging' key='GRN_SY_LO-80' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.system.logging' key='GRN_SY_LO-81' replace='true'}</p>
 <p>
  {capture name='grn_system_logging_GRN_SY_LO_82'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-82' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_82}
  {capture name='grn_system_logging_GRN_SY_LO_83'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-83' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_logging_GRN_SY_LO_83}
 </p>
{foreach from=$logs item=lid}
<input type="hidden" name="eid[]" value="{$lid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}
