{grn_title title=$page_title class=$page_info.parts[0]}
 
{assign var='form_name' value=$action_dir|cat:'/form_add'}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$action_dir|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-106' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
{include file='report/_form_edit.tpl' category_id=$category_id category=$category form_name=$form_name name_text=$name foreign_key_text=$foreign_key follow_check=$can_follow partner_check=$enable_partner member_check=$enable_member memo_text=$memo}
 <tr>
  <td></td>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_117'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-117' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_117}
      {grn_button_cancel page=$action_dir|cat:'/form_list' cid=$category_id sf=1}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
