{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p class="explanation">
{cb_msg module='grn.system.application' key='GRN_SY_AP-71' replace='true'}
</p>

<p>
{capture name='grn_system_application_GRN_SY_AP_72'}{cb_msg module='grn.system.application' key='GRN_SY_AP-72' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_application_GRN_SY_AP_72}
{capture name='grn_system_application_GRN_SY_AP_73'}{cb_msg module='grn.system.application' key='GRN_SY_AP-73' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_application_GRN_SY_AP_73 page='system/application/availability_user_list'}
</p>

</form>

{include file='grn/system_footer.tpl'}
