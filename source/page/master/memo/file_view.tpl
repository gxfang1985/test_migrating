{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="grn/html/folder_select.js"}

<!--delete-->
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--delete-->

<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_8'}{cb_msg module='grn.memo' key='GRN_MEM-8' replace='true'}{/capture}{grn_link page='memo/file_modify' caption=$smarty.capture.grn_memo_GRN_MEM_8 image='modify20.gif' did=$folder_id iid=$item_id alt=''}</span>
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_9'}{cb_msg module='grn.memo' key='GRN_MEM-9' replace='true'}{/capture}{grn_link page='memo/file_upload' caption=$smarty.capture.grn_memo_GRN_MEM_9 image='modify20.gif' did=$folder_id iid=$item_id alt=''}</span>
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_10'}{cb_msg module='grn.memo' key='GRN_MEM-10' replace='true'}{/capture}{grn_link page='memo/file_delete' caption=$smarty.capture.grn_memo_GRN_MEM_10 image='delete20.gif' did=$folder_id iid=$item_id id='memo_file_delete' script='javascript:void(0)' alt=''}</span>

        {assign var="form_name" value=$smarty.template|basename}
        <form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}" class="inline_block_grn">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="did" value="{$folder_id}">
            <input type="hidden" name="iid" value="{$item_id}">

            {capture name='grn_message_GRN_MEM_182'}{cb_msg module='grn.memo' key='GRN_MEM-182' replace='true'}{/capture}
            <select name="pdid" onchange="onChangeFolderSelect(this, null, 'move');" class="mLeft10 mRight5">
                <option value="-1">{$smarty.capture.grn_message_GRN_MEM_182}</option>
                <option value="">{cb_msg module='grn.memo' key='lastest_folder_name'}</option>
                {foreach from=$folder_menu key=id item=folder_name}
                    <option value="{$id|escape}">{$folder_name|escape}</option>
                {/foreach}
            </select>
            <span class="aButtonStandard-grn button_disable_filter_grn"><button id="move" type="button" tabindex="0" title="{cb_msg module='grn.memo' key='GRN_MEM-7' replace='true'}" aria-label="{cb_msg module='grn.memo' key='GRN_MEM-7' replace='true'}" aria-disabled="true" disabled onclick="submit(this.form)">{cb_msg module='grn.memo' key='GRN_MEM-7' replace='true'}</button></span>
        </form>
    </span>

    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{if strlen($file.title)}
    {grn_title title=$file.title class='inline_block_grn mBottom10' no_style=1}
{else}
    {grn_title title=$file.filename class='inline_block_grn mBottom10' no_style=1}
{/if}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-11' replace='true'}</th>
        <td>
            {if $folder}
                {grn_image image='folder20.gif'}
                {foreach name="path" from=$folder.path key=id item=node}
                    {grn_link page='memo/index' caption=$node.name did=$id}&nbsp;&gt;&nbsp;
                {/foreach}
                {grn_link page='memo/index' caption=$folder.name did=$folder.id}
            {else}
                {grn_link page='memo/index' caption_module='grn.memo' caption_key='lastest_folder_name' image='folder20.gif'}
            {/if}
        </td>
    </tr>
</table>
<p></p>

{include file="grn/file_view.tpl" download_page="memo/file_download" restore_page="memo/file_restore" linkparams=$linkparams noframe=1}

{include file="grn/footer.tpl"}
