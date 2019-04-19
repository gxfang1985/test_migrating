{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="selected_dynamic_roles" value="{$selected_dynamic_roles|escape}">
<input type="hidden" name="selected_static_roles" value="{$selected_static_roles|escape}">
<input type="hidden" name="selected_groups" value="{$selected_groups|escape}">
<input type="hidden" name="selected_users" value="{$selected_users|escape}">

<p class="explanation">

    {cb_msg module='grn.system.application' key='GRN_SY_AP-69' replace='true'}<span class="bold">{$user_total}</span>{if $user_total > 1}{cb_msg module='grn.system.application' key='GRN_SY_AP-70' replace='true'}{else}{cb_msg module='grn.system.application' key='GRN_SY_AP-74' replace='true'}{/if}

</p>

<p>
{capture name='grn_system_GRN_SY_AP_67'}{cb_msg module='grn.system.application' key='GRN_SY_AP-67' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_GRN_SY_AP_67}
{capture name='grn_system_GRN_SY_AP_68'}{cb_msg module='grn.system.application' key='GRN_SY_AP-68' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_GRN_SY_AP_68 page='system/application/availability_user_list'}
</p>

</form>

{include file='grn/system_footer.tpl'}
