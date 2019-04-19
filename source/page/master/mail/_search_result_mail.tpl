{* チェックボタンと削除ボタンと移動先と結果表示テーブル *}
<form id="search-mail-result-form" name="search-mail-result-form" method="post" action="{grn_pageurl page='mail/command_index'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="aid" value="{$accountId}">
    <input type="hidden" name="cid" value="{$folderId}">
    <input type="hidden" id="search-mail-for-folder-tree" name="dcid" value="{$folderId}">
    <input type="hidden" name="cmd">
    <div class="search-listAreaOption-grn">
        <div id="search-mail-result" class="hidden">
            {include file='mail/_search_list_menu.tpl' position="top"}
            <table class="list_column" id="search-mail-result-table">
                <tbody id='search-mail-resultTable-body'>
                    <tr>
                        <th class="td-checkbox" id="search-result-checkbox-th"></th>
                        <th class="td-title" id="search-result-title-th">{cb_msg module='grn.mail' key='GRN_MAIL-361' replace='true'}</th>
                        <th class="td-name" id="search-result-name-th">{cb_msg module='grn.mail' key='GRN_MAIL-390' replace='true'}</th>
                        <th class="td-date" id="search-result-date-th">{cb_msg module='grn.mail' key='GRN_MAIL-391' replace='true'}</th>
                    </tr>
                </tbody>
            </table>
            {include file='mail/_search_list_menu.tpl' position="bottom"}
        </div>
    </div>
</form>