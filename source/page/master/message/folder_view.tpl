{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_message_GRN_MSG_65'}{cb_msg module='grn.message' key='GRN_MSG-65' replace='true'}{/capture}{grn_link page='message/folder_modify' caption=$smarty.capture.grn_message_GRN_MSG_65 image='write20.gif' cid=$category.cid alt=''}</span>
        {if $category.type eq null}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_66'}{cb_msg module='grn.message' key='GRN_MSG-66' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_GRN_MSG_66 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_67'}{cb_msg module='grn.message' key='GRN_MSG-67' replace='true'}{/capture}{grn_link page='message/folder_delete' caption=$smarty.capture.grn_message_GRN_MSG_67 image='delete20.gif' cid=$category.cid disabled='1' alt=''}</span>
        {/if}
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            <span class="button_base_grn">
                <form id="subscribe" name="subscribe" style="display: inline;" method="post" action="{grn_pageurl page='message/command_folder_view'}">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    <input type="hidden" name="subs" value="{if $category.subscribe == '1'}0{else}1{/if}">
                    <input type="hidden" name="cmd" value="subscribe">
                    <input type="hidden" name="cid" value="{$cid}">
                    <span class="aButtonStandard-grn">
                        <a onclick="jQuery('#wait_image').show();jQuery('#subscribe').submit();" href="javascript:void(0);" role="button">
                            <span>{if $category.subscribe == '1'}{cb_msg module='grn.message' key='GRN_MSG-63' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-64' replace='true'}{/if}</span>
                        </a>
                    </span>
                    <span id="wait_image" class="spinner_s_button_post_grn" style="display: none;"></span>
                </form>
            </span>
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->
{grn_title title=$category.title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.message' key='GRN_MSG-68' replace='true'}</th>
        <td>{grn_message_show_folder_position folder_id=$category.cid}</td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.message' key='GRN_MSG-69' replace='true'}</th>
        <td>{grn_format body=$category.memo}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.message' key='GRN_MSG-70' replace='true'}</th>
        <td>{if $category.subscribe}{cb_msg module='grn.message' key='GRN_MSG-71' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-72' replace='true'}{/if}</td>
    </tr>
</table>

{include file="grn/footer.tpl"}
