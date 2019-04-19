{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="grn/html/page/workflow/auto_schedule_register.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div><span>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-112' replace='true'}</span></div>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tr>
            <th nowrap>{capture name='grn_workflow_active'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-101' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_active}</th>
            <td>
                {capture name='grn_workflow_schedule_active'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-102' replace='true'}{/capture}{grn_checkbox name='active' id='active' value='1' caption=$smarty.capture.grn_workflow_schedule_active checked=$active onclick="grn.page.workflow.auto_schedule_register.check_disable();"}
            </td>
        </tr>
        <tr>
            <td><br></td>
        </tr>
        <tr>
            <td><div class="sub_title">{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-105' replace='true'}</div></td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_workflow_event_type'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-106' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_event_type}</th>
            <td>
                {capture name='grn_workflow_regular'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-103' replace='true'}{/capture}
                {capture name='grn_workflow_all_day'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-104' replace='true'}{/capture}
                {grn_radio name='schedule_type' id='regular' value='0' caption=$smarty.capture.grn_workflow_regular checked=$regular_checked_type}
                {grn_radio name='schedule_type' id='all_day' value='1' caption=$smarty.capture.grn_workflow_all_day checked=$allday_checked_type}
            </td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_workflow_menu'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-107' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_menu}</th>
            <td>
                {grn_select  name='menu' size='1' options=$menus}
            </td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_workflow_start_item'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-108' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_start_item necessary=true}</th>
            <td>
                {capture name='grn_workflow_start_item_required'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-110' replace='true'}{/capture}{validate form=$form_name field="schedule_start_item" criteria="notEmpty" message=$smarty.capture.grn_workflow_start_item_required transform="cb_trim" append="validation_errors"}
                {grn_select id = 'schedule_start_item'  name='schedule_start_item' size='1' options=$date_start_item_list}
            </td>
        </tr>
        <tr>
            <th nowrap>{capture name='grn_workflow_end_item'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-109' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_end_item necessary=true}</th>
            <td>
                {capture name='grn_workflow_end_item_required'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-111' replace='true'}{/capture}{validate form=$form_name field="schedule_end_item" criteria="notEmpty" message=$smarty.capture.grn_workflow_end_item_required transform="cb_trim" append="validation_errors"}
                {grn_select id='schedule_end_item' name='schedule_end_item' size='1' options=$date_end_item_list}
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input class="margin" type="submit" value="{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-113' replace='true'}" id="{$page_info.last}_submit">
                {grn_button_cancel page='workflow/operation/form_view' cid=$cid fid=$fid}
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$cid|escape}">
    <input type="hidden" name="fid" value="{$fid|escape}">
</form>
{include file="grn/footer.tpl"}
