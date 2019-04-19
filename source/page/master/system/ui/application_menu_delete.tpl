{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/ui/command_application_menu_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.system.ui' key='GRN_SY_UI-24' replace='true'}<span class="bold">{$item.name|escape}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-25' replace='true'}</p>
 <p>
  {capture name='grn_system_ui_GRN_SY_UI_26'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_26}
  {capture name='grn_system_ui_GRN_SY_UI_27'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-27' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_ui_GRN_SY_UI_27}
 </p>

<input type="hidden" name="id" value="{$id|escape}">
</form>

{include file="grn/system_footer.tpl"}
