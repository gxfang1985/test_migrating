{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_'|cat:$page_info.last postfix='ip_address.csv'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tr>
            <th nowrap>
                {cb_msg module='grn.system.application' key='GRN_SY_AP-27' replace='true'}
            </th>
            <td>
                {grn_charset name="charset" bom='TRUE'}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.system.application' key='GRN_SY_AP-28' replace='true'}
            </th>
            <td>
                {capture name='grn_system_application_GRN_SY_AP_29'}{cb_msg module='grn.system.application' key='GRN_SY_AP-29' replace='true'}{/capture}
                {capture name='grn_system_application_GRN_SY_AP_30'}{cb_msg module='grn.system.application' key='GRN_SY_AP-30' replace='true'}{/capture}
                {grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_system_application_GRN_SY_AP_29 checked=0}&nbsp;{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_system_application_GRN_SY_AP_30 checked=1}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_system_application_GRN_SY_AP_31'}{cb_msg module='grn.system.application' key='GRN_SY_AP-31' replace='true'}{/capture}
                {grn_button_submit class="margin" caption=$smarty.capture.grn_system_application_GRN_SY_AP_31}
                {grn_button_cancel page="system/application/external_access_detail"}
            </td>
        </tr>
    </table>
    <hr>
    <p>
        {include file='system/application/_ip_address_csv_columns.tpl'}
        {include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}
</form>
{include file='grn/system_footer.tpl'}