{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{capture name="date"}
    {grn_report_select_date prefix="date_value_%NUM%_" form_name=$form_name}
{/capture}

{include file='report/_filter_item.tpl'}
{literal}
    <style type="text/css">
    div.filter_item_odd
    {
        background-color:#E6E6EE;
    }
    </style>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-438' replace='true'}</div>
    <span id="validate_message" style="font-weight:bold;color:red;"></span>
    {include file="grn/show_validation_errors.tpl"}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr>
            <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-439' replace='true'}</th>
            <td>{$category.col_name|escape}</td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_440'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-440' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_440 necessary=true}</th>
            <td>{capture name='grn_report_operation_GRN_RPRT_OP_441'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-441' replace='true'}{/capture}{validate form='report/operation/filter_add' field="name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_441 append="validation_errors"}{grn_text name='name' necessary=1 value=$name size="50" disable_return_key=true id="filter_name_input"}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.report' key='form' replace='true'}</th>
            <td>{include file='report/_filter_formselect.tpl'}</td>
        </tr>
        <tr valign="top">
            <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_442'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-442' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_442}</th>
            <td>{include file='report/_filter_conditions.tpl' inputs=$inputs}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-449' replace='true'}</th>
            <td>
                {grn_user_add form_name=$form_name selected_users=$selected_users sUID='sUID[]' CGID='CGID' CID='CID[]' access_plugin=$plugin}
                <span class="sub_explanation">
                {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-451' replace='true'}
                </span>
            </td> 
        </tr>
        <tr>
            <td></td>
            <td>
                <input class="margin" type="submit" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-450' replace='true'}" onclick="if(validateConditions(true)) grn_onsubmit_common(this.form); else return false;">
                {grn_button_cancel page='report/operation/filter_index' cid=$category_id sf=1}
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$category_id}">
</form>
{include file='grn/footer.tpl'}
