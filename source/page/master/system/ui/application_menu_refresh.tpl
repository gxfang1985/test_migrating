{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_application_menu_refresh'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.ui' key='GRN_SY_UI-153' replace='true'}
  <div class="attention">{cb_msg module='grn.system.ui' key='GRN_SY_UI-154' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_system_ui_GRN_SY_UI_155'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-155' replace='true'}{/capture}{grn_button_submit class="line" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_155}
  {capture name='grn_system_ui_GRN_SY_UI_156'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-156' replace='true'}{/capture}{grn_button_cancel class="line" page="system/ui/application_menu_list" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_156}
 </p>
</form>
{include file="grn/system_footer.tpl"}
