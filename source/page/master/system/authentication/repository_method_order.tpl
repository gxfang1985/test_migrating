{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

{grn_title title=$page_title class=$page_info.parts[0]}

{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_repository_method_order'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {grn_change_order form_name=$form_name select_name='order[]' options=$repository_method_list}

    <p>
        {capture name='grn_system_authentication_GRN_SY_AU_74'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-74' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_74 onclick="grn_onsubmit_common(this.form);"}
        {grn_button_cancel}
    </p>
</form>

{include file="grn/system_footer.tpl"}
