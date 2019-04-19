{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-328' replace='true'}<span class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$form.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-329' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-330' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_331'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-331' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_331}
  {capture name='grn_report_operation_GRN_RPRT_OP_332'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-332' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_332}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
{foreach from=$report_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/footer.tpl"}
