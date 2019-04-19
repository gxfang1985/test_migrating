{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $article.category_auth.write}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_503'}{cb_msg module='grn.bulletin' key='GRN_BLLT-503' replace='true'}{/capture}{grn_link page='bulletin/draft_send'   caption=$smarty.capture.grn_bulletin_GRN_BLLT_503 image='write20.gif'  aid=$article.aid alt=''}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_504'}{cb_msg module='grn.bulletin' key='GRN_BLLT-504' replace='true'}{/capture}{grn_link page='bulletin/draft_reuse'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_504 image='reuse20.gif'  aid=$article.aid alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_505'}{cb_msg module='grn.bulletin' key='GRN_BLLT-505' replace='true'}{/capture}{grn_link page='bulletin/draft_send'   caption=$smarty.capture.grn_bulletin_GRN_BLLT_505 image='write20.gif'  aid=$article.aid disabled=1 alt=''}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_506'}{cb_msg module='grn.bulletin' key='GRN_BLLT-506' replace='true'}{/capture}{grn_link page='bulletin/draft_reuse'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_506 image='write20.gif'  aid=$article.aid disabled=1 alt=''}</span>
        {/if}
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_507'}{cb_msg module='grn.bulletin' key='GRN_BLLT-507' replace='true'}{/capture}{grn_link page='bulletin/draft_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_507 image='delete20.gif' aid=$article.aid id='lnk_delete' script='javascript:void(0);' alt=''}</span>
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {strip}
                {grn_previous_next_navi previous=$navi.prev next=$navi.next}
            {/strip}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->
<div class="bulletin_title_grn">
    {if $use_star}
        {include file="star/star_init.tpl" list_id="bulletin_list"}
        <div id="bulletin_list">{grn_star_icon module="grn.bulletin" star_infos=$star_infos unique_id="draft_"|cat:$article.aid aid=$article.aid type="draft" no_style=1}
    {/if}
    {grn_title title=$article.title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if $use_star}
        </div>
    {/if}
    {grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}
</div>

{include file='bulletin/_view.tpl' show_state=1 disable_unread=1 disable_follow=1 is_draft=1 file_dpage='bulletin/draft_file_download' file_vpage='bulletin/draft_file_view' file_tpage='bulletin/draft_file_image_view'}

{include file='grn/footer.tpl'}
