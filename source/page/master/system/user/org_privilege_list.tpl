{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-355' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{$node.name|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-356' replace='true'}
{cb_msg module='grn.system.user' key='GRN_SY_US-357' replace='true'}
</div>
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-359' replace='true'}
</div>

<p>
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="system/user/org_privilege_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">

<p>
 <div>
 <span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-360' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/user/org_privilege_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
 <span class="m_small">{if 0 == $access.count}{assign var='disabled' value=true}{/if}{capture name='grn_system_user_GRN_SY_US_361'}{cb_msg module='grn.system.user' key='GRN_SY_US-361' replace='true'}{/capture}{grn_link image='delete20.gif' page="system/user/org_privilege_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_system_user_GRN_SY_US_361 disabled=$disabled}</span>
 </div>
 <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="list_column">
 <colgroup>
 <col width="3%">
 <col width="50%">
 <col width="30%">
 <col width="17%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-362' replace='true'}</th>
 <th style="text-align:center" nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-363' replace='true'}</th>
 <th nowrap>&nbsp;</th>
 </tr>
{foreach from=$access.list item=item}
 {assign var='value' value="`$item.type`:`$item.tid`"}
 <tr valign="middle">
 <td align="center">{grn_checkbox name='eid[]' id='eid_`$value`' value=$value}</td>
 {if 'user' == $item.type}
 {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
 <td class="m_small">{grn_user_name uid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {elseif 'group' == $item.type}
 {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
 <td class="m_small">{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {elseif 'static_role' == $item.type}
 <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
 {elseif 'dynamic_role' == $item.type}
 <td class="m_small">{grn_image image='role20.gif'}{$item.tid|escape}</td>
 {/if}
 </td>
 <td align="center">{if $item.transferable==1}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.system.user' key='GRN_SY_US-364' replace='true'}</span>{/if}</td>
 <td class="m_small" nowrap>
  {capture name='grn_system_user_GRN_SY_US_365'}{cb_msg module='grn.system.user' key='GRN_SY_US-365' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/user/org_privilege_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_365 itype=$item.type itid=$item.tid params=$ours_params poid=$poid }
 </td>
 </tr>
{/foreach}
 </table>
 <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>

 </form>
</td>
<td width="30%"> 
</td>
</tr>
</table>

{include file="grn/system_footer.tpl"}
