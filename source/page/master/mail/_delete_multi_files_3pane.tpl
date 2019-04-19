<div id="mail_delete_multi_files_content" style="display: none">
    <p>
    <table class="view_table" width="80%">
        <colgroup>
            <col width="20%">
            <col width="80%">
        </colgroup>
    </table>
    {if $category.type eq '2'}
        <div>{cb_msg module='grn.mail' key='GRN_MAIL-476' replace='true'}</div>
    {else}
        <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-476' replace='true'}
            <div class="explanation_list_grn mTop7">
                <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-477' replace='true'}</span>
                <ul>
                    <li>{cb_msg module='grn.mail' key='GRN_MAIL-478' replace='true'}</li>
                    <li>{cb_msg module='grn.mail' key='GRN_MAIL-479' replace='true'}</li>
                    <li>{cb_msg module='grn.mail' key='GRN_MAIL-480' replace='true'}</li>
                </ul>
            </div>
        </div>
    {/if}
        <br>
        {cb_msg module='grn.mail' key='GRN_MAIL-481' replace='true'}<span class="bold multi_files_delete_count"></span><br>
    </p>
    <span style="display: none" id="mail_delete_multi_files_title">{$delete_info_multi_files.title}</span>
</div>
