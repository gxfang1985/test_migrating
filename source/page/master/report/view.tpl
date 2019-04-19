{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{assign var='form_name' value=$smarty.template|basename}
{if ! $page_prefix}{assign var='page_prefix' value='report'}{/if}
{if ! $form}{assign var='disable_form' value=true}{/if}

{* メニュー、通知メッセージ *}
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $is_creator || $is_report_operator}
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_76'}{cb_msg module='grn.report' key='GRN_RPRT-76' replace='true'}{/capture}{grn_link element_id='report_modify' page='report/modify' caption=$smarty.capture.grn_report_GRN_RPRT_76 image='modify20.gif' fid=$fid rid=$report_id alt=''}</span>
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_77'}{cb_msg module='grn.report' key='GRN_RPRT-77' replace='true'}{/capture}{grn_link element_id='report_notification_modify' page='report/notification_modify' caption=$smarty.capture.grn_report_GRN_RPRT_77 image='user20.gif' rid=$report_id alt=''}</span>
        {/if}
        <span class="menu_item">{capture name='grn_report_GRN_RPRT_78'}{cb_msg module='grn.report' key='GRN_RPRT-78' replace='true'}{/capture}{grn_link element_id='report_accessory' page='report/accessory' caption=$smarty.capture.grn_report_GRN_RPRT_78 image='file20.gif' rid=$report_id alt=''}</span>
        {if $accessible_category}
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_79'}{cb_msg module='grn.report' key='GRN_RPRT-79' replace='true'}{/capture}{grn_link element_id='report_reuse' caption=$smarty.capture.grn_report_GRN_RPRT_79 page='report/reuse' image='reuse20.gif' fid=$fid rid=$report_id mode='reuse' disabled=$disable_form alt=''}</span>
        {/if}
        <span class="menu_item">{capture name='grn_report_GRN_RPRT_80'}{cb_msg module='grn.report' key='GRN_RPRT-80' replace='true'}{/capture}{grn_link element_id='report_print' caption=$smarty.capture.grn_report_GRN_RPRT_80 page='report/print' image='print20.gif' fid=$fid rid=$report_id alt=''}</span>
        {if $is_creator || $is_report_operator}
            <span class="menu_item">
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                {capture name='grn_report_GRN_RPRT_81'}{cb_msg module='grn.report' key='GRN_RPRT-81' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_81 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}
            </span>
        {/if}
    </span>
    <span class="float_right nowrap-grn mBottom2">
        {if !$is_creator}
            {include file="report/_view_subscription.tpl" rid=$report_id}
        {/if}
    </span>
    <div class="clear_both_0px"></div>
</div>

{if $use_star}
    {include file="star/star_init.tpl" list_id="star_list" use_star=$use_star}
    <div id="star_list">
        {grn_star_icon module="grn.report" star_infos=$star_infos unique_id=$report_id rid=$report_id no_style=1}
{/if}
{grn_title title=$report_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
{if $use_star}
    </div>
{/if}

<div class="contents_area">
    <table class="margin_top">
        <tr>
            <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-82' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-83' replace='true'}&nbsp;</td>
            <td>{grn_user_name uid=$report.creator name=$report.creator_name}&nbsp;{grn_date_format date=$report.ctime format="DateTimeMiddle_YMDW_HM"}</td>
        </tr>
        {if $report.modifier neq ''}
            <tr>
                <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-84' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-85' replace='true'}&nbsp;</td>
                <td>{grn_user_name uid=$report.modifier name=$report.modifier_name}&nbsp;{grn_date_format date=$report.mtime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
        {/if}
        <tr valign="top">
            <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-361' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-362' replace='true'}&nbsp;</td>
            <td>{if $report.private}{cb_msg module='grn.report' key='GRN_RPRT-363' replace='true'}{else}{cb_msg module='grn.report' key='GRN_RPRT-364' replace='true'}{/if}</td>
        </tr>
        <tr valign="top">
            <td nowrap>{if $report.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-86' replace='true'}{else}{cb_msg module='grn.report' key='notification' replace='true'}{/if}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-87' replace='true'}&nbsp;</td>
            <td>
                {grn_report_notification users=$notificationUsers}
                <small><div>
                {capture name='grn_report_detail'}{cb_msg module='grn.report' key='detail' replace='true'}{/capture}{grn_link element_id='report_detail' page='report/detail' caption=$smarty.capture.grn_report_detail image='detail20.gif' rid=$report_id}
                </div></small>
            </td>
        </tr>
    </table>
</div>

<div class="border-partition-common-grn"></div>
{* 内容 *}
{include file='report/_view.tpl' event_id=$event_id event=$event event_date=$event_date is_creator=$is_creator report=$report from='modify' members=$members partners=$partners item_data_list=$item_data_list draft=false}

<p></p>

