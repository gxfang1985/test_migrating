{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/role_user_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="role_id" value="{$role_id|escape}">
<p><div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-559' replace='true'}</div>
<table width="30%" class="view_table mTop10 mBottom5">
    <tr>
        <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-708' replace='true'}</th>
        <td nowrap>
            &nbsp;{if $permission_to_select_role}{cb_msg module='grn.system.user' key='GRN_SY_US-709' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-710' replace='true'}{/if}
            &nbsp;{capture name='grn_grn_GRN_SY_US_711'}{cb_msg module='grn.system.user' key='GRN_SY_US-711' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/user/using_role_set" caption=$smarty.capture.grn_grn_GRN_SY_US_711}
        </td>
    </tr>
</table>
<div class="explanation">
    {cb_msg module='grn.system.user' key='GRN_SY_US-712' replace='true'}<BR>
    {cb_msg module='grn.system.user' key='GRN_SY_US-712_1' replace='true'}<BR>
    {cb_msg module='grn.system.user' key='GRN_SY_US-712_2' replace='true'}<BR>
    {cb_msg module='grn.system.user' key='GRN_SY_US-712_3' replace='true'}
</div>
<p></p>
{if $smarty.const.ON_FOREST != 1}
{cb_msg module='grn.system.user' key='GRN_SY_US-560' replace='true'}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_561'}{cb_msg module='grn.system.user' key='GRN_SY_US-561' replace='true'}{/capture}{grn_link page='system/user/role_add' caption=$smarty.capture.grn_system_user_GRN_SY_US_561 image='write20.gif' role_id=$role_id element_id="system-role-add"}</span>
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_562'}{cb_msg module='grn.system.user' key='GRN_SY_US-562' replace='true'}{/capture}{grn_link page='system/user/role_user_vest' caption=$smarty.capture.grn_system_user_GRN_SY_US_562 image='user20.gif' role_id=$role_id reset=1 disabled=$not_selected element_id="system/user/role_user_vest"}</span>
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_REORDER_ROLE_LINK'}{cb_msg module='grn.system.user' key='GRN_SY_US_REORDER_ROLE_LINK' replace='true'}{/capture}{grn_link page='system/user/role_order' caption=$smarty.capture.grn_system_user_GRN_SY_US_REORDER_ROLE_LINK image='order20.gif' disabled=$order_disabled element_id="system/user/role_order"}</span>
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_563'}{cb_msg module='grn.system.user' key='GRN_SY_US-563' replace='true'}{/capture}{grn_link page='system/user/role_delete_all' caption=$smarty.capture.grn_system_user_GRN_SY_US_563 image='delete20.gif' role_id=$role_id disabled=$not_exists element_id="system/user/role_delete_all"}</span>
</div>
<p></p>
<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">
<div class="tree_item">
{if $role_id}
{capture name='grn_system_user_GRN_SY_US_564'}{cb_msg module='grn.system.user' key='GRN_SY_US-564' replace='true'}{/capture}{grn_link page='system/user/role_list' caption=$smarty.capture.grn_system_user_GRN_SY_US_564}
{else}
<div class="hilight"><span class="bold">{capture name='grn_system_user_GRN_SY_US_565'}{cb_msg module='grn.system.user' key='GRN_SY_US-565' replace='true'}{/capture}{grn_link page='system/user/role_list' caption=$smarty.capture.grn_system_user_GRN_SY_US_565}</span></div>
{/if}
</div>
{foreach from=$roles key=key item=item}
{if $key == $role_id}
<div class="tree_item"><div class="hilight"><span class="bold">{grn_link image='role20.gif' page='system/user/role_list' role_id=$key caption=$item.title}</span></div></div>
{else}
<div class="tree_item">{grn_link image='role20.gif' page='system/user/role_list' role_id=$key caption=$item.title}</div>
{/if}
{/foreach}
</td>
<td id="view_part" width="70%">
{if $role_id}
<div>
<span class="sub_title">{$roles.$role_id.title|escape}</span>
{capture name='grn_system_user_GRN_SY_US_566'}{cb_msg module='grn.system.user' key='GRN_SY_US-566' replace='true'}{/capture}{grn_link image='detail20.gif' page='system/user/role_view' role_id=$role_id caption=$smarty.capture.grn_system_user_GRN_SY_US_566 element_id="system-role-detail"}
</div>
 {include file='grn/memo.tpl' category_memo=$roles.$role_id.memo}
<p></p>
<div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-567' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="5%">
  <col width="50%">
  <col width="45%">
 </colgroup>
 <tr>
  <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-570' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-571' replace='true'}</th>
 </tr>
 {foreach from=$user_information.users key=uid item=user}
 <tr valign="top">
  {if $role_id == 1 && $uid == 1 }
  <td>&nbsp;</td>
  {else}
  <td><input type="checkbox" name="eid[]" value="{$uid}"></td>
  {/if}
  <td>{grn_user_name uid=$user.uid}</td>
  <td>{$user.account|escape}</td>
 </tr>
 {/foreach}
</table>
<div class="contents_navi">
{include file="grn/word_navi.tpl" navi=$view_set.navi }
</div>
<div>
{cb_msg module='grn.system.user' key='GRN_SY_US-572' replace='true'}{capture name='grn_system_user_GRN_SY_US_573'}{cb_msg module='grn.system.user' key='GRN_SY_US-573' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_user_GRN_SY_US_573 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
</div>
{/if}

</td>
</tr>
</table>

{/if}

</form>

{include file="grn/system_footer.tpl"}
