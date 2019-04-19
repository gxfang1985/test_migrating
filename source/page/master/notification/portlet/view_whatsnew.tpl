{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
    {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
    {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
    {assign var="fontsize" value='font-size:60%;'}
{else}
    {assign var="font_size" value=''}
    {assign var="fontsize" value='font-size:80%;'}
{/if}
<div id="js_notification_portlet_{$portlet.plid}">
    <div class="portal_frame portal_frame_update_grn js_content">
        {strip}
        <form name="notification" method="post" action="{grn_pageurl page='notification/portlet/command_view_whatsnew'}">
            <table class="list_column" style="{$font_size}">
                <tbody>
                <tr class="js_filter">
                    <td colspan="6" class="top_title">
                        <div class="notification_filter_base_grn">
                            <div class="navi_viewchange_grn mRight10">
                                <span class="portlet_title_grn mRight15">
                                    {grn_link
                                    page='notification/index'
                                    class='js_notification_portlet_link'
                                    is_to_me=$is_to_me
                                    read=$is_read
                                    caption=$page_title}
                                </span>
                                <div class="button_group_space_grn js_category"></div>
                                <div class="inline_block_grn js_status"></div>
                            </div>
                            <div class="action_button_base_grn">
                                {capture name='grn_notification_portlet_GRN_NTFC_204'}{cb_msg module='grn.notification' key='GRN_NTFC-204' replace='true'}{/capture}
                                <button class="action_base_grn button_style_off_grn js_refresh" title="{$smarty.capture.grn_notification_portlet_GRN_NTFC_204}" aria-label="{$smarty.capture.grn_notification_portlet_GRN_NTFC_204}">
                                    <span class="icon_refresh_grn icon_inline_grn icon_only_grn"></span>
                                </button>
                            </div>
                        </div>
                    </td>
                </tr>
                {include file="notification/portlet/_view_whatsnew_content.tpl"}
                </tbody>
            </table>
        </form>
        {/strip}
    </div> <!--end of portal_frame -->
</div>
{literal}
<script>
    (function () {
        new grn.js.component.notification.ui.NotificationPortlet({
            {/literal}
            element: "#js_notification_portlet_{$portlet.plid}",
            params: {$data_portlet|@json_encode}
            {literal}
        }).render();
    })();
</script>
{/literal}