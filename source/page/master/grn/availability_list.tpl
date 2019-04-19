{**
 *  使用権限の一覧画面のテンプレート
 *
 *  @param  array   page_info          画面情報
 *  @param  strign  form_name          フォーム名
 *  @param  string  page_dir           一連の画面のディレクトリ名
 *  @param  string  page_prefix        一覧の画面名のプレフィックス
 *  @param  string  base_prefix        一覧の画面名のbasenameのプレフィックス
 *  @param  array   ours_params        一覧の画面共通のCGIパラメータ
 *  @param  array   authority_name     権限の名前
 *  @param  array   access             使用権限の設定状況
 *  @param  array   access.list        使用権限の一覧
 *  @param  string  poid               現在の組織ID
 *  @param  array   org                組織情報
 *  @param  array   user_list          所属ユーザー一覧
 *  @param  array   static_role_list   静的ロール一覧
 *  @param  array   dynamic_role_list  動的ロール一覧
 *  @param  string  text               検索文字列
 *  @param  boolean is_search          検索結果かどうか
 *}
{if ! $authority_name}{capture name='grn_grn_GRN_GRN_463'}{cb_msg module='grn.grn' key='GRN_GRN-463' replace='true'}{/capture}{assign var='authority_name' value=$smarty.capture.grn_grn_GRN_GRN_463}{/if}
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
 <th>{cb_msg module='grn.grn' key='GRN_GRN-465' replace='true'}</th>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_466'}{cb_msg module='grn.grn' key='GRN_GRN-466' replace='true'}{/capture}{grn_radio name='security_model' id='grant'  value='grant'  caption=$smarty.capture.grn_grn_GRN_GRN_466 checked=$is_grant disabled=$is_revoke}<br>
 {capture name='grn_grn_GRN_GRN_467'}{cb_msg module='grn.grn' key='GRN_GRN-467' replace='true'}{/capture}{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.grn_grn_GRN_GRN_467 checked=$is_revoke disabled=$is_grant}
 </td>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_468'}{cb_msg module='grn.grn' key='GRN_GRN-468' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_model_modify1" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_468}
 </td>
 </tr>
 </table>

 <p>
 <div>
 <span class="sub_title">{$authority_name}{cb_msg module='grn.grn' key='GRN_GRN-469' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
 <span class="m_small">{capture name='grn_grn_GRN_GRN_470'}{cb_msg module='grn.grn' key='GRN_GRN-470' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`availability_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_470 disabled=$disable_delete_all}</span>
 </div>
 <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="admin_list_table">
 <colgroup>
 <col width="5%">
 <col width="40%">
 <col width="55%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-471' replace='true'}</th>
 <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-472' replace='true'}</th>
 </tr>
{foreach from=$access.list item=item}
 {assign var='value' value="`$item.type`:`$item.tid`"}
 <tr valign="middle">
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
 {if 'grant' == $access.security_model}
 <td>{if $item.data}{cb_msg module='grn.grn' key='GRN_GRN-473' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-474' replace='true'}{/if}<br></td>
 {else}
 <td>{if ! $item.data}{cb_msg module='grn.grn' key='GRN_GRN-475' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-476' replace='true'}{/if}<br></td>
 {/if}
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

