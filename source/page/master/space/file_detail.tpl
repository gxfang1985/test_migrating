{if ! $file_prefix}{assign var='file_prefix' value='space'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value=$file_prefix|cat:'/file_download'}{/if}

<!--menubar-->
<div id="main_menu_part">
    {if $comment}
        {if $loginId == $file.creator_uid || $hasPrivilege}
            {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
            <span class="menu_item">{capture name='grn_space_GRN_SP_FILE_1'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-1' replace='true'}{/capture}{grn_link page='space/file_delete' caption=$smarty.capture.grn_space_GRN_SP_FILE_1 image='delete20.gif' fid=$file.id id='lnk_delete' script='javascript:void(0)' alt=''}</span>
        {/if}
    {elseif $thread}
        {if $discnOperAuth || $hasPrivilege}
            <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}" aria-label="{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=space/application/discussion/file_upload fid=$file.id tid=$tid spid=$spid}';">{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}</button></span>
            <span class="menu_item">{capture name='grn_space_GRN_SP_FILE_3'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-3' replace='true'}{/capture}{grn_link page='space/application/discussion/file_modify' caption=$smarty.capture.grn_space_GRN_SP_FILE_3 image='modify20.gif' fid=$file.id tid=$tid spid=$spid alt=''}</span>
            {if $loginId == $file.creator_uid || $hasPrivilege}
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                <span class="menu_item">{capture name='grn_space_GRN_SP_FILE_4'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-4' replace='true'}{/capture}{grn_link page='space/file_delete' caption=$smarty.capture.grn_space_GRN_SP_FILE_4 image='delete20.gif' fid=$file.id tid=$tid spid=$spid id='lnk_delete' script='javascript:void(0)' alt=''}</span>
            {/if}
        {/if}
    {elseif $todo}
        {if $todoOperAuth || $hasPrivilege}
            <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}" aria-label="{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=space/application/todo/file_upload fid=$file.id tid=$tid spid=$spid from=$from}';">{cb_msg module='grn.space.file' key='GRN_SP_FILE-2' replace='true'}</button></span>
            <span class="menu_item">{capture name='grn_space_GRN_SP_FILE_3'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-3' replace='true'}{/capture}{grn_link page='space/application/todo/file_modify' caption=$smarty.capture.grn_space_GRN_SP_FILE_3 image='modify20.gif' fid=$file.id tid=$tid spid=$spid from=$from alt=''}</span>
            {if $loginId == $file.creator_uid || $hasPrivilege}
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                <span class="menu_item">{capture name='grn_space_GRN_SP_FILE_4'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-4' replace='true'}{/capture}{grn_link page='space/file_delete' caption=$smarty.capture.grn_space_GRN_SP_FILE_4 image='delete20.gif' fid=$file.id tid=$tid spid=$spid id='lnk_delete' script='javascript:void(0)' alt=''}</span>
            {/if}
        {/if}
    {/if}
</div>
<!--menubar_end-->
{grn_title title=$title class='inline_block_grn mBottom10' no_style=1}

{if $comment}
    <div class="sub_title">{cb_msg module='grn.space.file' key='GRN_SP_FILE-5' replace='true'}</div>
    <table class="view_table" width="80%">
        <colgroup>
            <col width="20%">
            <col width="80%">
        </colgroup>
        <tr>
            <th nowrap>{cb_msg module='grn.space.file' key='GRN_SP_FILE-6' replace='true'}</th>
            <td><a class="with_lang" href="{grn_pageurl page=$file_dpage params=$linkparams fid=$file.id postfix=$file.filename ticket=$download_ticket}">{$file.filename|escape:"html"}</a>&nbsp;&nbsp;({$file.mime})</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.space.file' key='GRN_SP_FILE-7' replace='true'}</th>
            <td>{grn_format_filesize size=$file.size unit="byte"}</td>
        </tr>
    </table>
    <p>
    <div class="sub_title">{cb_msg module='grn.space.file' key='GRN_SP_FILE-8' replace='true'}</div>
    <table class="view_table" width="80%">
        <colgroup>
            <col width="20%">
            <col width="80%">
        </colgroup>
        <tr>
            <th nowrap>{cb_msg module='grn.space.file' key='GRN_SP_FILE-9' replace='true'}</th>
            <td nowrap>{grn_space_user_link user=$spaceFile->getCreator()}&nbsp;{$spaceFile->getCreateDisplayDatetime()|escape}</td>
        </tr>
    </table>
{elseif $thread}
    {if !$discnOperAuth}
        {assign var="no_restore" value=true}
    {/if}
    {include file="grn/file_view.tpl" download_page=$file_prefix|cat:"/file_download" restore_page=$file_prefix|cat:"/application/discussion/file_restore" linkparams=$linkparams auth=$file.auth noframe=1 no_restore=$no_restore name_width=$config.name_width}
{elseif $todo}
    {if !$todoOperAuth}
        {assign var="no_restore" value=true}
    {/if}
    {include file="grn/file_view.tpl" download_page=$file_prefix|cat:"/file_download" restore_page=$file_prefix|cat:"/application/todo/file_restore" linkparams=$linkparams auth=$file.auth noframe=1 no_restore=$no_restore name_width=$config.name_width}
{/if}
