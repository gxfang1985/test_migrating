{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/ui/command_mailer_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.system.ui' key='GRN_SY_UI-214' replace='true'}<span class="bold">{$item.name|escape}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-215' replace='true'}</p>
 <p>
  {capture name='grn_system_ui_GRN_SY_UI_216'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-216' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_216}
  {capture name='grn_system_ui_GRN_SY_UI_217'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-217' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_ui_GRN_SY_UI_217}
 </p>

<input type="hidden" name="id" value="{$id|escape}">
</form>

{include file="grn/system_footer.tpl"}
