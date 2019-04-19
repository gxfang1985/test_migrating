{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{include file='grn/common.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}<span id="spinner_area"><span id="spinner_for_ajax" style="display: none"><img src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}"></span></span>
{grn_load_css file="grn/html/page/system/queue_monitoring.css"}
<script>
    <!--
    grn.msg.msgBoxTitle = '{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-10' replace='true'}';
    grn.msg.msgBoxContent = '{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-11' replace='true'}';
    //-->
</script>
<div id="explanation_area" class="explanation mTop5 mLeft5">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-1' replace='true'}</div>
<form id="delete_queue_form" method="post" action="{$form_url}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="id" value="{$queue.id}">
    <input type="hidden" name="ctime" value="{$queue.ctime}">
</form>
<div id="queue_monitor_area" class="mTop15 mLeft15 mBottom15">
    <span id="no_queue_message"{if $count != 0} style="display: none"{/if}>{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-2' replace='true'}</span>
    <div id="queue_table_display_area"{if $count == 0} style="display: none"{/if}>
        <div id="queue_delete_button">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-3' replace='true'}</div>
        <table id="monitor_table">
            <tr id="id_column">
                <th id="id_label">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-4' replace='true'}</th>
                <td id="id_content">{$queue.id}</td>
            </tr>
            <tr id="ctime_column">
                <th id="ctime_label">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-5' replace='true'}</th>
                <td id="ctime_content">{$queue.ctime}</td>
            </tr>
            <tr id="jobName_column">
                <th id="jobName_label">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-6' replace='true'}</th>
                <td id="jobName_content">{$queue.jobName}</td>
            </tr>
            <tr id="message_column">
                <th id="message_label">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-7' replace='true'}</th>
                <td id="message_content">{$queue.message}</td>
            </tr>
        </table>
        <div id="remaining_queue_number_div" class="mTop5">
            <span id="remaining_queue_number_label">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-8' replace='true'}</span><span id="remaining_queue_number">{$count}</span>{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-9' replace='true'}
        </div>
    </div>
    <div id="queue_monitor_error_area" style="display: none">
        <div id="queue_monitor_error_message">{cb_msg module='grn.system.queue_monitoring' key='GRN_SY_QM-12' replace='true'}</div>
        <div id="queue_monitor_response_error_text">
        </div>
    </div>
</div>
{grn_load_javascript file="grn/html/page/system/cbfts_queue.js"}
<script type="text/javascript">
    grn.page.system.cbfts_queue.init("{cb_pageurl page='system/queue_monitoring/ajax_cbfts_queue'}");
</script>
{include file="grn/system_footer.tpl"}
{include file="grn/error_handler.tpl"}