<div class="border-partition-common-grn"></div>
{if $report.enable_follow}
  <div class="comment_std_grn detail_comment_grn">
    <form name="follow_form" method="post" enctype="multipart/form-data" action="{grn_pageurl page=$page_prefix|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="rid" value="{$report_id}">
        <input type="hidden" name="cid" value="{$cid}">
        <div>
            {if $input_config.enable_htmleditor}
                {include file="grn/richeditor.tpl" enable=1 comment="true" class="form_textarea_grn"}
            {else}
                {include file="grn/richeditor.tpl" enable=0 comment="true" class="form_textarea_grn"}
            {/if}
            {include file="grn/attach_file35.tpl" isFollow=TRUE fbox_id="report_comment"}
            {strip}
                {capture name="grn_report_GRN_RPRT_93"}{cb_msg module='grn.report' key='GRN_RPRT-93' replace='true'}{/capture}
                {capture name="onreportcomment"}if(confirmIfExistFailedFile())grn.component.button.util.submit(this);{/capture}
                <div class="mTop5 mBottom20">
                    {grn_button id="report_button_comment" ui="main" auto_disable=true caption=$smarty.capture.grn_report_GRN_RPRT_93 onclick=$smarty.capture.onreportcomment}
                </div>
            {/strip}
        </div>
    </form>
  </div>
{/if}

{if $follow_list}
    {grn_delete title=$follow_delete_info.title page=$follow_delete_info.page data=$follow_delete_info.data handler=$follow_delete_info.handler before_delete=$follow_delete_info.before_delete}
    <div class="border-partition-common-grn"></div>
    <a name="follow"></a>
    {* N件ナビゲーション *}
    {include file="grn/word_navi.tpl" navi=$navi.navi}
    <div class="border-partition-common-grn"></div>
    {foreach from=$follow_list item=follow name=commentlist}
        {if $readstatus && $follow.ctime->unix_ts > $readstatus.last_timestamp}
            <div class="contents_area unread_color">
        {else}
            <div class="contents_area">
        {/if}
            <div class="profileImageBase-grn">
        {if $imageIcon}
                <table class="comment_base_grn">
                    <tr>
                        <td class="vAlignTop-grn sub_grn" style="width:1%;">
                            {assign var='userId' value=$follow.creator}
                            {grn_user_image_icon userInfo=$users_info.$userId photoUrl=$users_info.$userId.photoUrl userId=$userId loginId=$loginId size=$iconSize alt=$follow.creator_name}
                        </td>
                        <td class="vAlignTop-grn">
        {/if}
                            <table class="comment_base_grn">
                                <tr>
                                    <td class="vAlignTop-grn sub_grn nowrap-grn" style="width:60%;">
        {if $imageIcon}
                                        <span class="commentNum-grn">{$follow.follow_id}:</span><span class="username_grn">{grn_user_name uid=$userId users_info=$users_info name=$follow.creator_name noimage=true}</span><span class="commentDate-grn">{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}</span>
        {else}
                                        {$follow.follow_id|escape}&nbsp;:<span class="username_grn">{grn_user_name uid=$follow.creator name=$follow.creator_name users_info=$users_info}</span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}
        {/if}
                                    </td>
                                    <td class="comment-grn vAlignTop-grn nowrap-grn" style="width:40%;">
                                        <div>
                                            {if $follow.deletable}
                                                {capture name='grn_report_GRN_RPRT_95'}{cb_msg module='grn.report' key='GRN_RPRT-95' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_report_GRN_RPRT_95 script='javascript:void(0)' id='lnk_follow_delete_'|cat:$follow.id}
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vAlignTop-grn" colspan="2">
                                        <div class="margin_all"{if $follow.deletable} id="follow_{$follow.id}"{/if}>
                                            {if $follow.html}
                                                {$follow.html|grn_noescape}
                                            {else}
                                                {if $input_config.enable_follow_autolink}
                                                    {grn_format body=$follow.data report_follow_autolink=$report_id cid=$cid rid=$report_id}
                                                {else}
                                                    {grn_format body=$follow.data}
                                                {/if}
                                            {/if}
                                        </div>
                                        {if $follow.attach_files}
                                            <tt>
                                                {foreach from=$follow.attach_files item=file}
                                                    {grn_attach_file_link fid=$file.file dpage="report/file_download" vpage="report/file_view" name=$file.file_info.name size=$file.file_info.size mime=$file.file_info.mime cid=$cid rid=$report_id follow_id=$file.follow inline=$input_config.inline hash=$file.file_info.hash}<br>
                                                {/foreach}
                                            </tt>
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
        </div>
        {if $smarty.foreach.commentlist.last}
            <div class="border-partition-common-grn"></div>
        {else}
            <div class="border-partition-follow-grn"></div>
        {/if}
    {/foreach}
    {include file="grn/word_navi.tpl" navi=$navi.navi}
{/if}

{include file="grn/footer.tpl"}
