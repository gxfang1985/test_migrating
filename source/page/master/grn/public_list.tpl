{**
 *  公開設定の一覧画面のテンプレート
 *
 *  @param  array   page_info       画面情報
 *  @param  strign  form_name       フォーム名
 *  @param  string  page_dir        一連の画面のディレクトリ名
 *  @param  string  page_prefix     一覧の画面名のプレフィックス
 *  @param  string  base_prefix     一覧の画面名のbasenameのプレフィックス
 *  @param  array   ours_params     一覧の画面共通のCGIパラメータ
 *  @param  array   authority_types 権限の種類（連想配列）
 *  @param  int     authority_count 権限の種類数
 *  @param  array   public          公開設定の状況
 *  @param  array   public.list     公開設定の一覧
 *  @param  boolean is_grant        GRANTであるか
 *  @param  boolean is_revoke       REVOKEであるか
 *  @param  string  poid            現在の組織ID
 *  @param  array   org             組織情報
 *  @param  array   user_list       所属ユーザー一覧
 *  @param  array   static_role_list    静的ロール一覧
 *  @param  array   dynamic_role_list   動的ロール一覧
 *  @param  string  text            検索文字列
 *  @param  boolean is_search       検索結果かどうか
 *}
 
<p>
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`public_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
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
 <th>{cb_msg module='grn.grn' key='GRN_GRN-1428' replace='true'}</th>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_1429'}{cb_msg module='grn.grn' key='GRN_GRN-1429' replace='true'}{/capture}{grn_radio name='security_model' id='grant'  value='grant'  caption=$smarty.capture.grn_grn_GRN_GRN_1429 checked=$is_grant disabled=$is_revoke}<br>
 {capture name='grn_grn_GRN_GRN_1430'}{cb_msg module='grn.grn' key='GRN_GRN-1430' replace='true'}{/capture}{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.grn_grn_GRN_GRN_1430 checked=$is_revoke disabled=$is_grant}
 </td>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_1431'}{cb_msg module='grn.grn' key='GRN_GRN-1431' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`public_model_modify1" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_1431}
 </td>
 </tr>
 </table>
 
 <p>
 <div>
 <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1432' replace='true'}</span>&nbsp; 
 {if $public.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`public_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1433'}{cb_msg module='grn.grn' key='GRN_GRN-1433' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`public_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_1433 disabled=$disable_delete_all}</span>
 </div>
  <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="admin_list_table">
 <colgroup>
 <col width="3%">
 <col width="42%">
{if $authority_count == 1}
 <col width="20%" align="center">
{elseif $authority_count == 2}
 <col width="20%" align="center">
 <col width="20%" align="center">
{elseif $authority_count == 3}
 <col width="13%" align="center">
 <col width="13%" align="center">
 <col width="13%" align="center">
{elseif $authority_count == 4}
 <col width="10%" align="center">
 <col width="10%" align="center">
 <col width="10%" align="center">
 <col width="10%" align="center">
{elseif $authority_count == 5}
 <col width="8%" align="center">
 <col width="8%" align="center">
 <col width="8%" align="center">
 <col width="8%" align="center">
 <col width="8%" align="center">
{/if}
{if $authority_count > 1}
 <col width="15%">
 </colgroup>
{/if}
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1434' replace='true'}</th>
{foreach from=$authority_types key=key item=item}
 <th style="text-align:center" nowrap>{$item|escape}</th>
{/foreach}
{if $authority_count > 1}
 <th nowrap>&nbsp;</th>
{/if}
 </tr>
{foreach from=$public.list item=item}
 {assign var='value' value="`$item.type`:`$item.tid`"}
 <tr>
 <td>{grn_checkbox name='eid[]' id='eid_`$value`' value=$value}</td>
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
 {if 'grant' == $public.security_model}
  {foreach from=$authority_types key=key item=display_name}
 <td align="center">{if $item.data.$key}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-1435' replace='true'}</span>{/if}</td>
  {/foreach}
 {else}
  {foreach from=$authority_types key=key item=display_name}
 <td align="center">{if ! $item.data.$key}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-1436' replace='true'}</span>{/if}</td>
  {/foreach}
 {/if}
 </td>
 {if $authority_count > 1}
 <td class="m_small" nowrap>
  {capture name='grn_grn_GRN_GRN_1437'}{cb_msg module='grn.grn' key='GRN_GRN-1437' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`public_modify" caption=$smarty.capture.grn_grn_GRN_GRN_1437 params=$ours_params poid=$poid itype=$item.type itid=$item.tid}
 </td>
 {/if}
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
