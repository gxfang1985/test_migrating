{if $settings.font_size == 'large'}
    {assign var='font_size' value='font-size:140%;'}
{elseif $settings.font_size == 'normal'}
    {assign var='font_size' value=''}
{elseif $settings.font_size == 'small'}
    {assign var='font_size' value='font-size:70%;'}
{/if}

{if $settings.blank}
    {assign var='target' value='_blank'}
{else}
    {assign var='target' value=''}
{/if}

<table class='top_title'>{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
            {if $settings.channel}
                <a href="{grn_pageurl page='rss/index' id=$settings.channel}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                </a>
                <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-1' replace='true'}</span>
                <span class="nowrap-grn mRight3 mLeft3">
                    <a target="_blank" href="{$settings.channel_url|escape}" class="icon_folder_b_grn icon_inline_grn">
                        {$settings.channel_name|escape}
                    </a>
                </span>
                <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-2' replace='true'}</span>
                {if $settings.new_item_num > 0}
                <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-3' replace='true'}</span>
                    {$settings.new_item_num}
                <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-4' replace='true'}</span>
                {elseif $settings.has_error}
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-5' replace='true'}</span>
                    <span class="attention">
                        <tt>!</tt>
                    </span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-6' replace='true'}</span>
                {/if}
            {else}
                <a href="{grn_pageurl page='rss/index'}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                    {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-7' replace='true'}
                </a>
            {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_rss_article_grn">
{if $settings.channel}
    <table class='list_column' width='100%' border='1' cellspacing='0' cellpadding='2' style="{$font_size}">
        <tr>
            <th nowrap>{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-8' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-9' replace='true'}</th>
        </tr>
        {foreach from=$items item=item}
            {if $item.is_new}
                {assign var='item_class' value='rss_new'}
            {else}
                {assign var='item_class' value='rss'}
            {/if}
            <tr>
                <td nowrap>{grn_link_raw class="$item_class" image='linklist16.gif' caption=$item.title truncated_caption=$subject_width page=$item.link target=$target no_script="true"}</td>
                <td nowrap>{grn_date_format date=$item.date format='DateTimeCompact'}</td>
            </tr>
        {/foreach}
    </table>
{/if}
</div> <!--end of portal_frame -->
