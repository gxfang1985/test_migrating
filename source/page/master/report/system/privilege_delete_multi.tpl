{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-70' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-71' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-72' replace='true'}<span class="bold">{$count|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-73' replace='true'}
</div>

<p>
{capture name='grn_report_system_GRN_RPRT_SY_74'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-74' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_74}
{capture name='grn_report_system_GRN_RPRT_SY_75'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-75' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_75}
</p>
</form>

{include file='grn/system_footer.tpl'}
