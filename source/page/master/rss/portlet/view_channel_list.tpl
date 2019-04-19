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
                <a href="{grn_pageurl page='rss/index'}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_rss_site_grn">
    <table class='list_column' style="{$font_size}">{strip}
        <tr>
            <td>
            {if $system_config.shared || $personal_config.shared}
                <div class="tree_item">
                    <div class="sub_title">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-27' replace='true'}</div>
                </div>
                {foreach from=$shared_sites key=key item=item}
                    {if $item.separator}
                        <div class="border-partition-common-grn"></div>
                    {else}
                        <div class="tree_item">
                            {grn_link image='folder20.gif' caption=$item.display_name truncated_caption=$subject_width page='rss/index' id=$key}
                            {if $item.notify == -1}{* フィードエラー *}
                                <a name='' title={$item.error}>
                                    {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-28' replace='true'}
                                    <span class="attention"><tt>!</tt></span>
                                    {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-29' replace='true'}
                                </a>
                            {elseif $item.notify}
                                {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-30' replace='true'}{$item.notify}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-31' replace='true'}
                            {/if}
                        </div>
                    {/if}
                {/foreach}
            {/if}
            {if ( $system_config.shared || $personal_config.shared ) && $system_config.personal}
                <div class="border-partition-common-grn"></div>
            {/if}
            {if $system_config.personal}
                <div class="tree_item">
                <div class="sub_title">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-32' replace='true'}</div>
                </div>
                {foreach from=$personal_sites key=key item=item}
                    {if $item.separator}
                        <div class="border-partition-common-grn"></div>
                    {else}
                        <div class="tree_item">
                            {grn_link image='folder20.gif' caption=$item.display_name truncated_caption=$subject_width page='rss/index' id=$key}
                            {if $item.notify == -1}{* フィードエラー *}
                                <a name='' title={$item.error}>
                                    {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-33' replace='true'}
                                    <span class="attention"><tt>!</tt></span>
                                    {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-34' replace='true'}
                                </a>
                            {elseif $item.notify}
                                {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-35' replace='true'}{$item.notify}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-36' replace='true'}
                            {/if}
                        </div>
                    {/if}
                {/foreach}
            {/if}
            {if $system_config.personal}
                <div class="mBottom3">
                    <form name='rss_add_site' method='post' action="{grn_pageurl page='rss/portlet/command_view_channel_list'}">
                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                        <span class="sub_title element_grn mRight5">{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-37' replace='true'}</span>
                        <input class="input_text_grn mRight3" name="site" size="20" maxlength="255">
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="jQuery(this).parents('form').submit();return false;">
                                <span>{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-38' replace='true'}</span>
                            </a>
                        </span>
                        <input type='hidden' name='page' value='{$page}'>
                    </form>
                </div>
            {/if}
            </td>
        </tr>
    </table>{/strip}
</div> <!--end of portal_frame -->

