{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_1'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-1' replace='true'}{/capture}{grn_link image='write20.gif' page='portal/system/add' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_1}</span>
{if ! $portal_count}{assign var='disabled' value=1}{/if}
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_2'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-2' replace='true'}{/capture}{grn_link image='order20.gif' page='portal/system/order' list="1" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_2 disabled=$disabled}</span>
</div>

<p>
<table class="list_column">
 <colgroup>
  <col width="1%">
  <col width="40%">
  <col width="20%">
  <col width="20%">
  <col width="20%">
 </colgroup>
 <tr>
  <th>{include file='grn/checkall.tpl' elem_name='eid[]'}</th>
  <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-4' replace='true'}</th>
  <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-5' replace='true'}</th>
  <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-6' replace='true'}</th>
  <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-7' replace='true'}</th>
 </tr>
{foreach from=$portal_list key=key item=item}
 <tr>
  <td><input type="checkbox" name="eid[]" value="{$key}"></td>
  <td>{grn_link image='portal20.gif' page='portal/system/view' pid=$key caption=$item.name}</td>
  <td>{if $item.is_open}{grn_image image='check20.gif'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-8' replace='true'}{else}{grn_image image='spacer20.gif'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-9' replace='true'}{/if}</td>
  <td>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.portal.system' key='GRN_POT_SY-10' replace='true'}{if $item.security_model=='grant'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-11' replace='true'}{else}{cb_msg module='grn.portal.system' key='GRN_POT_SY-12' replace='true'}{/if}{cb_msg module='grn.portal.system' key='GRN_POT_SY-13' replace='true'}</td>
  <td align="right">{$item.access_count}</td>
 </tr>
{/foreach}
</table>
{cb_msg module='grn.portal.system' key='GRN_POT_SY-14' replace='true'}{capture name='grn_portal_system_GRN_POT_SY_15'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-15' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_portal_system_GRN_POT_SY_15 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}
</form>

{include file='grn/system_footer.tpl'}
