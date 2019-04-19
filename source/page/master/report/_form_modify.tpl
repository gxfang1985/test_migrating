{if $is_operation}
  {assign var=action_dir value='operation'}
{else}
  {assign var=action_dir value='system'}
{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/'|cat:$action_dir|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-49' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
{include file='report/_form_edit.tpl' category_id=$category_id category=$category form_name=$form_name name_text=$form.name foreign_key_text=$form.foreign_key follow_check=$form.enable_follow partner_check=$form.enable_partner member_check=$form.enable_member memo_text=$form.memo}
 <tr>
  <td></td>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_60'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-60' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_60}
      {grn_button_cancel page='report/'|cat:$action_dir|cat:'/form_view' cid=$category_id fid=$form_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>
