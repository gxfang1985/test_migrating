{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <span class="sub_explanation">
  </span>
  <p class="item">
  {grn_change_order form_name=$form_name select_name='order[]' options=$item_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    {capture name='grn_report_operation_GRN_RPRT_OP_226'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-226' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_226 onclick="grn_onsubmit_common(this.form);"}
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>
{include file='grn/footer.tpl'}
