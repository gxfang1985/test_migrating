{**
  *      show_state : 状態表示ON/OFF
  *  disable_unread : 未読色の表示OFF/ON
  *  disable_follow : フォロー入力の表示OFF/ON
  *     page_prefix : コントローラ位置
  *        is_draft : 下書きの場合TRUE
  *      file_dpage : 添付ファイルのダウンロードページ
  *      file_vpage : 添付ファイルのダウンロードページ
  *      file_tpage : view original image page
 **}
<!-- GRN2-1944 -->
{literal}
    <script type="text/javascript">
        {/literal}{if $use_star}{literal}
        function grn_bulletin_on_update_star(star_ele, params)
        {
            var status = GRN_StarList.getStatus(star_ele);
            var follow = params.follow;
            if ( GRN_StarList.getItems('bulletin_star_follow_list').length > 0 ) {
                GRN_StarList.getItems('bulletin_star_follow_list').each(function () {
                    var item_params = GRN_StarList.parseParam(this);
                    if (item_params.follow == follow) {
                        GRN_StarList.setStatus(this, status);
                    }
                });
            }
        }{/literal}{/if}{literal}
    </script>
{/literal}
{if $use_star }
    {include file="star/star_init.tpl" list_id="bulletin_star_follow_list" on_update="grn_bulletin_on_update_star" use_star=true}
{/if}
<!-- end GRN2-1944 -->

{if ! $page_prefix}{assign var='page_prefix' value='bulletin'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value=$page_prefix|cat:'/file_download'}{/if}
{if ! $file_vpage}{assign var='file_vpage' value=$page_prefix|cat:'/file_view'}{/if}
{if ! $file_tpage}{assign var='file_tpage' value=$page_prefix|cat:'/file_image_view'}{/if}

{if $page_info.parts[1] == 'system' || $page_info.parts[1] == 'operation'}
    {assign var='is_manage' value='1'}
{else}
    {assign var='is_manage' value='0'}
{/if}

