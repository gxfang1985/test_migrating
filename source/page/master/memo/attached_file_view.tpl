{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_memo_GRN_MEM_136'}{cb_msg module='grn.memo' key='GRN_MEM-136' replace='true'}{/capture}{grn_link page='memo/attached_file_modify' caption=$smarty.capture.grn_memo_GRN_MEM_136 image='modify20.gif' did=$folder_id iid=$item_id fid=$file_id alt=''}</span>
    <span class="menu_item">{capture name='grn_memo_GRN_MEM_137'}{cb_msg module='grn.memo' key='GRN_MEM-137' replace='true'}{/capture}{grn_link page='memo/attached_file_upload' caption=$smarty.capture.grn_memo_GRN_MEM_137 image='modify20.gif' did=$folder_id iid=$item_id fid=$file_id alt=''}</span>
    <span class="menu_item">{capture name='grn_memo_GRN_MEM_138'}{cb_msg module='grn.memo' key='GRN_MEM-138' replace='true'}{/capture}{grn_link page='memo/attached_file_delete' caption=$smarty.capture.grn_memo_GRN_MEM_138 image='delete20.gif' did=$folder_id iid=$item_id fid=$file_id alt=''}</span>
</div>

{if strlen($file.title)}
    {grn_title title=$file.title class='inline_block_grn mBottom10' no_style=1}
{else}
    {grn_title title=$file.filename class='inline_block_grn mBottom10' no_style=1}
{/if}

{include file="grn/file_view.tpl" download_page="memo/attached_file_download" restore_page="memo/attached_file_restore" linkparams=$linkparams noframe=1}

{include file="grn/footer.tpl"}
