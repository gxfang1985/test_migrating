{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-452' replace='true'}<span class="bold">{grn_sentence caption=$item.display_name class='person20'}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-453' replace='true'}
 <div class="attention"></div>
 </p>
 <p>
   {capture name='grn_report_operation_yes'}{cb_msg module='grn.report.operation' key='yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_yes}
   {capture name='grn_report_operation_no'}{cb_msg module='grn.report.operation' key='no' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_operation_no}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="iid" value="{$item_id|escape}">
</form>

{include file='grn/footer.tpl'}
