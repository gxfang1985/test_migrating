{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{grn_delete title=$delete_multi.title page=$delete_multi.page handler=$delete_multi.handler data=$delete_multi.data multi_target=$delete_multi.multi_target form_target=$delete_multi.form_target}
{grn_delete title=$delete_all.title page=$delete_all.page handler=$delete_all.handler data=$delete_all.data}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_1'}{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_1' app_name=$app_name noescape='true'}{/capture}{grn_link image='write20.gif' page='portal/personal/add' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_1}</span>
{if ! $portal_count}
 {assign var='disabled' value=1}
 {grn_delete title=$delete_multi.title page=$delete_multi.page handler=$delete_multi.handler data=$delete_multi.data multi_target=$delete_multi.multi_target form_target=$delete_multi.form_target}
 {grn_delete title=$delete_all.title page=$delete_all.page handler=$delete_all.handler data=$delete_all.data}
{/if}
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_2'}{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_2' app_name=$app_name noescape='true'}{/capture}{grn_link image='order20.gif' page='portal/personal/order' list="1" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_2 disabled=$disabled}</span>
</div>

<p>
<table class="admin_list_table">
 <colgroup>
  <col width="1%">
  <col width="100%">
 </colgroup>
 <tr>
  <th>{include file='grn/checkall.tpl' elem_name='eid[]'}</th>
  <th>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|escape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-5' replace='true'}</th>
 </tr>
{foreach from=$portal_list key=key item=item}
 <tr>
  <td><input type="checkbox" name="eid[]" value="{$key}"></td>
  <td>{grn_link image='portal20.gif' page='portal/personal/view' pid=$key caption=$item.name}</td>
 </tr>
{/foreach}
</table>
{capture name='grn_portal_personal_GRN_POT_PE_6'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-6' replace='true'}{/capture}{grn_button_submit id='btn_delete_multi' class='margin' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_6 onclick="return false;"}
</form>

{include file='grn/personal_footer.tpl'}
