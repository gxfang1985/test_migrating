{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{strip}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_external_access_edit_confirm'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

        <div class="explanation">
            {cb_msg module='grn.system.application' key='GRN_SY_AP-105' replace='true'}
            <div class="attention">
                {cb_msg module='grn.system.application' key='GRN_SY_AP-108' replace='true'}
            </div>
        </div>

        {capture name='grn_system_application_GRN_SY_AP_105'}{cb_msg module='grn.system.application' key='GRN_SY_AP-106' replace='true'}{/capture}
        {grn_button_submit class='margin' caption=$smarty.capture.grn_system_application_GRN_SY_AP_105 id="`$page_info.all`_submit"}
        {capture name='grn_system_application_GRN_SY_AP_106'}{cb_msg module='grn.system.application' key='GRN_SY_AP-107' replace='true'}{/capture}
        {grn_button_cancel page='system/application/external_access_edit' class='margin' caption=$smarty.capture.grn_system_application_GRN_SY_AP_106}
    </form>
{/strip}
{include file='grn/system_footer.tpl'}
