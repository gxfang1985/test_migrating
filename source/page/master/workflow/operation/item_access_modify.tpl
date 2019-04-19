{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{literal}
<script type="text/javascript">
<!--
function grn_workflow_system_checkItemAccessRight(view_id,edit_id)
{
    var view_id = jQuery(view_id);
    var edit_id = jQuery(edit_id);
    if(!view_id.prop('checked'))
    {
        edit_id.prop( "disabled", true );
        edit_id.prop( "checked", false );
    }
    else
    {
        edit_id.prop( "disabled", false );
    }
}
-->
</script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="iid" value="{$iid|escape}">

<div class="explanation mTop10 mBottom15">
  {cb_msg module='grn.workflow.system' key='key_134_1' replace='true'}<b>{$item.display_name}</b>{cb_msg module='grn.workflow.system' key='key_134_2' replace='true'}
  {if $item.foreign_key == 'grn.workflow.numeric'}
    <div class="mTop3">
      <span class="icon_information_sub_grn">{cb_msg module='grn.workflow' key='access_rights_numeric_tip' replace='true'}</span>
    </div>
  {/if}
</div>
<span class="sub_title">{cb_msg module='grn.workflow.system' key='w_pathway_step_list' replace='true'}</span>
<div class="wf_path_table_access_list">
<table class="list_column">
 <colgroup>
  <col width="1%">
  <col width="15%">
  <col width="5%">
  <col width="5%">
  <col width="15%">
  <col width="60%">
 </colgroup>
 <tr>
  <th nowrap></th>
  </th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap style="text-align:center">{cb_msg module='grn.workflow.system' key='w_view' replace='true'}</th>
  <th nowrap style="text-align:center">{cb_msg module='grn.workflow.system' key='w_edit_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
 <tr>
  {assign var=null_id value=null}
  {if $item.attach_file_view}
    {assign var='disabled' value=false}
    {assign var='checked'  value=$item.attach_file}
  {else}
    {assign var='disabled' value=true}
    {assign var='checked'  value=false}
  {/if}
  <td class="wf_route_arrow_area_grn" rowspan="{$path_step_count+1}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
  <td nowrap>{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}</td>
  <td align="center">{grn_checkbox name='col_attach_file_view' id="col_attach_file_view" value=1 checked=$item.attach_file_view onclick="grn_workflow_system_checkItemAccessRight(col_attach_file_view, col_attach_file)"}</td>
  <td align="center">{grn_checkbox name='col_attach_file'      id="col_attach_file"      value=1 checked=$checked disabled=$disabled}</td>
  <td nowrap>&nbsp;</td>
  <td nowrap>&nbsp;</td>
 </tr>
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
  {capture name='view_id'}psids_view_{$path_step._id}{/capture}
  {capture name='edit_id'}psids_edit_{$path_step._id}{/capture}
  {if $approval_edit}
    {capture name='function'}grn_workflow_system_checkItemAccessRight({$smarty.capture.view_id|grn_noescape}, {$smarty.capture.edit_id|grn_noescape}){/capture}
  {/if}
  {assign var='path_step_id' value=$path_step._id}
  {if $accesses_list.$path_step_id.col_view && $approval_edit}
    {assign var='disabled' value=false}
    {assign var='checked'  value=$accesses_list.$path_step_id.col_edit}
  {else}
    {assign var='disabled' value=true}
    {assign var='checked'  value=false}
  {/if}
  <td nowrap>{$path_step.col_role|escape}</td>
  <td align="center">{grn_checkbox name='psids_view[]' id=$smarty.capture.view_id value=$path_step._id checked=$accesses_list.$path_step_id.col_view onclick=$smarty.capture.function}</td>
  <td align="center">{grn_checkbox name='psids_edit[]' id=$smarty.capture.edit_id value=$path_step._id checked=$checked disabled=$disabled}</td>
  <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
  <td nowrap>
{assign var='path_step_id' value=$path_step._id}
{if 0 == $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='w_default_set' replace='true'}
{else}
{foreach name=members from=$members.$path_step_id item=member}
   <span class="voice">{grn_workflow_member_name infos=$member}</span><br>
{/foreach}
{/if}
  </td>
</tr>
{/foreach}
</table>

{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y}
{grn_button_cancel page='workflow/operation/item_access_list' cid=$cid fid=$fid}

</form>
</div>
{include file='grn/footer.tpl'}
