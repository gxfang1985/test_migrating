{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $article.category_auth.write}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_288'}{cb_msg module='grn.bulletin' key='GRN_BLLT-288' replace='true'}{/capture}{grn_link page='bulletin/wait_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_288   image='modify20.gif' cid=$article.cid aid=$article.aid alt=''}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_289'}{cb_msg module='grn.bulletin' key='GRN_BLLT-289' replace='true'}{/capture}{grn_link page='bulletin/wait_reuse'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_289 image='reuse20.gif'  cid=$article.cid aid=$article.aid alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_290'}{cb_msg module='grn.bulletin' key='GRN_BLLT-290' replace='true'}{/capture}{grn_link page='bulletin/wait_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_290   image='modify20.gif' cid=$article.cid aid=$article.aid disabled=1 alt=''}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_291'}{cb_msg module='grn.bulletin' key='GRN_BLLT-291' replace='true'}{/capture}{grn_link page='bulletin/wait_reuse'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_291 image='reuse20.gif'  cid=$article.cid aid=$article.aid disabled=1 alt=''}</span>
        {/if}
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_292'}{cb_msg module='grn.bulletin' key='GRN_BLLT-292' replace='true'}{/capture}{grn_link page='bulletin/wait_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_292   image='delete20.gif' cid=$article.cid aid=$article.aid id='lnk_delete' script='javascript:void(0);' alt=''}</span>
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
        <div id="bulletin_list">{grn_star_icon module="grn.bulletin" star_infos=$star_infos unique_id=$article.aid aid=$article.aid type="wait" no_style=1}
    {/if}
    {grn_title title=$article.title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if $use_star}
        </div>
    {/if}
    {grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}
</div>

{include file='bulletin/_view.tpl' show_state=1 disable_unread=1 disable_follow=1}

{include file='grn/footer.tpl'}
