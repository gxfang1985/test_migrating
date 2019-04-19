<form name="mail/delete_multi_files" method="post" action="{grn_pageurl page='mail/command_delete_multi_files'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
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
        {cb_msg module='grn.mail' key='GRN_MAIL-481' replace='true'}<span class="bold delete_count"></span><br>
    </p>

    <input type="hidden" name="aid" value="{$category.aid}">
    <input type="hidden" name="cid" value="{$category.cid}">
</form>
