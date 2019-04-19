{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<p class="explanation">
{cb_msg module='grn.workflow.system' key='key_128_1' replace='true'}<span class="bold">{$col_role|escape}</span>{cb_msg module='grn.workflow.system' key='key_128_2' replace='true'}<span class="bold">{if GRN_WORKFLOW_CIRCULAR == $col_type}{cb_msg module='grn.workflow.system' key='key_128_3' replace='true'}{else}{cb_msg module='grn.workflow' key="col_acceptance_type_`$col_acceptance_type`"}{/if}</span>{cb_msg module='grn.workflow.system' key='key_128_4' replace='true'}<br>
{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-93' replace='true'}<br />
{cb_msg module='grn.workflow.system' key='key_129_1' replace='true'}{capture name='grn_workflow_system_key_129_2'}{cb_msg module='grn.workflow.system' key='key_129_2' replace='true'}{/capture}{grn_sentence image='nouser20.gif' caption=$smarty.capture.grn_workflow_system_key_129_2}{cb_msg module='grn.workflow.system' key='key_129_3' replace='true'}
{cb_msg module='grn.workflow.system' key='w_select_applicant_in_role_when_setting_default' replace='true'}
<br />
{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-94' replace='true'}<br />
</p>

<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="workflow/operation/form_default_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">
 <input type="hidden" name="cid" value="{$cid|escape}">
 <input type="hidden" name="fid" value="{$fid|escape}">
 <input type="hidden" name="psid" value="{$psid|escape}">

<span class="sub_title">{cb_msg module='grn.workflow.operation' key='form_default_change_path' replace='true'}</span> 
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link image='modify20.gif' page="workflow/operation/form_default_change_path" params=$ours_params poid=$poid cid=$cid fid=$fid psid=$psid caption=$smarty.capture.grn_workflow_system_w_do_change_y}</span>
</div>
<table class="view_table" width="80%">
<col width="30%">
<col width="70%">
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_change_initial_value_by_applicant_y' replace='true'}</th>
  <td>{if $col_deny_change_path}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{else}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/if}</td>
 </tr>
</table>

<br />
 <p></p>
 <div>
 <span class="sub_title">{cb_msg module='grn.workflow.system' key='w_initial_value_list_y' replace='true'}</span>&nbsp; 
 {if $member_total == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">
{if 0 == $member_total && 0 == $col_skip}
{assign var='disabled' value=true}
{/if}
  {capture name='grn_workflow_system_form_default_skip_set'}{cb_msg module='grn.workflow.system' key='default_skip_set_link' replace='true'}{/capture}{grn_link image='nouser20.gif' page="workflow/operation/form_default_skip_set" params=$ours_params poid=$poid cid=$cid fid=$fid psid=$psid caption=$smarty.capture.grn_workflow_system_form_default_skip_set disabled=$col_skip}</span>
  <span class="m_small">{capture name='grn_workflow_system_GRN_WKF_SYS_91'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-91' replace='true'}{/capture}{grn_link image='modify20.gif' page="workflow/operation/form_default_add" params=$ours_params reset=1 caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_91 }</span>
  <span class="m_small">{capture name='grn_workflow_system_w_delete_all'}{cb_msg module='grn.workflow.system' key='w_delete_all' replace='true'}{/capture}{grn_link image='delete20.gif' page="workflow/operation/form_default_delete_all" params=$ours_params poid=$poid cid=$cid fid=$fid psid=$psid caption=$smarty.capture.grn_workflow_system_w_delete_all disabled=$disabled}</span>
 </div>
 <div>
 <span>{include file='workflow/checkall.tpl' elem_name='mids[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_workflow_system_GRN_WKF_SYS_37'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-37' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_37 onclick="if( ! grn_is_checked( this.form, 'mids[]' ) ) return false;"}</span>
 </div>
<div class="wf_path_table">
 <table class="admin_list_table">
 <colgroup>
 <col width="3%">
 <col width="67%">
 <col width="15%">
 <col width="15%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.workflow.system' key='w_team_user_role_app_y' replace='true'}</th>
 <th nowrap colspan="2">{cb_msg module='grn.workflow.system' key='w_select_superior_y' replace='true'}</th>
 </tr>
{foreach from=$members item=member}
 <tr valign="middle">
{assign var='value' value="`$member.type`:`$member.col_member`"}
 <td>{grn_checkbox name='mids[]' id='mids_`$member.type`' value=$value }</td>
 <td class="m_small">
 {grn_workflow_member_name type=$member.type id=$member.col_member}
 {if 'user' == $member.type}
 {capture name='grn_get_group_path_string_eid'}u_{$member.col_member}{/capture}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}
 {elseif 'group' == $member.type}
 {capture name='grn_get_group_path_string_eid'}o_{$member.col_member}{/capture}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}
 {/if}
 </td>
{if 'static_role' == $member.type}
 <td>{if $member.col_chief}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.workflow.system' key='w_incorrect' replace='true'}</span>{/if}</td>
 <td  class="m_small">{capture name='grn_workflow_system_w_change_y'}{cb_msg module='grn.workflow.system' key='w_change_y' replace='true'}{/capture}{grn_link image='modify20.gif' page="workflow/operation/form_default_chief_set" params=$ours_params poid=$poid cid=$cid fid=$fid psid=$psid mid=$member._id caption=$smarty.capture.grn_workflow_system_w_change_y}</td>
{else}
 <td colspan="2"><span class="grayout">{cb_msg module='grn.workflow.system' key='w_prohibited_y' replace='true'}</span></td>
{/if}
 </tr>
{/foreach}
 </table>
</div>
 <div>
 <span>{include file='workflow/checkall.tpl' elem_name='mids[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_workflow_system_GRN_WKF_SYS_37'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-37' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_37 onclick="if( ! grn_is_checked( this.form, 'mids[]' ) ) return false;"}</span>
 </div>
 </form>

</td>
<td width="30%"> 
</td>
</tr>
</table>

{include file="grn/footer.tpl"}
