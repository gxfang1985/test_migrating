{**
 *  アクセス権一覧のテンプレート
 *
 *  @param  string  page_prefix     一覧の画面名のプレフィックス
 *  @param  array   ours_params     一覧の画面共通のCGIパラメータ
 *  @param  array   authority_types 権限の種類（連想配列）
 *  @param  int     authority_count 権限の種類数
 *  @param  array   access          アクセス権の設定状況
 *  @param  array   access.list     アクセス権の一覧
 *  @param  bool    view_mode       アクセス権表示のみ(削除/変更を除く)かどうか
 *}
<table class="admin_list_table">
    <colgroup>
        {if ! $view_mode}
        <col width="3%">
        {/if}
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
        {if $authority_count > 1 && ! $view_mode}
        <col width="15%">
        {/if}
    </colgroup>
    <tr>
        {if ! $view_mode}
            <th></th>
        {/if}
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-605' replace='true'}</th>
        {foreach from=$authority_types key=key item=item}
            <th style="text-align:center" nowrap>{$item|escape}</th>
        {/foreach}
        {if $authority_count > 1 && ! $view_mode}
            <th nowrap>&nbsp;</th>
        {/if}
    </tr>
    {foreach from=$access.list item=item}
        {assign var='value' value="`$item.type`:`$item.tid`"}
        <tr>
            {if ! $view_mode}
                <td>{grn_checkbox name='eid[]' id='eid_`$value`' value=$value}</td>
            {/if}
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
            {if 'grant' == $access.security_model}
                {foreach from=$authority_types key=key item=display_name}
                    <td class="tAlignCenter-grn">{if $item.data.$key}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-606' replace='true'}</span>{/if}</td>
                {/foreach}
            {else}
                {foreach from=$authority_types key=key item=display_name}
                    <td class="tAlignCenter-grn">{if ! $item.data.$key}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-607' replace='true'}</span>{/if}</td>
                {/foreach}
            {/if}
            {if $authority_count > 1 && ! $view_mode}
                <td class="m_small" nowrap>
                    {capture name='grn_grn_GRN_GRN_608'}{cb_msg module='grn.grn' key='GRN_GRN-608' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`access_modify" caption=$smarty.capture.grn_grn_GRN_GRN_608 params=$ours_params poid=$poid itype=$item.type itid=$item.tid}
                </td>
            {/if}
        </tr>
    {/foreach}
 </table>
