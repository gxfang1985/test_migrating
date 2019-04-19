{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last postfix='report.csv'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        {include file="report/_export_item_add.tpl"}
        <tr>
            <th nowrap>
                {cb_msg module='grn.report.system' key='GRN_RPRT_SY-401' replace='true'}
            </th>
            <td colspan="3">
                {grn_charset name="charset" bom='TRUE'}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.report.system' key='GRN_RPRT_SY-402' replace='true'}
            </th>
            <td>
                {capture name='grn_report_system_GRN_RPRT_SY_403'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-403' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_403   checked=0}&nbsp;{capture name='grn_report_system_GRN_RPRT_SY_404'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-404' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_404 checked=1}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_report_system_GRN_RPRT_SY_405'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-405' replace='true'}{/capture}{grn_button_submit id="export_button" class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_405 onclick='PrepareSubmit(this.form);'}
                {grn_button_cancel page=$last_page cid=$cid fid=$fid tmp_key=$tmp_key}
            </td>
        </tr>
    </table>
</form>
{include file="grn/system_footer.tpl"}
