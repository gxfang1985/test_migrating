{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="grn/html/folder_select.js"}

<!--delete-->
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--delete-->

<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_46'}{cb_msg module='grn.memo' key='GRN_MEM-46' replace='true'}{/capture}{grn_link page='memo/modify' caption=$smarty.capture.grn_memo_GRN_MEM_46 image='modify20.gif' iid=$item_id element_id="memo-modify" alt=''}</span>
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_47'}{cb_msg module='grn.memo' key='GRN_MEM-47' replace='true'}{/capture}{grn_link page='memo/export' postfix='notitle.txt' caption=$smarty.capture.grn_memo_GRN_MEM_47 image='disk20.gif' iid=$item_id did=$folder.id alt=''}</span>
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_48'}{cb_msg module='grn.memo' key='GRN_MEM-48' replace='true'}{/capture}{grn_link page='memo/print' caption=$smarty.capture.grn_memo_GRN_MEM_48 image='print20.gif' iid=$item_id did=$folder.id alt=''}</span>
        <span class="menu_item">{capture name='grn_memo_GRN_MEM_49'}{cb_msg module='grn.memo' key='GRN_MEM-49' replace='true'}{/capture}{grn_link page='memo/delete' caption=$smarty.capture.grn_memo_GRN_MEM_49 image='delete20.gif' iid=$item_id aid=$article.aid id='memo_delete' script='javascript:void(0)' alt=''}</span>

        {assign var="form_name" value=$smarty.template|basename}
        <form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}" class="inline_block_grn">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="iid" value="{$item_id}">
            {capture name='grn_message_GRN_MEM_182'}{cb_msg module='grn.memo' key='GRN_MEM-182' replace='true'}{/capture}
            <select name="pdid" onchange="onChangeFolderSelect(this, null, 'move');" class="mLeft10 mRight5">
                <option value="-1">{$smarty.capture.grn_message_GRN_MEM_182}</option>
                <option value="">{cb_msg module='grn.memo' key='lastest_folder_name'}</option>
                {foreach from=$folder_menu key=id item=folder_name}
                    <option value="{$id|escape}">{$folder_name|escape}</option>
                {/foreach}
            </select>
            <span class="aButtonStandard-grn button_disable_filter_grn"><button id="move" type="button" tabindex="0" title="{cb_msg module='grn.memo' key='GRN_MEM-45' replace='true'}" aria-label="{cb_msg module='grn.memo' key='GRN_MEM-45' replace='true'}" aria-disabled="true" disabled onclick="submit(this.form)">{cb_msg module='grn.memo' key='GRN_MEM-45' replace='true'}</button></span>
        </form>
    </span>

    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{grn_title title=$content.title class='memo-title inline_block_grn mBottom10' no_style=1}

<div class="detail_info_base_grn">
    <table>
        <tr>
            <td align="right" nowrap>{cb_msg module='grn.memo' key='GRN_MEM-50' replace='true'}&nbsp;{cb_msg module='grn.memo' key='GRN_MEM-51' replace='true'}&nbsp;</td>
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
        <tr>
            <td align="right" nowrap>{cb_msg module='grn.memo' key='GRN_MEM-52' replace='true'}&nbsp;{cb_msg module='grn.memo' key='GRN_MEM-53' replace='true'}&nbsp;</td>
            <td>{$content.title|escape}</td>
        </tr>
        <tr>
            <td align="right" nowrap>{cb_msg module='grn.memo' key='GRN_MEM-54' replace='true'}&nbsp;{cb_msg module='grn.memo' key='GRN_MEM-55' replace='true'}&nbsp;</td>
            <td>{grn_date_format date=$content.ctime format="DateTimeMiddle_YMDW_HM"}</td>
        </tr>
        <tr>
            <td align="right" nowrap>{cb_msg module='grn.memo' key='GRN_MEM-56' replace='true'}&nbsp;{cb_msg module='grn.memo' key='GRN_MEM-57' replace='true'}&nbsp;</td>
            <td>{grn_date_format date=$content.mtime format="DateTimeMiddle_YMDW_HM"}</td>
        </tr>
    </table>
</div>

<div class="border-partition-common-grn"></div>

<div class="bodytext_base_grn" id="memo-contents">
    {if strlen($content.html)}{$content.html|grn_noescape}{else}{grn_format body=$content.data}{/if}
    <tt>
        {foreach from=$content.files item=file}
            <br>{grn_attach_file_link fid=$file.id dpage="memo/attached_file_download" vpage="memo/attached_file_view" name=$file.name size=$file.size mime=$file.mime did=$folder_id iid=$item_id inline=$config.inline hash=$file.hash}
        {/foreach}
    </tt>
</div>

<div class="space-partition-common-grn"></div>

<div class="list_menu">
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{include file="grn/footer.tpl"}
