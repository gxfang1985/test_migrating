{* メール検索結果画面のメニューリスト *}
<div id="search-mail-list-menu-{$position}" class="list_menu">
    <nobr>
        <span class="mail-listCheckButton-grn" id="search-mail-checkAll-button-{$position}">
            <a href="javascript:void(0)">
                <span class="mail-listCheck-grn"></span>
            </a>
        </span>
        <span class="mail-listButtonDisable-grn" id="btn_delete_multi-{$position}">
            <a href="javascript:void(0)">
                {cb_msg module='grn.mail' key='GRN_MAIL-157' replace='true'}
            </a>
        </span>
        {capture name='search_move'}{cb_msg module='grn.mail' key='search-move' replace='true'}{/capture}
        {capture name='select_id'}dcid1-{$position}{/capture}
        {grn_mail_select_folders class="selectMove-grn selectMoveDisable-grn" select_name='move_value' select_id=$smarty.capture.select_id account_id=$accountId selected_folder_id=$folderId hide_root_folder=1 hide_garbage_folder=1 show_another_account=$showAnotherAccount exception_value='-1' exception_item=$smarty.capture.search_move default_selected='true'}
        <span class="mail-listButtonDisable-grn" id="btn_move_multi-{$position}">
            <a href="javascript:void(0)">
                {cb_msg module='grn.mail' key='GRN_MAIL-294' replace='true'}
            </a>
        </span>
    </nobr>
</div>