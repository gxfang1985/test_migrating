{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">

<p>
 <div class="explanation">
 </div>
</p>

<span class="sub_title">{cb_msg module='grn.workflow.system' key='w_access_priv_list_for_item_y' replace='true'}</span>
<div class="wf_path_table_access_list">
<table class="list_column">
 <tr>
  <th width="200px" rowspan="2">{cb_msg module='grn.workflow.system' key='w_item_name_y' replace='true'}</th>
  <th width="80px"  rowspan="2">{cb_msg module='grn.workflow.system' key='access_modify' replace='true'}</th>
  <th colspan="2" style="text-align:center">{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}</th>
{foreach name=path_steps from=$path_steps item=path_step}
  <th colspan="2" style="text-align:center">{$path_step.col_role|escape}
{/foreach}
 </tr>
 <tr>
   <th width="50px" style="text-align:center">{cb_msg module='grn.workflow.system' key='w_view' replace='true'}</th>
   <th width="50px" style="text-align:center">{cb_msg module='grn.workflow.system' key='w_edit_y' replace='true'}</th>
{foreach name=path_steps from=$path_steps item=path_step}
   <th width="50px" style="text-align:center">{cb_msg module='grn.workflow.system' key='w_view' replace='true'}</th>
   <th width="50px" style="text-align:center">{cb_msg module='grn.workflow.system' key='w_edit_y' replace='true'}</th>
{/foreach}
 </tr>
{foreach name=item_list from=$item_list item=item}
  <tr>
   <td nowrap>
    {$item.display_name|escape}
   </td>
   <td>
     {capture name='grn_workflow_system_w_change_y'}{cb_msg module='grn.workflow.system' key='w_change_y' replace='true'}{/capture}{grn_link page='workflow/operation/item_access_modify' caption=$smarty.capture.grn_workflow_system_w_change_y image='modify20.gif' cid=$cid fid=$item.form iid=$item.id}
   </td>
   <td style="text-align:center">
    {if $item.attach_file_view}
     {grn_image image='check20.gif'}
    {else}
     &nbsp;
    {/if}
   </td>
   <td style="text-align:center">
    {if $item.attach_file}
     {grn_image image='check20.gif'}
    {else}
     &nbsp;
    {/if}
   </td>
{foreach name=path_steps from=$path_steps item=path_step}
   {assign var='path_step_id' value=$path_step._id}
   <td style="text-align:center">
    {if $item.access.$path_step_id.col_view}
     {grn_image image='check20.gif'}
    {else}
     &nbsp;
    {/if}
   </td>
   <td style="text-align:center">
    {if $item.access.$path_step_id.col_edit}
     {grn_image image='check20.gif'}
    {else}
     &nbsp;
    {/if}
   </td>
{/foreach}
  </tr>
{/foreach}
</table>
</div>

{*
<p>
  {capture name='grn_workflow_system_w_do_apply_y'}{cb_msg module='grn.workflow.system' key='w_do_apply_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_apply_y}
  {grn_button_cancel page='workflow/operation/form_view' cid=$cid fid=$fid}
</p>
*}

</form>
{include file='grn/footer.tpl'}
