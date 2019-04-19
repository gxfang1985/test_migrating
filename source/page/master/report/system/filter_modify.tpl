{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{capture name="date"}
    {grn_report_select_date prefix="date_value_%NUM%_" form_name=$form_name}
{/capture}

{include file='report/_filter_item.tpl'}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-109' replace='true'}</div>
    <span id="validate_message" style="font-weight:bold;color:red;"></span>
    {include file="grn/show_validation_errors.tpl"}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr>
            <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-543' replace='true'}</th>
            <td>
                {if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-544' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}
            </td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_110'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-110' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_110 necessary=true}</th>
            <td>{capture name='grn_report_system_GRN_RPRT_SY_111'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-111' replace='true'}{/capture}{validate form='report/system/filter_modify' field="name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_system_GRN_RPRT_SY_111 append="validation_errors"}{grn_text name='name' necessary=1 value=$name size="50" disable_return_key=true id="filter_name_input"}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.report' key='form' replace='true'}</th>
            <td>{include file='report/_filter_formselect.tpl'}</td>
        </tr>
        <tr valign="top">
            <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_112'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-112' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_112}</th>
            <td>
                {include file='report/_filter_conditions.tpl' inputs=$conditions filter_modify=true}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-118' replace='true'}</th>
            <td>
                {grn_user_add form_name=$form_name selected_users=$selected_users sUID='sUID[]' CGID='CGID' CID='CID[]' access_plugin=$plugin}
                <span class="sub_explanation">
                    {cb_msg module='grn.report.system' key='GRN_RPRT_SY-560' replace='true'}
                </span>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input class="margin" type="submit" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-119' replace='true'}" onclick="if(validateConditions(true)) grn_onsubmit_common(this.form); else return false;">
                {grn_button_cancel page='report/system/filter_view' cid=$category_id fid=$filter._id}
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$category_id}">
    <input type="hidden" name="fid" value="{$filter._id}">
</form>
{include file='grn/system_footer.tpl'}
