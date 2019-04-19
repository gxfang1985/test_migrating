{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-384' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-385' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-386' replace='true'}
</div>

<p>
{capture name='grn_report_system_GRN_RPRT_SY_387'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-387' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_387}
{capture name='grn_report_system_GRN_RPRT_SY_388'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-388' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_388}
</p>

</form>

{include file='grn/system_footer.tpl'}
