{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_memo_for_sysytem_administrator' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_system_w_memo_for_sysytem_administrator'}{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_memo_for_sysytem_administrator}</th>
  <td>
      {grn_textarea name="admin_memo" rows="10" value=$form.admin_memo}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/system_footer.tpl'}
