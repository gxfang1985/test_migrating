{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $article.modifiable}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_35'}{cb_msg module='grn.bulletin' key='GRN_BLLT-35' replace='true'}{/capture}{grn_link page='bulletin/modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_35 image='modify20.gif' cid=$article.cid aid=$article.aid alt=''}</span>
        {/if}
        {if $article.movable}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_37'}{cb_msg module='grn.bulletin' key='GRN_BLLT-37' replace='true'}{/capture}{grn_link page='bulletin/move' caption=$smarty.capture.grn_bulletin_GRN_BLLT_37 image='move20.gif' cid=$article.cid s_cid=$article.cid aid=$article.aid alt=''}</span>
        {/if}
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_38'}{cb_msg module='grn.bulletin' key='GRN_BLLT-38' replace='true'}{/capture}{grn_link page='bulletin/accessory' caption=$smarty.capture.grn_bulletin_GRN_BLLT_38 image='file20.gif' cid=$article.cid aid=$article.aid alt=''}</span>
        {if $article.is_maintainer || $article.auth.write}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_39'}{cb_msg module='grn.bulletin' key='GRN_BLLT-39' replace='true'}{/capture}{grn_link page='bulletin/reuse' caption=$smarty.capture.grn_bulletin_GRN_BLLT_39 image='reuse20.gif' cid=$article.cid aid=$article.aid alt=''}</span>
        {/if}
        {if $bulletin_acknowledgement.need_confirm eq '1'}
            <span class="menu_item">
                {capture name='grn_bulletin_GRN_BLLT_603'}{cb_msg module='grn.bulletin' key='GRN_BLLT-603' replace='true'}{/capture}
                {grn_link image='detail20.gif' caption=$smarty.capture.grn_bulletin_GRN_BLLT_603 page='bulletin/read_status' cid=$bulletin_acknowledgement.cid rid=$rid aid=$bulletin_acknowledgement.aid alt=''}
                {cb_msg module='grn.bulletin' key='GRN_BLLT-601' replace='true'}{$bulletin_acknowledgement.confirmed_num}{cb_msg module='grn.bulletin' key='GRN_BLLT-602' replace='true'}
            </span>
        {/if}
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_40'}{cb_msg module='grn.bulletin' key='GRN_BLLT-40' replace='true'}{/capture}{grn_link page='bulletin/export' postfix='notitle.txt' caption=$smarty.capture.grn_bulletin_GRN_BLLT_40 image='disk20.gif' cid=$article.cid aid=$article.aid alt=''}</span>
        {if $article.deletable}
            {grn_delete title=$delete_info.title page=$delete_info.page handler='lnk_delete' data=$delete_info.data}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_41'}{cb_msg module='grn.bulletin' key='GRN_BLLT-41' replace='true'}{/capture}{grn_link page='bulletin/delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_41 image='delete20.gif' cid=$article.cid aid=$article.aid id='lnk_delete' script='javascript:void(0)' alt=''}</span>
        {/if}
        <span class="menu_item">
            {include file='bulletin/_article_display_options.tpl' category_id=$article.cid article_id=$article.aid article_modifiable=$article.modifiable}
        </span>
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {strip}
                {if ! $article.expired && $article.notify.notified && $article.notify.enable_unsubscribe}
                    {include file='bulletin/_view_subscription.tpl'}
                {/if}
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
        <div id="bulletin_list">{grn_star_icon module="grn.bulletin" star_infos=$star_infos unique_id=$article.aid aid=$article.aid cid=$article.cid no_style=1}
    {/if}
    {grn_title title=$article.title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if $use_star}
        </div>
    {/if}
</div>

{include file='bulletin/_view.tpl'}

{include file="grn/footer.tpl"}
