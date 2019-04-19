{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/ui/command_mailer_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.system.ui' key='GRN_SY_UI-221' replace='true'}<span class="bold">{$count|escape}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-222' replace='true'}</p>
 <p>
  {capture name='grn_system_ui_GRN_SY_UI_223'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-223' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_223}
  {capture name='grn_system_ui_GRN_SY_UI_224'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-224' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_ui_GRN_SY_UI_224}
 </p>
{foreach from=$eids item=eid}
 <input type="hidden" name="eid[]" value="{$eid|escape}">
{/foreach}
</form>

{include file="grn/system_footer.tpl"}
