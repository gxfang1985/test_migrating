{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{if $category_id != 1}
    {if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
    {grn_site_position_category page=$category_page positions=$category}
{else}
    {include file='bulletin/_title_search.tpl'}
{/if}

<div class="mainarea">
    <!--menubar-->
    <div id="menu_part">
        <div id="smart_main_menu_part">
            {if $category.auth.write}
                <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_54'}{cb_msg module='grn.bulletin' key='GRN_BLLT-54' replace='true'}{/capture}{grn_link page='bulletin/send' caption=$smarty.capture.grn_bulletin_GRN_BLLT_54 image='write20.gif' cid=$category.cid element_id="bulletin_send"}</span>
            {/if}
            {if ! $category.auth.read}
                <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_55'}{cb_msg module='grn.bulletin' key='GRN_BLLT-55' replace='true'}{/capture}{grn_link page='bulletin/subscribe' caption=$smarty.capture.grn_bulletin_GRN_BLLT_55 image='subscribe20.png' cid=$category.cid disabled=1 element_id="bulletin_set_subscribe"}</span>
            {else}
                <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_56'}{cb_msg module='grn.bulletin' key='GRN_BLLT-56' replace='true'}{/capture}{grn_link page='bulletin/subscribe' caption=$smarty.capture.grn_bulletin_GRN_BLLT_56 image='subscribe20.png' cid=$category.cid element_id="bulletin_set_subscribe"}</span>
            {/if}
            <span class="menu_item">
                {include file='bulletin/_display_options.tpl'}
            </span>
        </div>
        <div id="smart_rare_menu_part" style="white-space:nowrap;">
            {if $use_fts}
                <form class="clearFix-cybozu" method="get" action="{grn_pageurl page='bulletin/search'}">
                    <input type="hidden" name="cid" value="{$category_id}">
                    {include file='fts/_search_box.tpl'}
                </form>
            {else}
                {if ! $no_search}
                    {capture name='grn_bulletin_GRN_BLLT_542'}{cb_msg module='grn.bulletin' key='GRN_BLLT-542' replace='true'}{/capture}
                    {if $wt=='1'}
                        {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/wait_search" page="bulletin/wait_search"}
                    {elseif $df=='1'}
                        {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/draft_search" page="bulletin/draft_search" cid='' df='1'}
                    {else}
                        {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/search" page="bulletin/search" cid=$category.cid scid=$category.cid}
                    {/if}
                {/if}
            {/if}
        </div>
    </div>

    <table class="maincontents_list">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <table style="width:100%">
                        <tr valign="top">
                            <td id="tree_part">
                                {include file='grn/org_tree_26.tpl'}
                            </td>
                            <td id="view_part" width="90%">
                                {if $category.memo|count_words}
                                    <div class="margin_bottom">
                                        {include file='grn/memo.tpl' category_memo=$category.memo}
                                    </div>
                                {/if}
                                {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
                                {include file="grn/smart_word_navi_310.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}

                                <!--view-->
                                {if $use_star}
                                    {include file="star/star_init.tpl" list_id="bulletin_list"}
                                    <table class="list_column" id="bulletin_list">
                                        <colgroup>
                                            <col width="1%">
                                            <col width="30%">
                                            <col width="30%">
                                            <col width="20%">
                                            <col width="19%">
                                        </colgroup>
                                        <tr valign="top">
                                            <th>&nbsp;</th>
                                {else}
                                    <table class="list_column">
                                        <colgroup>
                                            <col width="30%">
                                            <col width="30%">
                                            <col width="20%">
                                            <col width="20%">
                                        </colgroup>
                                        <tr valign="top">
                                {/if}
                                            {if $sort == 'suu'}
                                                <th nowrap>{capture name='grn_bulletin_GRN_BLLT_65'}{cb_msg module='grn.bulletin' key='GRN_BLLT-65' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_65   page=$page_info.all cid=$category_id sort='sud' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'sud'}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_66'}{cb_msg module='grn.bulletin' key='GRN_BLLT-66' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_66   page=$page_info.all cid=$category_id sort='suu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_67'}{cb_msg module='grn.bulletin' key='GRN_BLLT-67' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_67   page=$page_info.all cid=$category_id sort='sud' sp=0 disable=1}</th>
                                                {/if}
                                            {/if}
                                            <th nowrap><div style="padding-top: 2px;">{cb_msg module='grn.bulletin' key='GRN_BLLT-68' replace='true'}</div></th>
                                            {if $sort == 'guu'}
                                                <th nowrap>{capture name='grn_bulletin_GRN_BLLT_69'}{cb_msg module='grn.bulletin' key='GRN_BLLT-69' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_69   page=$page_info.all cid=$category_id sort='gud' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'gud'}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_70'}{cb_msg module='grn.bulletin' key='GRN_BLLT-70' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_70   page=$page_info.all cid=$category_id sort='guu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_71'}{cb_msg module='grn.bulletin' key='GRN_BLLT-71' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_71   page=$page_info.all cid=$category_id sort='gud' sp=0 disable=1}</th>
                                                {/if}
                                            {/if}
                                            {if $sort == 'ntu'}
                                                <th nowrap>{capture name='grn_bulletin_GRN_BLLT_72'}{cb_msg module='grn.bulletin' key='GRN_BLLT-72' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_72 page=$page_info.all cid=$category_id sort='ntd' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'ntd'}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_73'}{cb_msg module='grn.bulletin' key='GRN_BLLT-73' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_73 page=$page_info.all cid=$category_id sort='ntu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_74'}{cb_msg module='grn.bulletin' key='GRN_BLLT-74' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_74 page=$page_info.all cid=$category_id sort='ntd' sp=0 disable=1}</th>
                                                {/if}
                                            {/if}
                                        </tr>
                                        {foreach from=$articles.article item=article}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                {if $use_star}<td>{grn_star_icon module='grn.bulletin' unique_id=$article.aid star_infos=$star_infos cid=$article.cid aid=$article.aid}</td>{/if}
                                                <td class="bulletin_title">
                                                    {include file='bulletin/_article_subject.tpl' view_page='bulletin/view'}
                                                </td>
                                                <td>{$article.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
                                                <td>
                                                    {if $article.manually_enter_sender != null}
                                                        {grn_sender_name name=$article.manually_enter_sender truncated=$config.name_width no_image=true}
                                                    {else}
                                                        {if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name users_info=$users_info truncated=$config.name_width}{if $article.group_name} ){/if}
                                                    {/if}
                                                </td>
                                                <td>{grn_date_format date=$article.ntime format="DateTimeCompact"}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    <div class="list">
                                        <p class="item">
                                            <div class="navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
                                        </p>
                                    </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <!--end of maincontents_list-->

{include file="grn/footer.tpl"}
