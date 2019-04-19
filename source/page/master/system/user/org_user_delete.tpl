{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value="user_modify"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_org_user_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-261' replace='true'}<span class="bold">{grn_user_name uid=$user_id nolink=TRUE}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-262' replace='true'}<br />
<span class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-263' replace='true'}</span>
</div>

<p>
{capture name='grn_system_user_GRN_SY_US_264'}{cb_msg module='grn.system.user' key='GRN_SY_US-264' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_264 id="system-user-delete-submit"}
{capture name='grn_system_user_GRN_SY_US_265'}{cb_msg module='grn.system.user' key='GRN_SY_US-265' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_265 id="system-user-delete-cancel"}
</p>
</form>

{include file="grn/system_footer.tpl"}
