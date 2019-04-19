{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_message_GRN_MSG_301'}{cb_msg module='grn.message' key='GRN_MSG-301' replace='true'}{/capture}{grn_link page='message/draft_modify' caption=$smarty.capture.grn_message_GRN_MSG_301 image='modify20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}</span>
        <span class="menu_item">{capture name='grn_message_GRN_MSG_302'}{cb_msg module='grn.message' key='GRN_MSG-302' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_GRN_MSG_302 image='delete20.gif' script='javascript:void(0);' id='lnk_delete' alt=''}</span>
        <span class="menu_item">{capture name='grn_message_GRN_MSG_303'}{cb_msg module='grn.message' key='GRN_MSG-303' replace='true'}{/capture}{grn_link page='message/accessory' caption=$smarty.capture.grn_message_GRN_MSG_303 image='file20.gif' cid=$message.cid rid=$rid mid=$message.mid draft='1' alt=''}</span>

        {grn_load_javascript file="grn/html/folder_select.js"}
        <form name="top_move" method="post" action="{grn_pageurl page='message/command_view'}" class="inline_block_grn">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type='hidden' name='cmd' value="move">
            <input type='hidden' name='cid' value="{$message.cid}">
            <input type='hidden' name='rid' value="{$rid}">
            {capture name='grn_message_GRN_MSG_404'}{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}{/capture}
            {grn_message_select_folders select_name="dcid" select_id="dcid" hide_root_folder="1" hide_garbage_folder="1" exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MSG_404 onchange="onChangeFolderSelect(this, null, 'move');" class='mLeft10 mRight5'}
            <span class="aButtonStandard-grn button_disable_filter_grn"><button id="move" type="button" tabindex="0" title="{cb_msg module='grn.message' key='GRN_MSG-305' replace='true'}" aria-label="{cb_msg module='grn.message' key='GRN_MSG-305' replace='true'}" aria-disabled="true" disabled onclick="submit(this.form)">{cb_msg module='grn.message' key='GRN_MSG-305' replace='true'}</button></span>
        </form>
    </span>

    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$previous_navi_params next=$next_navi_params}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->

{if $use_star}
    {include file="star/star_init.tpl" list_id="message_list"}
    <div id="message_list">
        {grn_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid cid=$message.cid rid=$rid mid=$message.mid no_style=1}
{/if}
{grn_title title=$message.subject class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}
{if $use_star}</div>{/if}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr valign="top">
        <th>{cb_msg module='grn.message' key='GRN_MSG-306' replace='true'}</th>
        <td>{$message.addressee_num}{cb_msg module='grn.message' key='GRN_MSG-307' replace='true'}
            {foreach from=$message.addressee key=uid item=name}
                <span class="user_grn">{grn_user_name uid=$uid name=$name users_info=$users_info}</span>
            {/foreach}
        </td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.message' key='GRN_MSG-308' replace='true'}</th>
        <td>
            {if $message.format_type eq "0"}
                {grn_format body=$message.data}
            {else}
                {$message.data|grn_noescape}
            {/if}
            {if $message.attach_files}
                {foreach from=$message.attach_files item=attach_file}
                    <div>
                        <br>{grn_attach_file_link name=$attach_file.name dpage="message/file_download" vpage="message/file_view" tpage="message/file_image_view" size=$attach_file.size mime=$attach_file.mime cid=$message.cid rid=$rid mid=$message.mid rfid=$attach_file.rfid draft='1' hash=$attach_file.hash inline=$inline}
                    </div>
                {/foreach}
            {/if}
        </td>
    </tr>
    {if $message.need_confirm eq '1'}
        <tr>
            <th>{cb_msg module='grn.message' key='GRN_MSG-309' replace='true'}</th>
            <td>{capture name='grn_message_GRN_MSG_310'}{cb_msg module='grn.message' key='GRN_MSG-310' replace='true'}{/capture}{grn_link image='check16.gif' caption=$smarty.capture.grn_message_GRN_MSG_310 disabled=true}</td>
        </tr>
    {/if}
</table>

<div class="list_menu">
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$previous_navi_params next=$next_navi_params}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{include file="grn/footer.tpl"}
