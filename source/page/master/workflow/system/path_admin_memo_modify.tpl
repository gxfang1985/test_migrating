{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_memo_for_sysytem_administrator'}{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_memo_for_sysytem_administrator}</th>
  <td>
   {grn_textarea name="col_admin_memo" cols="50" rows="5" value=$col_admin_memo}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <input class="margin" type="submit" name="modify" value="{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}">
   {grn_button_cancel page='workflow/system/path_view' pid=$pid}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}
