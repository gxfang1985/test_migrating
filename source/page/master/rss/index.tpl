{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{include file='rss/_title_search.tpl'}

<div class="mainarea">
    <table class="maincontents_list">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <table width="100%">
                        <tr valign="top">
                            <td id="tree_part" width="23%">
                                {if $system_config.shared || $personal_config.shared}
                                    <div class="sub_title">{cb_msg module='grn.rss' key='GRN_RSS-11' replace='true'}</div>
                                    {foreach from=$shared_sites key=key item=item}
                                        {if $item.separator}
                                            <div class="border-partition-common-grn"></div>
                                        {else}
                                            <div class="tree_item">
                                                {if $key == $sid}<div class="hilight"><span class="bold">{else}<div><span>{/if}
                                                {grn_link image='folder20.gif' caption=$item.display_name page='rss/index' id=$key}
                                                {if $item.notify == -1}{* フィードエラー *}
                                                    <a name='' title={$item.error}>{cb_msg module='grn.rss' key='GRN_RSS-12' replace='true'}<span class="attention"><tt>!</tt></span>{cb_msg module='grn.rss' key='GRN_RSS-13' replace='true'}</a>
                                                {elseif $item.notify}
                                                    {cb_msg module='grn.rss' key='GRN_RSS-14' replace='true'}{$item.notify}{cb_msg module='grn.rss' key='GRN_RSS-15' replace='true'}
                                                {/if}
                                                </span></div>
                                            </div>
                                        {/if}
                                    {/foreach}
                                {/if}

                                {if ( $system_config.shared || $personal_config.shared ) && $system_config.personal}
                                    <div class="border-partition-common-grn"></div>
                                {/if}

                                {if $system_config.personal}
                                    <div class="sub_title">{cb_msg module='grn.rss' key='GRN_RSS-16' replace='true'}</div>
                                    {foreach from=$personal_sites key=key item=item}
                                        {if $item.separator}
                                            <div class="border-partition-common-grn"></div>
                                        {else}
                                            <div class="tree_item">
                                                {if $key == $sid}<div class="hilight"><span class="bold">{else}<div><span>{/if}
                                                    {grn_link image='folder20.gif' caption=$item.display_name page='rss/index' id=$key}
                                                    {if $item.notify == -1}{* フィードエラー *}
                                                        <a name='' title={$item.error}>{cb_msg module='grn.rss' key='GRN_RSS-17' replace='true'}<span class="attention"><tt>!</tt></span>{cb_msg module='grn.rss' key='GRN_RSS-18' replace='true'}</a>
                                                    {elseif $item.notify}
                                                        {cb_msg module='grn.rss' key='GRN_RSS-19' replace='true'}{$item.notify}{cb_msg module='grn.rss' key='GRN_RSS-20' replace='true'}
                                                    {/if}
                                                </span></div>
                                            </div>
                                        {/if}
                                    {/foreach}

                                    <p>
                                    <form name='rss_add_site' method='post' action="{grn_pageurl page='rss/command_'|cat:$page_info.last}">
                                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                        <div class="sub_title">{cb_msg module='grn.rss' key='GRN_RSS-21' replace='true'}</div>
                                        <nobr>
                                            {grn_text name='site' size='30' maxlength='255' id="new-rss-url"}
                                            {capture name='grn_rss_GRN_RSS_24'}{cb_msg module='grn.rss' key='GRN_RSS-24' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_rss_GRN_RSS_24 id="add-rss-submit"}
                                        </nobr>
                                        <input type='hidden' name='id' value='{$sid}'>
                                    </form>
                                {/if}
                            </td>
                            <td id="view_part" width="70%">

                            {if $personal_config.blank}{assign var='target' value='_blank'}{else}{assign var='target' value=''}{/if}

                            {if $site}
                                {if $is_personal}
                                    <div style="float:right">
                                        <!--delete-->
                                        {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                                        <!--delete-->
                                        {capture name='grn_rss_GRN_RSS_25'}{cb_msg module='grn.rss' key='GRN_RSS-25' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_rss_GRN_RSS_25 id='lnk_delete' script='javascript:void(0);'}
                                    </div>
                                {/if}
                                <div class="bold">{grn_link_raw image='folder20.gif' page=$site.link caption=$site.display_name target=$target no_script="true"}</div>
                                {include file='grn/memo.tpl' category_memo=$site.description}
                            {/if}

                            <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
                                <table class="list_column">
                                    <tr>
                                        <th nowrap>{cb_msg module='grn.rss' key='GRN_RSS-26' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.rss' key='GRN_RSS-27' replace='true'}</th>
                                    </tr>
                                    {foreach from=$items item=item}
                                        {if $item.is_new}
                                            {assign var='item_class' value='rss_new'}
                                        {else}
                                            {assign var='item_class' value='rss'}
                                        {/if}
                                        <tr class="{cycle values='linetwo,lineone'}">
                                            <td nowrap>{grn_link_raw class="$item_class" image='linklist20.gif' caption=$item.title truncated_caption=$subject_width page=$item.link target=$target no_script="true"}</td>
                                            <td nowrap>{grn_date_format date=$item.date format='DateTimeCompact'}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                            <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </tbody>
</table>
<!--end of maincontents_list-->

<!--footer-->
{include file='grn/footer.tpl'}
