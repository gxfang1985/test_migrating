
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $article.modifiable}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_334'}{cb_msg module='grn.bulletin' key='GRN_BLLT-334' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_334 image='modify20.gif' cid=$article.cid aid=$article.aid}</span>
        {/if}

        {if $article.movable}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_335'}{cb_msg module='grn.bulletin' key='GRN_BLLT-335' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_move' caption=$smarty.capture.grn_bulletin_GRN_BLLT_335 image='move20.gif' cid=$category_id s_cid=$article.cid aid=$article.aid}</span>
        {else}
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_336'}{cb_msg module='grn.bulletin' key='GRN_BLLT-336' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_move' caption=$smarty.capture.grn_bulletin_GRN_BLLT_336 image='move20.gif' cid=$category_id s_cid=$article.cid aid=$article.aid disabled=1}</span>
        {/if}

        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_337'}{cb_msg module='grn.bulletin' key='GRN_BLLT-337' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_accessory' caption=$smarty.capture.grn_bulletin_GRN_BLLT_337 image='file20.gif' cid=$category_id aid=$article.aid}</span>
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_338'}{cb_msg module='grn.bulletin' key='GRN_BLLT-338' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_export' postfix='notitle.txt' caption=$smarty.capture.grn_bulletin_GRN_BLLT_338 image='disk20.gif' cid=$article.cid aid=$article.aid}</span>

        {if $article.deletable}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_339'}{cb_msg module='grn.bulletin' key='GRN_BLLT-339' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_339 image='delete20.gif' cid=$category_id aid=$article.aid}</span>
        {else}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_340'}{cb_msg module='grn.bulletin' key='GRN_BLLT-340' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_340 image='delete20.gif' cid=$category_id aid=$article.aid disabled=1}</span>
        {/if}
        <span class="menu_item">
            {include file='bulletin/_article_display_options.tpl' category_id=$article.cid article_id=$article.aid article_modifiable=$article.modifiable page_prefix=$page_prefix}
        </span>
    </span>
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
<!--menubar_end-->
<div class="bulletin_title_grn">
    {grn_title title=$article.title class=$page_info.parts[0]}
</div>
{include file='bulletin/_view.tpl' show_state=1 disable_follow=1 page_prefix=$page_prefix disable_favour_link=TRUE}

