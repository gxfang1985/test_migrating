{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="iid" value="{$iid|escape}">

<p>
 <div class="explanation">
  {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-1' replace='true'}<br>
  {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-2' replace='true'}<br>
 </div>
</p>

<span class="sub_title">{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-3' replace='true'}</span>
<table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="1%">
  <col width="1%">
  <col width="15%">
  <col width="15%">
  <col width="70%">
 </colgroup>
 <tr>
  <th nowrap></th>
  <th nowrap>{include file='workflow/checkall.tpl' form_name=$form_name elem_name='psids[]'}</th>
  </th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-4' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-5' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-6' replace='true'}</th>
 </tr>
<tr>
{assign var=not_first value=true}
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td rowspan="{$path_step_count}" align="center"><font size=+3>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-7' replace='true'}</font></td>
{/if}
{assign var='path_step_id' value=$path_step._id}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id checked=$change_accesses.$path_step_id}</td>
  <td nowrap>{$path_step.col_role|escape}</td>
  <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
  <td nowrap>
{assign var='path_step_id' value=$path_step._id}
{if 0 == $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-8' replace='true'}
{else}
{foreach name=members from=$members.$path_step_id item=member}
   <span class="voice">{grn_workflow_member_name infos=$member}</span><br>
{/foreach}
{/if}
  </td>
</tr>
{/foreach}
</table>
</p>

<p>
<span class="sub_title">{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-9' replace='true'}</span>
<table class="std_form">
 <tr>
  <th rowspan="1" align="left" nowrap>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-10' replace='true'}</th>
  <td>
   {capture name='grn_workflow_system_GRN_WKF_SYS_11'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-11' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_11 name='col_attach_file' id='col_attach_file' value='1' checked=$col_attach_file}
  </td>
 </tr>
</table>
  {capture name='grn_workflow_system_GRN_WKF_SYS_12'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-12' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_12}
  {grn_button_cancel page='workflow/system/formlayout_view' cid=$cid fid=$fid iid=$iid}
 </p>

</form>
{include file='grn/system_footer.tpl'}
