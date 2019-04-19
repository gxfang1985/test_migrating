{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div class="wf_path_table">
<table class="list_column">
 <colgroup>
  <col width="70%">
  <col width="30%">
 </colgroup>
 <tr>
  <th nowrap align="center">{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap align="center">{cb_msg module='grn.workflow.system' key='w_button_to_display_y' replace='true'}</th>
 </tr>
 <tr>
  <td nowrap>
   <li><span class="bold">{cb_msg module='grn.workflow.system' key='w_approve_y' replace='true'}</span><br>
   <div style="margin-left:1em">
    {cb_msg module='grn.workflow.system' key='w_configurable_some_approvers_one_pathway' replace='true'}<br>
    {cb_msg module='grn.workflow.system' key='w_multiple_approver_approve_parallely_y' replace='true'}<br>
    {cb_msg module='grn.workflow.system' key='key_133' replace='true'}
   </div>
  </td>
  <td>&nbsp;&nbsp;<input type=button value="{cb_msg module='grn.workflow.system' key='w_do_approve_y' replace='true'}">&nbsp;&nbsp;<input type=button value="{cb_msg module='grn.workflow.system' key='w_reject' replace='true'}">&nbsp;&nbsp;</td>
 </tr>
 <tr>
  <td nowrap>
   <li><span class="bold">{cb_msg module='grn.workflow.system' key='w_circular' replace='true'}</span><br>
   <div style="margin-left:1em">
    {cb_msg module='grn.workflow.system' key='w_configurable_some_readers_one_pathway' replace='true'}<br>
    {cb_msg module='grn.workflow.system' key='w_multiple_viewer_view_parallely_y' replace='true'}
   </div>
  <td>&nbsp;&nbsp;<input type=button value="{cb_msg module='grn.workflow.system' key='w_confirm' replace='true'}">&nbsp;&nbsp;</td>
 </tr>
</table>
</div>

{include file='grn/footer.tpl'}