{** status header start **}
{if ! $is_draft}
    {if $article.expired}
        {* 期限切れ *} <div class="detail_info_base_grn">
    {elseif ! $article.published}
        {* 掲示待ち *} <div class="detail_info_base_grn detail_info_waiting_grn">
    {else}
        {* 公開掲示 *} <div class="detail_info_base_grn">
    {/if}
{else}
    <div class="detail_info_base_grn detail_info_draft_grn">
{/if}

    <table class="detail_info_grn table_plain_grn inline_block_grn">
        {if $show_state}
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-129' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-130' replace='true'}</td>
                <td>{if $is_draft}{cb_msg module='grn.bulletin' key='GRN_BLLT-131' replace='true'}{elseif ! $article.published}{cb_msg module='grn.bulletin' key='GRN_BLLT-132' replace='true'}{elseif $article.expired}{cb_msg module='grn.bulletin' key='GRN_BLLT-133' replace='true'}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-134' replace='true'}{/if}</td>
            </tr>
        {/if}
        <tr>
            <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-135' replace='true'}</td>
            <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-136' replace='true'}</td>
            <td id="bulletin_category">
                {if $article.cid === "deleted"}
                    {cb_msg module='grn.bulletin' key='GRN_BLLT-137' replace='true'}
                {elseif strlen($article.category_name) < 1}
                    {cb_msg module='grn.bulletin' key='GRN_BLLT-138' replace='true'}
                {else}
                    {$article.category_name|escape}{if ! $is_manage && ! $article.published && ! $article.category_auth.write}&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-139' replace='true'}{/if}
                {/if}
            </td>
        </tr>
        {if $article.manually_enter_sender}
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-140' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-141' replace='true'}</td>
                <td>{$article.manually_enter_sender|escape}</td>
            </tr>
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-648' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-649' replace='true'}</td>
                <td>{if $page_prefix === 'bulletin/system' || $page_prefix === 'bulletin/operation'}{if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name users_info=$users_info}{if $article.group_name} ){/if}&nbsp;{/if}{grn_date_format date=$article.ctime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-650' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-651' replace='true'}</td>
                <td>{if $page_prefix === 'bulletin/system' || $page_prefix === 'bulletin/operation'}{grn_user_name uid=$article.modifier_uid name=$article.modifier_name users_info=$users_info}&nbsp;{/if}{grn_date_format date=$article.mtime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
        {else}
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-140' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-141' replace='true'}</td>
                <td>{if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name users_info=$users_info}{if $article.group_name} ){/if}&nbsp;{grn_date_format date=$article.ctime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-142' replace='true'}</td>
                <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-143' replace='true'}</td>
                <td>{grn_user_name uid=$article.modifier_uid name=$article.modifier_name users_info=$users_info}&nbsp;{grn_date_format date=$article.mtime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
        {/if}
        <tr>
            <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-144' replace='true'}</td>
            <td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-145' replace='true'}</td>
            <td>
                {if $article.start_is_datetime && $article.end_is_datetime}
                    {grn_show_period start=$article.stime end=$article.etime start_format='DateTimeFull_YMDW_HM' end_format='DateTimeFull_YMDW_HM'}    
                {elseif !$article.start_is_datetime && $article.end_is_datetime}
                    {grn_show_period start=$article.stime end=$article.etime start_format='DateFull_YMDW' end_format='DateTimeFull_YMDW_HM'}    
                {elseif $article.start_is_datetime && !$article.end_is_datetime}
                    {grn_show_period start=$article.stime end=$article.etime start_format='DateTimeFull_YMDW_HM' end_format='DateFull_YMDW'}    
                {else}
                    {grn_show_period start=$article.stime end=$article.etime start_format='DateFull_YMDW' end_format='DateFull_YMDW'}    
                {/if}
                {if ! $show_state && $article.expired}
                    &nbsp;<span class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-146' replace='true'}</div>
                {/if}
            </td>
        </tr>
        {if $show_state}
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn' key='grn.comment.permission.conf.item' replace='true'}</td><td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-148' replace='true'}</td>
                <td>{if $article.can_follow}{capture name='grn_bulletin_GRN_BLLT_149'}{cb_msg module='grn.bulletin' key='GRN_BLLT-149' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_149 image='check16.gif'}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-150' replace='true'}{/if}</td>
            </tr>
            <tr>
                <td class="detail_info_label_grn nowrap-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-636' replace='true'}</td><td class="detail_separator_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-148' replace='true'}</td>
                <td>{if $article.reserve_int1}{capture name='grn_bulletin_GRN_BLLT_637'}{cb_msg module='grn.bulletin' key='GRN_BLLT-637' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_637 image='check16.gif'}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-638' replace='true'}{/if}</td>
            </tr>
        {/if}
    </table>
</div> {** status header end **}

<div class="border-partition-common-grn"></div>

<div class="bodytext_base_grn"> {* contents body *}
    <div class="margin_all">
    {if $article.modified}
        <div class="unread_color">
    {/if}
    {if $article.html}{$article.html|grn_noescape}{else}{grn_format body=$article.data}{/if}
    {if $article.modified}
        </div>
    {/if}
    </div>
    {if $article.attach_files}
        <p>
        <tt>
            {foreach from=$article.attach_files item=file}
                {grn_attach_file_link name=$file.name dpage=$file_dpage vpage=$file_vpage size=$file.size mime=$file.mime fid=$file.id cid=$article.cid aid=$article.aid inline=$config.inline hash=$file.hash tpage=$file_tpage}<br>
            {/foreach}
        </tt>
    {/if}
</div> {* end of contents body *}

<div class="clear_both_1px">&nbsp;</div>
<div class="list_menu">
    <div class="float_left">
        <div class="bodytext_footer_grn mLeft10 mTop5">
            {include file="grn/_favour.tpl" disable_link=$disable_favour_link}
        </div>
    </div>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {strip}
                {if $navi.prev}
                    <span class="moveButtonBase-grn">
                        <a href="{cb_pageurl page=$navi.prev.page cid=$navi.prev.page_params.cid aid=$navi.prev.page_params.aid}" aria-label="{cb_msg module='grn.common' key='previous_next_navi_prev' replace='true'}" title="{cb_msg module='grn.common' key='previous_next_navi_prev' replace='true'}"><span class="moveButtonArrowLeft-grn"></span></a>
                    </span>
                {else}
                    <span class="moveButtonBase-grn button_disable_filter_grn">
                        <a href="#" aria-disabled="true"><span class="moveButtonArrowLeft-grn"></span></a>
                    </span>
                {/if}
                {if $navi.next}
                    <span class="moveButtonBase-grn">
                    <a href="{cb_pageurl page=$navi.next.page cid=$navi.next.page_params.cid aid=$navi.next.page_params.aid}" aria-label="{cb_msg module='grn.common' key='previous_next_navi_next' replace='true'}" title="{cb_msg module='grn.common' key='previous_next_navi_next' replace='true'}"><span class="moveButtonArrowRight-grn"></span></a>
                </span>
                {else}
                    <span class="moveButtonBase-grn button_disable_filter_grn">
                        <a href="#" aria-disabled="true"><span class="moveButtonArrowRight-grn"></span></a>
                    </span>
                {/if}
            {/strip}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{if ! $disable_follow && $article.can_follow && $article.auth.follow}
  <div class="border-partition-common-grn"></div>
  <div class="comment_std_grn detail_comment_grn">
    <form name="follow_form" method="post" enctype="multipart/form-data" action="{grn_pageurl page=$page_prefix|cat:'/command_'|cat:$page_info.last}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="aid" value="{$article.aid}">
        <input type="hidden" name="cid" value="{$article.cid}">
        {include file="grn/richeditor.tpl" enable=$config.enable_htmleditor class="form_textarea_grn" comment="true"}
        {include file="grn/attach_file35.tpl" isFollow=TRUE fbox_id="article_comment"}
        {strip}
            {capture name="grn_bulletin_GRN_BLLT_152"}{cb_msg module='grn.bulletin' key='GRN_BLLT-152' replace='true'}{/capture}
            <div class="mTop5 mBottom20">
                {grn_button id="bulletin_button_comment" ui="main" auto_disable=true caption=$smarty.capture.grn_bulletin_GRN_BLLT_152 onclick="if(confirmIfExistFailedFile())grn.component.button.util.submit(this);"}
            </div>
        {/strip}
    </form>
  </div>
    {assign var=can_follow value=1}
{else}
    {assign var=can_follow value=0}
{/if}


{if $article.follows}
{include file="grn/error_handler.tpl"}
{grn_load_css file="grn/html/image_grn.css"}
{grn_load_javascript file="grn/html/reply.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{literal}
<script language="javascript" type="text/javascript">
var __replyComment = grn.page.comment.reply;
</script>
<script language="javascript" type="text/javascript">
__replyComment.threadCommentAddUrl = {/literal}'{grn_pageurl page="bulletin/command_reply"}'{literal};
__replyComment.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
</script>
{/literal}
    {if !$is_manage}{grn_delete title=$delete_follow.title page=$delete_follow.page data=$delete_follow.data handler=$delete_follow.handler before_delete=$delete_follow.before_delete}{/if}
    <div class="border-partition-common-grn"></div>
    
    <a name="follow"></a>
    {* N件ナビゲーション *}
    {include file="grn/word_navi.tpl" navi=$navi.navi}
    <div class="border-partition-common-grn"></div>
    {foreach from=$article.follows item=follow name=commentlist}
        <div class="contents_area {if $follow.unread}unread_color{/if} js_comment"
             id="thread_comment_{$follow.follow_id}"
             onmouseover="__replyComment.selectComment({$follow.follow_id});"
             onmouseout="__replyComment.unselectComment({$follow.follow_id});"
             data-comment-no="{$follow.id}"
             data-comment-id="{$follow.follow_id}">

            <div class="profileImageBase-grn">
        {if $imageIcon}
                <table class="comment_base_grn">
                    <tr>
                        <td class="vAlignTop-grn sub_grn" style="width:1%;">
                            {assign var='userId' value=$follow.creator_uid}
                            {grn_user_image_icon userInfo=$users_info.$userId photoUrl=$users_info.$userId.photoUrl userId=$userId loginId=$loginId size=$iconSize alt=$follow.creator_name}
                        </td>
                        <td class="vAlignTop-grn">
        {/if}
                            <table class="comment_base_grn">
                                <tr>
                                    <td class="vAlignTop-grn sub_grn nowrap-grn" style="width:60%;">
        {if $imageIcon}
                                        <span class="commentNum-grn">{$follow.id}:</span><span class="username_grn">{grn_user_name uid=$userId users_info=$users_info name=$follow.creator_name noimage=true}</span><span class="commentDate-grn">{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}</span>
        {else}
                                        {$follow.id|escape}&nbsp;:<span class="username_grn">{grn_user_name uid=$follow.creator_uid name=$follow.creator_name users_info=$users_info}</span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}
        {/if}
                                    </td>
                                    <td class="comment-grn vAlignTop-grn nowrap-grn" style="width:40%;">
                                        <div>
                                            {if $follow.deletable}
                                                {if $is_manage}
                                                    {capture name='grn_bulletin_GRN_BLLT_154'}{cb_msg module='grn.bulletin' key='GRN_BLLT-154' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/follow_delete' cid=$article.cid aid=$article.aid follow_id=$follow.follow_id class="icon-delete-grn" caption=$smarty.capture.grn_bulletin_GRN_BLLT_154}
                                                {else}
                                                    {capture name='grn_bulletin_GRN_BLLT_155'}{cb_msg module='grn.bulletin' key='GRN_BLLT-155' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/follow_delete' cid=$article.cid aid=$article.aid follow_id=$follow.follow_id class="icon-delete-grn" caption=$smarty.capture.grn_bulletin_GRN_BLLT_155 id='lnk_delete_follow_'|cat:$follow.follow_id script='javascript:void(0)'}

                                                {/if}
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vAlignTop-grn" colspan="2">
                                        <div class="margin_all"{if !$is_manage}id="follow_{$follow.follow_id}"{/if}>
                                            {if $follow.html}
                                                {$follow.html|grn_noescape}
                                            {else}
                                                {if $enable_follow_autolink}
                                                    {grn_format body=$follow.data bulletin_follow_autolink=$article.aid cid=$article.cid}
                                                {else}
                                                    {grn_format body=$follow.data}
                                                {/if}
                                            {/if}
                                        </div>
                                        {if $follow.attach_files}
                                            <tt>
                                                {foreach from=$follow.attach_files item=file}
                                                    {grn_attach_file_link fid=$file.id dpage=$file_dpage vpage=$file_vpage name=$file.name size=$file.size mime=$file.mime cid=$article.cid aid=$article.aid follow_id=$follow.follow_id inline=$config.inline hash=$file.hash tpage=$file_tpage}<br>
                                                {/foreach}
                                            </tt>
                                            <div class="margin_all"></div>
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
                            {if $can_follow}
                                {if $imageIcon}
                                    <div style="margin-left:40px;">
                                {else}
                                    <div>
                                {/if}
                                    <span class="mRight15">
                                        {include file="grn/_favour.tpl" favour_info=$follow.favour_info disable_link=$disable_favour_link}
                                    </span>
                                    <a id='lnk_url_tip_{$follow.follow_id}'
                                       class='icon-reply-grn js_reply_button'
                                       href="javascript:">{cb_msg module='grn.grn' key='GRN_GRN-1539' replace='true'}
                                    </a>
                                </div>
                            {else}
                                <span class="mRight15">
                                    {include file="grn/_favour.tpl" favour_info=$follow.favour_info disable_link=$disable_favour_link}
                                </span>
                                <br />
                            {/if}
                        </td>
                        <td class="nowrap-grn" style="width:40%;">
                            <div id="fixed_link_{$follow.follow_id}" style="vertical-align:bottom; {if $imageIcon}margin-left:16px;{/if}">
                                <a id='lnk_url_tip_{$follow.follow_id}' class='icon-urlTip-grn' href='javascript:void(0);' onclick="javascript:showFixedLink(this,'{$follow.full_url}');">{cb_msg module='grn.grn' key='GRN_GRN-1540' replace='true'}</a>
                            </div>
                        </td>
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
    {include file="grn/word_navi.tpl" navi=$navi.navi}

    <!-- reply comment -->
    {capture name=form_fields}
        <input type="hidden" id="comment_data" name="data" value="">
        <input type="hidden" name="cmd" value="follow" />
        <input type="hidden" name="aid" value="{$article.aid}">
        <input type="hidden" name="cid" value="{$article.cid}">
    {/capture}
    {include file="grn/_reply_comment.tpl"
        on_submit="__replyComment.threadCommentAdd('reply_comment');"
        form_action="bulletin/command_view"
        input_name="thread_comment_add"
        enable_mention=false
        form_fields=$smarty.capture.form_fields
    }
    <!-- end reply comment -->

    {include file="grn/_show_popup_fixed_link.tpl"}
{/if}
{include file="grn/_favour_common.tpl"}

{if $article.follows}
    {literal}
        <script>
            (function () {
                var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog();
                reply_dialog.bindToCommentList("#body");
            })();
        </script>
    {/literal}
{/if}
