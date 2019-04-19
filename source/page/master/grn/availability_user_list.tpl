{**
 *  利用ユーザー設定の一覧画面のテンプレート
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
 *  @param  string  text               検索文字列
 *  @param  boolean is_search          検索結果かどうか
 *}
 {if ! $authority_name}{capture name='grn_grn_GRN_GRN_295'}{cb_msg module='grn.grn' key='GRN_GRN-295' replace='true'}{/capture}{assign var='authority_name' value=$smarty.capture.grn_grn_GRN_GRN_295}{/if}
<table width="100%">
<tr valign="top">
<td width="60%">

 <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`availability_user_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">

 <p>
 <div>
 <span class="sub_title">{$authority_name}{cb_msg module='grn.grn' key='GRN_GRN-297' replace='true'}&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-298' replace='true'}{$access.count}&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-299' replace='true'}</span>&nbsp;
 {if $access.count == 0}
  {assign var='disable_delete_all' value=true}
 {/if}
 <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_add" params=$ours_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
 <span class="m_small">{capture name='grn_grn_GRN_GRN_300'}{cb_msg module='grn.grn' key='GRN_GRN-300' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`availability_user_delete_all" params=$ours_params poid=$poid caption=$smarty.capture.grn_grn_GRN_GRN_300 disabled=$disable_delete_all}</span>
 </div>
  <div>
 <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp; 
 <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
 </div>
 <table class="list_column">
 <colgroup>
 <col width="3%">
 <col width="97%">
 </colgroup>
 <tr>
 <th></th>
 <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-301' replace='true'}</th>
 </tr>
{foreach from=$access item=target key=type_target}
{foreach from=$target item=data}
 <tr valign="middle">
 {if $type_target == 'dynamic_role'}
    {capture name='tmp'}{assign var=tmp value='dynamic_role:'|cat:$data._id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    <td class="m_small">{grn_image image='role20.gif'}{$data._id|escape}</td>
 {elseif $type_target == 'cb_role'}
    {capture name='tmp'}{assign var=tmp value='role:'|cat:$data._id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$data._id}</td>
 {elseif $type_target == 'cb_group'}
    {capture name='tmp'}{assign var=tmp value='group:'|cat:$data._id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    {capture name='grn_get_group_path_string_eid'}o_{$data._id}{/capture}
 <td class="m_small">{grn_organize_name gid=$data._id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {elseif $type_target == 'cb_user'}
    {capture name='tmp'}{assign var=tmp value='user:'|cat:$data._id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    {capture name='grn_get_group_path_string_eid'}u_{$data._id}{/capture}
 <td class="m_small">{grn_user_name uid=$data._id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
 {/if}
 </td>
 </tr>
 {/foreach}
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


