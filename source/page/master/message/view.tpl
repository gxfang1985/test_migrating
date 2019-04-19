{if $message.is_snapshot neq '1' and $folder_type neq '4'}
    {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
        {assign var="hide_follow_input" value="1"}
    {else}
        {assign var="hide_follow_input" value=""}
    {/if}
{/if}
{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{include file='grn/window_simple_dialog.tpl'}
{grn_load_javascript file="grn/html/component/member_list_dialog.js"}
{grn_load_javascript file="js/dist/message.js"}
<!--delete-->
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
{grn_delete title=$delete_follow.title page=$delete_follow.page no_confirm=$delete_follow.no_confirm data=$delete_follow.data handler=$delete_follow.handler before_delete=$delete_follow.before_delete}
<!--delete-->
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $regard_operator}
            {if $folder_type neq '4'}
                <span class="menu_item">{capture name='grn_message_GRN_MSG_85'}{cb_msg module='grn.message' key='GRN_MSG-85' replace='true'}{/capture}{grn_link page='message/modify' caption=$smarty.capture.grn_message_GRN_MSG_85 image='modify20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}</span>
                <span class="menu_item">{capture name='grn_message_GRN_MSG_86'}{cb_msg module='grn.message' key='GRN_MSG-86' replace='true'}{/capture}{grn_link page='message/address_modify' caption=$smarty.capture.grn_message_GRN_MSG_86 image='user20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}</span>
            {else}
                <span class="menu_item">{capture name='grn_message_GRN_MSG_87'}{cb_msg module='grn.message' key='GRN_MSG-87' replace='true'}{/capture}{grn_link page='message/modify' caption=$smarty.capture.grn_message_GRN_MSG_87 image='modify20.gif' cid=$message.cid rid=$rid mid=$message.mid disabled=1 alt=''}</span>
                <span class="menu_item">{capture name='grn_message_GRN_MSG_88'}{cb_msg module='grn.message' key='GRN_MSG-88' replace='true'}{/capture}{grn_link page='message/address_modify' caption=$smarty.capture.grn_message_GRN_MSG_88 image='user20.gif' cid=$message.cid rid=$rid mid=$message.mid disabled=1 alt=''}</span>
            {/if}
        {/if}
        <span class="menu_item">{capture name='grn_message_GRN_MSG_89'}{cb_msg module='grn.message' key='GRN_MSG-89' replace='true'}{/capture}{grn_link page='message/accessory' caption=$smarty.capture.grn_message_GRN_MSG_89 image='file20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}</span>
        <span class="menu_item">{capture name='grn_message_GRN_MSG_90'}{cb_msg module='grn.message' key='GRN_MSG-90' replace='true'}{/capture}{grn_link page='message/reuse' caption=$smarty.capture.grn_message_GRN_MSG_90 image='reuse20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}</span>
        <span class="menu_item">{capture name='grn_message_GRN_MSG_94'}{cb_msg module='grn.message' key='GRN_MSG-94' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_GRN_MSG_94 image='delete20.gif' id='lnk_delete' script='javascript:void(0);' alt=''}</span>
        <span class="menu_item">
            {include file='message/_message_detail_option_pulldown.tpl'}
        </span>

        {grn_load_javascript file="grn/html/folder_select.js"}
        <form name="top_move" method="post" action="{grn_pageurl page='message/command_view'}" class="inline_block_grn">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type='hidden' name='cmd' value="move">
            <input type='hidden' name='cid' value="{$message.cid}">
            <input type='hidden' name='rid' value="{$rid}">
            {capture name='grn_message_GRN_MSG_404'}{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}{/capture}
            {grn_message_select_folders select_name="dcid" select_id="dcid" hide_root_folder="1" hide_garbage_folder="1" exeption_value="-1" exception_item=$smarty.capture.grn_message_GRN_MSG_404 onchange="onChangeFolderSelect(this, null, 'move');" class='mLeft10 mRight5'}
            <span class="aButtonStandard-grn button_disable_filter_grn"><button id="move" type="button" tabindex="0" title="{cb_msg module='grn.message' key='GRN_MSG-96' replace='true'}" aria-label="{cb_msg module='grn.message' key='GRN_MSG-96' replace='true'}" aria-disabled="true" disabled onclick="submit(this.form)">{cb_msg module='grn.message' key='GRN_MSG-96' replace='true'}</button></span>
        </form>
    </span>

    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {include file="message/_view_subscription.tpl"}
            {grn_previous_next_navi previous=$previous_navi_params next=$next_navi_params}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->

{if $use_star}
    {include file="star/star_init.tpl" list_id="message_star_list"}
    <div id="message_star_list">
        {grn_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid mid=$message.mid cid=$message.cid rid=$rid no_style=1}
{/if}
{grn_title title=$message.subject class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
{if $use_star}
    </div>
{/if}

<!--view-->
{if $message.is_snapshot eq '1' }
    <div class="br"><div class="border-partition-common-grn"></div></div>
    <div class="explanation">
        {cb_msg module='grn.message' key='GRN_MSG-99' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-100' replace='true'}{if $editor_uid}{cb_msg module='grn.message' key='GRN_MSG-101' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-102' replace='true'}{/if}{cb_msg module='grn.message' key='GRN_MSG-103' replace='true'}<br>
        {cb_msg module='grn.message' key='GRN_MSG-104' replace='true'}<br>
        <span class="bold">{cb_msg module='grn.message' key='GRN_MSG-105' replace='true'}&nbsp;{grn_date_format date=$message.delete_time format="DateTimeMiddle_YMDW_HM"}</span>
    </div>
    <div class="br"><div class="border-partition-common-grn"></div></div>
{/if}

{assign var="can_follow" value=0}
{if $message.is_snapshot neq '1' and $folder_type neq '4'}
    {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
    {else}
        {assign var="can_follow" value=1}
    {/if}
{else}
    {assign var="can_follow" value=0}
{/if}

<div id="info_area">
    <table>
        <tr>
            <td nowrap>{cb_msg module='grn.message' key='GRN_MSG-106' replace='true'}</td><td>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-107' replace='true'}&nbsp;</td>
            <td>{grn_user_name uid=$message.creator_uid name=$message.creator_name users_info=$users_info}&nbsp;{grn_date_format date=$message.ctime format="DateTimeMiddle_YMDW_HM"}</td>
        </tr>
        {if $message.mtime neq '' && $message.modifier_uid neq ''}
            <tr>
                <td nowrap>{cb_msg module='grn.message' key='GRN_MSG-108' replace='true'}</td><td>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-109' replace='true'}&nbsp;</td>
                <td>{grn_user_name uid=$message.modifier_uid name=$message.modifier_name users_info=$users_}&nbsp;{grn_date_format date=$message.mtime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
        {/if}
        <tr valign="top">
            <td nowrap>{cb_msg module='grn.message' key='GRN_MSG-110' replace='true'}{if $message.addressee_num > 10}&nbsp;<a href="javascript:void(0);display_on_off('display_addressee_close:display_addressee_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open">{capture name='grn_message_GRN_MSG_111'}{cb_msg module='grn.message' key='GRN_MSG-111' replace='true'}{/capture}{capture name='grn_message_GRN_MSG_112'}{cb_msg module='grn.message' key='GRN_MSG-112' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_message_GRN_MSG_111 title=$smarty.capture.grn_message_GRN_MSG_112}</span><span id="display_swith_image_close" style="display:none;">{capture name='grn_message_GRN_MSG_113'}{cb_msg module='grn.message' key='GRN_MSG-113' replace='true'}{/capture}{capture name='grn_message_GRN_MSG_114'}{cb_msg module='grn.message' key='GRN_MSG-114' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_message_GRN_MSG_113 title=$smarty.capture.grn_message_GRN_MSG_114}</span></a>{/if}</td><td>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-115' replace='true'}&nbsp;</td>
            <td>
                {grn_message_addressee message=$message}
                <small>
                    <div>
                        {capture name='grn_message_GRN_MSG_379'}{cb_msg module='grn.message' key='GRN_MSG-379' replace='true'}{/capture}{grn_link page='message/detail_address' caption=$smarty.capture.grn_message_GRN_MSG_379 image='detail20.gif' cid=$message.cid rid=$rid mid=$message.mid}
                    </div>
                </small>
            </td>
        </tr>
    </table>
    <div class="border-partition-common-grn"></div>
    {if $message.update eq "0"}<div class="unread_color">{else}<div class="bodytext_base_grn">{/if}
    <div class="margin_all">
        {if $message.format_type eq "0"}
            {grn_format body=$message.data}
        {else}
            {$message.data|grn_noescape}
        {/if}
    </div>

    {if $message.attach_files}
        <p>
        <tt>
            {foreach from=$message.attach_files item=attach_file}
                {if strlen($attach_file.name)}
                    {grn_attach_file_link name=$attach_file.name dpage="message/file_download" vpage="message/file_view" tpage="message/file_image_view" size=$attach_file.size mime=$attach_file.mime cid=$message.cid rid=$rid mid=$message.mid rfid=$attach_file.rfid inline=$inline hash=$attach_file.hash}<br>
                {/if}
            {/foreach}
        </tt>
    {/if}

    {if $message.del_file_num gt 0}
        <p>
        {cb_msg module='grn.message' key='GRN_MSG-116' replace='true'}&nbsp;<span class="bold">{$message.del_file_num}</span>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-117' replace='true'}
    {/if}
    </div>
</div>

<div class="list_menu">
    {if $can_follow}
        <div class="float_left">
            <div class="bodytext_footer_grn mLeft10 mTop5">
                {include file="grn/_favour.tpl"}
            </div>
        </div>
    {/if}
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$previous_navi_params next=$next_navi_params}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<div class="border-partition-common-grn"></div>

{if $message.is_snapshot neq '1' and $folder_type neq '4'}
    {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
        <div class="sub_title">{cb_msg module='grn' key='grn.comment' replace='true'}</div>
        <form name="follow_form" id="follow_form_message_comment" method="post" action="{grn_pageurl page='message/command_view'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <div id="error_msg_follow_comment" style="display: none;"></div>
            <p>{cb_msg module='grn.message' key='GRN_MSG-119A' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-119B' replace='true'}<span class="bold">{cb_msg module='grn.message' key='GRN_MSG-120' replace='true'}</span>{cb_msg module='grn.message' key='GRN_MSG-121' replace='true'}<br>
            {cb_msg module='grn.message' key='GRN_MSG-122' replace='true'}<span class="bold">{cb_msg module='grn.message' key='GRN_MSG-123' replace='true'}</span>{cb_msg module='grn.message' key='GRN_MSG-124' replace='true'}  </p>
            <input type=submit value="{cb_msg module='grn.message' key='GRN_MSG-125' replace='true'}" onclick="cmd.value='confirm';">
            <input type="hidden" name="cmd">
            <input type="hidden" name="cid" value="{$message.cid}">
            <input type="hidden" name="rid" value="{$rid}">
            <input type="hidden" name="mid" value="{$message.mid}">
        </form>
    {else}
        <div class="comment_std_grn detail_comment_grn">
        <form name="follow_form" id="follow_form_message_comment" method="post" action="{grn_pageurl page='message/command_view'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <div id="error_msg_follow_comment" style="display: none;"></div>
            {include file="grn/richeditor.tpl" html=$html enable=$use_editor class="form_textarea_grn"
                mention=TRUE
                app_id="message"
                mention_params=$mention_params
                mention_access_plugin_encoded=$mention_access_plugin_encoded}
            {include file="grn/attach_file35.tpl" disable_return_key=true isFollow=TRUE fbox_id="message_comment"}
            <div class="mTop5 mBottom20">
                {capture name='grn_message_GRN_MSG_126'}{cb_msg module='grn.message' key='GRN_MSG-126' replace='true'}{/capture}
                {grn_button ui="main" caption=$smarty.capture.grn_message_GRN_MSG_126 onclick="" id="message_comment_button_save" class="js_message_comment"}
            </div>
            <input type="hidden" name="cmd">
            <input type="hidden" name="cid" value="{$message.cid}">
            <input type="hidden" name="rid" value="{$rid}">
            <input type="hidden" name="mid" value="{$message.mid}">
            <input type="hidden" name="mention" />
        </form>
        </div>
    {/if}
    <div class="border-partition-common-grn"></div>
{/if}

{if $message.need_confirm eq '1'}{cb_msg module='grn.message' key='GRN_MSG-127' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-128' replace='true'}{/if}
{if $message.need_confirm eq '1'}
    {cb_msg module='grn.message' key='GRN_MSG-129' replace='true'}{$message.confirmed_num}/{$message.all_addressees}{cb_msg module='grn.message' key='GRN_MSG-130' replace='true'}&nbsp;{capture name='grn_message_GRN_MSG_131'}{cb_msg module='grn.message' key='GRN_MSG-131' replace='true'}{/capture}{grn_link image='detail20.gif' caption=$smarty.capture.grn_message_GRN_MSG_131 page='message/read_status' cid=$message.cid rid=$rid mid=$message.mid}
{else}
    {cb_msg module='grn.message' key='GRN_MSG-132' replace='true'}{$message.follow_write_num}/{$message.all_addressees}{cb_msg module='grn.message' key='GRN_MSG-133' replace='true'}&nbsp;{capture name='grn_message_GRN_MSG_134'}{cb_msg module='grn.message' key='GRN_MSG-134' replace='true'}{/capture}{grn_link image='detail20.gif' caption=$smarty.capture.grn_message_GRN_MSG_134 page='message/write_status' cid=$message.cid rid=$rid mid=$message.mid}
{/if}

{grn_load_javascript file="grn/html/component/validator.js"}
{if $message.follow}
{include file="grn/error_handler.tpl"}
{grn_load_css file="grn/html/image_grn.css"}
{grn_load_javascript file="grn/html/reply.js"}
{literal}
<script type="text/javascript">
var __replyComment = grn.page.comment.reply;
</script>
<script language="javascript" type="text/javascript">
__replyComment.threadCommentAddUrl = {/literal}'{grn_pageurl page="message/command_reply"}'{literal};
__replyComment.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
</script>
{/literal}
<div id="message_comments">
    <div class="border-partition-common-grn"></div>
    <a name="follow"></a>
    {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    <div class="border-partition-common-grn"></div>
    {foreach from=$message.follow item=follow name=commentlist}
        <div class="comment_main_grn contents_area {if $follow.update eq "0"}unread_color{/if} js_comment"
             id="thread_comment_{$follow.follow_id}"
             onmouseenter="__replyComment.selectComment({$follow.follow_id})"
             onmouseleave="__replyComment.unselectComment({$follow.follow_id})"
             data-comment-no="{$follow.id}"
             data-comment-id="{$follow.follow_id}">

            <div class="profileImageBase-grn">
        {if $imageIcon}
                <table class="comment_base_grn">
                    <tr>
                        <td class="vAlignTop-grn sub_grn" style="width:1%;">
                            {assign var='userId' value=$follow.creator_uid}
                            {grn_user_image_icon userInfo=$users_info.$userId photoUrl=$users_info.$userId.photoUrl userId=$userId loginId=$user_id size=$iconSize alt=$follow.creator_name}
                        </td>
                        <td class="vAlignTop-grn">
        {/if}
                            <table class="comment_base_grn">
                                <tr>
                                    <td class="vAlignTop-grn sub_grn nowrap-grn" style="width:60%;">
        {if $imageIcon}
                                        <span class="commentNum-grn">{$follow.id}:</span><span class="username_grn" data-user-id="{$follow.creator_uid}">{grn_user_name uid=$follow.creator_uid users_info=$users_info name=$follow.creator_name|cb_mb_truncate:$name_width noimage=true}</span><span class="commentDate-grn">{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}</span>
        {else}
                                        {$follow.id}&nbsp;:<span class="username_grn" data-user-id="{$follow.creator_uid}">{grn_user_name uid=$follow.creator_uid users_info=$users_info name=$follow.creator_name|cb_mb_truncate:$name_width}</span>{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}
        {/if}
                                    </td>
                                    <td class="comment-grn vAlignTop-grn nowrap-grn" style="width:40%;">
                                        <div>
                                            {if $follow.creator_uid == $user_id and $message.is_snapshot neq '1'}
                                                {capture name='grn_message_GRN_MSG_135'}{cb_msg module='grn.message' key='GRN_MSG-135' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_GRN_MSG_135 id='lnk_delete_follow_'|cat:$follow.follow_id script="javascript:void(0);" class="icon-delete-grn js_delete_link"}
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vAlignTop-grn" colspan="2">
                                        {capture name=comment_mention}
                                                {strip}
                                                    {if $mention_list[$follow.follow_id]}
                                                        <div class="mention_comment_base_grn">
                                                            {grn_members_name_with_dialog_for_mention app_id='message' members=$mention_list[$follow.follow_id] total_member=$mention_count[$follow.follow_id]}
                                                        </div>
                                                    {/if}
                                                {/strip}
                                        {/capture}
                                        {$smarty.capture.comment_mention|grn_noescape}
                                        <div class="margin_all" id="follow_content_{$follow.follow_id}">
                                            <div>
                                                {if $follow.format_type eq "0"}
                                                    {if $enable_follow_autolink}
                                                        {grn_format body=$follow.data message_follow_link=$message.mid cid=$message.cid rid=$rid}
                                                    {else}
                                                        {grn_format body=$follow.data}
                                                    {/if}
                                                {else}
                                                    {$follow.data|grn_noescape}
                                                {/if}
                                            </div>
                                        </div>
                                        {if $follow.attach_files}
                                            <tt>
                                                {foreach from=$follow.attach_files item=attach_file}
                                                    {if strlen($attach_file.name)}
                                                        {grn_attach_file_link name=$attach_file.name dpage="message/file_download" vpage="message/file_view" tpage="message/file_image_view" size=$attach_file.size mime=$attach_file.mime cid=$message.cid rid=$rid mid=$message.mid rfid=$attach_file.rfid inline=$inline hash=$attach_file.hash}<br>
                                                    {/if}
                                                {/foreach}
                                            </tt>
                                            <div class="margin_all"></div>
                                        {/if}
                                        {if $follow.del_file_num gt 0}
                                        <p>
                                            {cb_msg module='grn.message' key='GRN_MSG-136' replace='true'}&nbsp;<span class="bold">{$follow.del_file_num}</span>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-137' replace='true'}
                                        {/if}
                                    </td>
                                </tr>
                            </table>
        {if $imageIcon}
                        </td>
                    </tr>
                </table>
        {/if}
            </div>
            <div class="thread_comment_footer_grn" style="width:100%;">
                <table class="comment-grn" style="width:100%;">
                    <tr>
                        <td style="width:60%;">
                            {if $imageIcon}
                                <div style="margin-left:40px;">
                            {else}
                                <div>
                            {/if}
                            {if $can_follow}
                                    <span class="mRight15">
                                        {include file="grn/_favour.tpl" favour_info=$follow.favour_info}
                                    </span>

                                    <span class="mRight15">
                                        <a id='lnk_url_tip_{$follow.follow_id}'
                                           class='icon-reply-grn js_reply_button'
                                           href="javascript:">{cb_msg module='grn.grn' key='GRN_GRN-1539' replace='true'}
                                        </a>
                                    </span>

                                    <span class="mRight15">
                                        <a id='lnk_url_tip_{$follow.follow_id}'
                                           class="icon_reply_all_sub_grn icon_inline_grn icon_hover_item_grn js_reply_all_button"
                                           href="javascript:" role="button">
                                            {cb_msg module='grn.grn' key='GRN_GRN-1583' replace='true'}
                                        </a>
                                    </span>
                            {/if}
                                    <span id="fixed_link_{$follow.follow_id}" style="margin-left:5px;">
                                        <a id='lnk_url_tip_{$follow.follow_id}' class='icon-urlTip-grn js_permalink' href='javascript:void(0);' onclick="javascript:showFixedLink(this,'{$follow.full_url}');">{cb_msg module='grn.grn' key='GRN_GRN-1540' replace='true'}</a>
                                    </span>
                                </div>
                        </td>
                        <td class="nowrap-grn" style="width:40%;"></td>
                    </tr>
                </table>
            </div>
        </div>
        {if $smarty.foreach.commentlist.last}
            <div class="border-partition-common-grn"></div>
        {else}
            <div class="border-partition-follow-grn"></div>
        {/if}
    {/foreach}
    {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    {include file="grn/_show_popup_fixed_link.tpl"}

    <!-- reply comment -->
    {capture name=form_fields}
        <input type="hidden" id="comment_data" name="data" value="">
        <input type="hidden" name="cmd" value="follow" />
        <input type="hidden" name="cid" value="{$message.cid}">
        <input type="hidden" name="rid" value="{$rid}">
        <input type="hidden" name="mid" value="{$message.mid}">
    {/capture}
    {include file="grn/_reply_comment.tpl"
        on_submit="__replyComment.threadCommentAdd('reply_comment');"
        form_action="message/command_view"
        input_name="thread_comment_add"
        enable_mention=true
        form_fields=$smarty.capture.form_fields
    }
    <!-- end reply comment -->
</div>
{/if}
{include file="grn/_favour_common.tpl"}
{include file="grn/footer.tpl"}

{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{literal}
    <script>
        (function () {
            var settings = {
                accessPluginEncoded: {/literal}"{$mention_access_plugin_encoded}"{literal}
            };
            new grn.js.page.message.View(settings);
        })();
    </script>
{/literal}
