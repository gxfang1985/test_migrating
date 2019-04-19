{**
 *  アクセス権の一覧画面のテンプレート
 *
 *  @param  array   page_info       画面情報
 *  @param  strign  form_name       フォーム名
 *  @param  string  page_dir        一連の画面のディレクトリ名
 *  @param  string  page_prefix     一覧の画面名のプレフィックス
 *  @param  string  base_prefix     一覧の画面名のbasenameのプレフィックス
 *  @param  array   ours_params     一覧の画面共通のCGIパラメータ
 *  @param  array   authority_types 権限の種類（連想配列）
 *  @param  int     authority_count 権限の種類数
 *  @param  array   access          アクセス権の設定状況
 *  @param  array   access.list     アクセス権の一覧
 *  @param  boolean is_grant        GRANTであるか
 *  @param  boolean is_revoke       REVOKEであるか
 *  @param  string  poid            現在の組織ID
 *  @param  array   org             組織情報
 *  @param  array   user_list       所属ユーザー一覧
 *  @param  array   static_role_list    静的ロール一覧
 *  @param  array   dynamic_role_list  動的ロール一覧
 *  @param  string  text            検索文字列
 *  @param  boolean is_search       検索結果かどうか
 *}
<p>
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`access_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
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
 <th>{cb_msg module='grn.grn' key='GRN_GRN-599' replace='true'}</th>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_600'}{cb_msg module='grn.grn' key='GRN_GRN-600' replace='true'}{/capture}{grn_radio name='security_model' id='grant'  value='grant'  caption=$smarty.capture.grn_grn_GRN_GRN_600 checked=$is_grant disabled=$is_revoke}<br>
 {capture name='grn_grn_GRN_GRN_601'}{cb_msg module='grn.grn' key='GRN_GRN-601' replace='true'}{/capture}{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.grn_grn_GRN_GRN_601 checked=$is_revoke disabled=$is_grant}
 </td>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_602'}{cb_msg module='grn.grn' key='GRN_GRN-602' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`access_model_modify1" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_602 element_id="`$page_prefix`access_model_modify1"}
 </td>
 </tr>
 </table>
 <p>
 <div>
 <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-603' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`access_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 element_id="`$page_prefix`access_add"}</span>
 <span class="m_small">{capture name='grn_grn_GRN_GRN_604'}{cb_msg module='grn.grn' key='GRN_GRN-604' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`access_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_604 disabled=$disable_delete_all element_id="`$page_prefix`access_delete_all"}</span>
 </div>
 <div class="list_menu">
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 {include file='grn/_access_list.tpl' page_prefix=$page_prefix}
 <div class="list_menu">
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>

 </form>

</td>
<td width="30%"> 
</td>
</tr>
</table>
