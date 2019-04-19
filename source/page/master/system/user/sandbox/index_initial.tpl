{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/sandbox/command_index'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="command" value="create">

    <div class="explanation mBottom15 mTop15">
        {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-1' replace='true'}
    </div>

    <div class="info_area_grn mBottom15">
        <div class="icon_information_grn"><span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-2' replace='true'}</span></div>
        <ul class="info_list_icon_grn">
            <li>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-17' replace='true'}</li>
        </ul>
    </div>

    <p>
        {capture name='grn_system_user_GRN_SY_SANDBOX_INDEX_3'}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-3' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_SANDBOX_INDEX_3 id="system_user_sandbox_submit"}
        {capture name='grn_system_user_GRN_SY_SANDBOX_INDEX_4'}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-4' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_SANDBOX_INDEX_4 id="user" page="system/common_list"}
    </p>
</form>

{include file="grn/system_footer.tpl"}
