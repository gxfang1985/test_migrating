{**
 *  通知設定の一覧画面のテンプレート
 *
 *  @param  array   page_info       画面情報
 *  @param  strign  form_name       フォーム名
 *  @param  string  page_dir        一連の画面のディレクトリ名
 *  @param  string  page_prefix     一覧の画面名のプレフィックス
 *  @param  string  base_prefix     一覧の画面名のbasenameのプレフィックス
 *  @param  array   ours_params     一覧の画面共通のCGIパラメータ
 *  @param  array   notify          通知の設定状況
 *  @param  array   notify.list     通知設定の一覧
 *  @param  boolean force           強制通知であるか
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

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`notify_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">

{if $enable_force}
 <table class="admin_list_table">
 <colgroup>
 <col width="30%">
 <col width="55%">
 <col width="15%">
 </colgroup>
 <tr>
 <th>{cb_msg module='grn.grn' key='GRN_GRN-671' replace='true'}</th>
 <td class="m_small" nowrap>
{if $notify.force}
 {assign var='is_force' value='1'}
 {assign var='is_not_force' value='0'}
{else}
 {assign var='is_force' value='0'}
 {assign var='is_not_force' value='1'}
{/if}
{capture name='grn_grn_GRN_GRN_672'}{cb_msg module='grn.grn' key='GRN_GRN-672' replace='true'}{/capture}{grn_radio name='force' id='0' value='0' caption=$smarty.capture.grn_grn_GRN_GRN_672   checked=$is_not_force disabled=$is_force}<br>
{capture name='grn_grn_GRN_GRN_673'}{cb_msg module='grn.grn' key='GRN_GRN-673' replace='true'}{/capture}{grn_radio name='force' id='1' value='1' caption="ON "|cat:$smarty.capture.grn_grn_GRN_GRN_673 checked=$is_force disabled=$is_not_force}<br>
 </td>
 <td class="m_small" nowrap>
 {capture name='grn_grn_GRN_GRN_674'}{cb_msg module='grn.grn' key='GRN_GRN-674' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`notify_force_modify" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_674}
 </td>
 </tr>
 </table>
 <p>
{/if}
 <div>
 <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-675' replace='true'}</span>&nbsp; 
 {if $access.count == 0}
  {assign var='disable_delete_all' value=TRUE}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`notify_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
 {if count($notify.list)}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_676'}{cb_msg module='grn.grn' key='GRN_GRN-676' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`notify_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_676}</span>
{else}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_677'}{cb_msg module='grn.grn' key='GRN_GRN-677' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`notify_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_677 disabled=1}</span>
{/if}
 </div>
  <div class="list_menu">
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 {include file='grn/_notify_list.tpl'}
 <div class="list_menu">
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 </form>

</td>
<td width="40%">
</td>
</tr>
</table>

