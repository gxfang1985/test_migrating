{**
 *  通知設定一覧のテンプレート
 *
 *  @param  array   notify.list     通知設定の一覧
 *  @param  bool    view_mode       通知設定表示のみ(削除を除く)かどうか
 *}
 <table class="admin_list_table">
    <colgroup>
        {if ! $view_mode}
            <col width="3%">
        {/if}
        <col width="97%">
    </colgroup>
    <tr>
        {if ! $view_mode}
            <th></th>
        {/if}
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-678' replace='true'}</th>
    </tr>
    {foreach from=$notify.list item=item}
        {assign var='value' value="`$item.type`:`$item.tid`"}
        <tr valign="middle">
            {if ! $view_mode}
                <td>{grn_checkbox name='eid[]' id='eid_`$value`' value=$value}</td>
            {/if}
            {if 'user' == $item.type}
                {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
                <td class="m_small">{grn_user_name uid=$item.tid users_list=$users_list users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
            {elseif 'group' == $item.type}
                {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
                <td class="m_small">{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
            {elseif 'static_role' == $item.type}
                <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
            {elseif 'dynamic_role' == $item.type}
                <td class="m_small">{grn_image image='role20.gif'}{$item.tid|escape}</td>
            {/if}
        </tr>
    {/foreach}
 </table>
