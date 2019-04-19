{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{grn_change_order form_name=$form_name select_name='eid[]' options=$menu_options}

{capture name='grn_system_ui_GRN_SY_UI_106'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-106' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_106 onclick="grn_onsubmit_common(this.form);"}
{grn_button_cancel}
</form>

{include file="grn/system_footer.tpl"}
