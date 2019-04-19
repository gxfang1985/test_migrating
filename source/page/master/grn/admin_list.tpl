{**
 *  基本システムの管理権限の一覧画面のテンプレート
 *
 *  @param  array   page_info           画面情報
 *  @param  strign  form_name           フォーム名
 *  @param  string  page_dir            一連の画面のディレクトリ名
 *  @param  string  page_prefix         一覧の画面名のプレフィックス
 *  @param  string  base_prefix         一覧の画面名のbasenameのプレフィックス
 *  @param  array   ours_params         一覧の画面共通のCGIパラメータ
 *  @param  array   access              アクセス権の設定状況
 *  @param  array   access.list         アクセス権の一覧
 *  @param  string  poid                現在の組織ID
 *  @param  array   org                 組織情報
 *  @param  array   user_list           所属ユーザー一覧
 *  @param  array   static_role_list    静的ロール一覧
 *  @param  array   dynamic_role_list   動的ロール一覧
 *  @param  string  add_explanation     追加説明
 *  @param  string  text                検索文字列
 *  @param  boolean is_search           検索結果かどうか
 *}

{if $add_explanation}
<p>
 <div class="explanation">{cb_msg module='grn.grn' key='GRN_GRN-1498' replace='true'}</div>
</p>
{/if}

<p>
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix``$base_prefix`admin_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">
 
<div>
 <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1036' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix``$add_page`" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 element_id="system-add"}</span>
  <span class="m_small">{capture name='grn_grn_GRN_GRN_1037'}{cb_msg module='grn.grn' key='GRN_GRN-1037' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix``$base_prefix`admin_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_1037 disabled=$disable_delete_all}</span>
 </div>
 <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="list_column">
 <colgroup>
 <col width="5%">
 <col width="80%">
 <col width="15%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1038' replace='true'}</th>
 <th nowrap>&nbsp;</th>
 </tr>
{foreach from=$access.list item=item}
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
 </td>
 <td class="m_small" nowrap>
  {capture name='grn_grn_GRN_GRN_1039'}{cb_msg module='grn.grn' key='GRN_GRN-1039' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix``$base_prefix`admin_modify" caption=$smarty.capture.grn_grn_GRN_GRN_1039 params=$ours_params poid=$poid itype=$item.type itid=$item.tid}
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
<td width="40%"> 
</td>
</tr>
</table>

