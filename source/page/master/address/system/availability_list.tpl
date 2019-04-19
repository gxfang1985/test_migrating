{**
 *  {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-1' replace='true'}
 *
 *  @param  array   page_info          {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-2' replace='true'}
 *  @param  strign  form_name          {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-3' replace='true'}
 *  @param  string  page_dir           {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-4' replace='true'}
 *  @param  string  page_prefix        {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-5' replace='true'}
 *  @param  string  base_prefix        {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-6' replace='true'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-7' replace='true'}
 *  @param  array   ours_params        {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-8' replace='true'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-9' replace='true'}
 *  @param  array   authority_name     {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-10' replace='true'}
 *  @param  array   access             {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-11' replace='true'}
 *  @param  array   access.list        {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-12' replace='true'}
 *  @param  string  poid               {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-13' replace='true'}
 *  @param  array   org                {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-14' replace='true'}
 *  @param  array   user_list          {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-15' replace='true'}
 *  @param  array   static_role_list   {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-16' replace='true'}
 *  @param  array   dynamic_role_list  {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-17' replace='true'}
 *  @param  string  text                {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-18' replace='true'}
 *  @param  boolean is_search           {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-19' replace='true'}
 *}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{assign var='page_dir' value='address/system'}
{assign var='page_prefix' value='address/system/'}
{assign var='base_prefix' value=''}
<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-20' replace='true'}
<br>
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-303' replace='true'}
</div>

<!-- {* include file='grn/availability_list.tpl' page_dir='address/system' page_prefix='address/system/' base_prefix='' *} -->
{if ! $authority_name}{capture name='grn_address_system_GRN_ADDR_SYS_21'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-21' replace='true'}{/capture}{assign var='authority_name' value=$smarty.capture.grn_address_system_GRN_ADDR_SYS_21}{/if}
<p>
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`availability_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">

 <table class="admin_list_table">
 <colgroup>
 <col width="30%">
 <col width="55%">
 <col width="15%">
 </colgroup>
 <tr>
 <th>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-23' replace='true'}</th>
 <td class="m_small" nowrap>
 {capture name='grn_address_system_GRN_ADDR_SYS_24'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-24' replace='true'}{/capture}{grn_radio name='security_model' id='grant'  value='grant'  caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_24 checked=$is_grant disabled=$is_revoke}<br>
 {capture name='grn_address_system_GRN_ADDR_SYS_25'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-25' replace='true'}{/capture}{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_25 checked=$is_revoke disabled=$is_grant}
 </td>
 <td class="m_small" nowrap>
 {capture name='grn_address_system_GRN_ADDR_SYS_26'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-26' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_model_modify1" params=$ours_params poid=$poid caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_26}
 </td>
 </tr>
 </table>

 <p>
 <div>
 <span class="sub_title">{$authority_name}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-27' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_address_system_GRN_ADDR_SYS_208'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-208' replace='true'}{/capture}{grn_link image='modify20.gif' page="address/system/availability_add" params=$ours_params reset=1 caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_208 }</span>
 <span class="m_small">{if 0 == $access.count}{assign var='disabled' value=true}{/if}{capture name='grn_address_system_GRN_ADDR_SYS_28'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-28' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`availability_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_28 disabled=$disabled}</span>
 </div>
 <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_address_system_GRN_ADDR_SYS_32'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-32' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_32 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="admin_list_table">
 <colgroup>
 <col width="3%">
 <col width="42%">
 <col width="55%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-29' replace='true'}</th>
 <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-30' replace='true'}</th>
 </tr>
{foreach from=$access.list item=item}
 {assign var='value' value="`$item.type`:`$item.tid`"}
 <tr valign="middle">
 <td>{grn_checkbox name='eid[]' id='eid_`$value`' value=$value}</td>
 {if 'user' == $item.type}
 {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
 <td class="m_small">{grn_user_name uid=$item.tid users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {elseif 'group' == $item.type}
 {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
 <td class="m_small">{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {elseif 'static_role' == $item.type}
 <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
 {elseif 'dynamic_role' == $item.type}
 <td class="m_small">{grn_image image='role20.gif'}{$item.tid|escape}</td>
 {/if}
 <td>{$item.data}<br></td>
 </td>
 </tr>
{/foreach}
 </table>
  <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_address_system_GRN_ADDR_SYS_32'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-32' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_32 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>

 </form>

</td>
<td width="30%"> 
</td>
</tr>
</table>

{include file="grn/system_footer.tpl"}
