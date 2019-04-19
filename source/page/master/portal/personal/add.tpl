{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_load_javascript file="grn/html/portal.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_3' app_name=$app_name}</div>
    <p>
    {include file='grn/show_validation_errors.tpl'}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr>
            <th nowrap>
                {capture name='grn_portal_personal_GRN_POT_PE_14'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_14 necessary=TRUE}
            </th>
            <td>
                {capture name='grn_portal_personal_GRN_POT_PE_15'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-15' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_15 append="validation_errors"}{grn_text necessary=true name="title" value=$portal.title size="50" disable_return_key=true}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_portal_personal_GRN_POT_PE_16'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-16' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_16 onclick="grn_onsubmit_common(this.form);"}
                {grn_button_cancel page='portal/personal/list' pid=$pid}
            </td>
        </tr>
    </table>
    <input type="hidden" name="pid" value="{$pid}">
</form>

{include file='grn/personal_footer.tpl'}
