{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-44' replace='true'}<span class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$form.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-45' replace='true'}
 <div class="attention">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-46' replace='true'}</div>
 </p>
 <p>
   {capture name='grn_report_operation_GRN_RPRT_OP_47'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-47' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_47}
   {capture name='grn_report_operation_GRN_RPRT_OP_48'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-48' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_48}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/footer.tpl'}
