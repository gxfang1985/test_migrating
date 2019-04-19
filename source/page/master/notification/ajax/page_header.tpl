{include file="grn/xss_prevent.tpl"}
{strip}
    <div id="js_page_header_notification">
        <div class="notification_filter_base_grn">
            <div class="navi_viewchange_grn">
                <div class="button_group_space_grn js_category"></div>
                <div class="inline_block_grn js_status"></div>
            </div>
            <div class="action_button_base_grn">
                {capture name='grn_notification_portlet_GRN_NTFC_204'}
                    {cb_msg module='grn.notification' key='GRN_NTFC-204' replace='true'}
                {/capture}
                <button class="action_base_grn button_style_off_grn js_refresh"
                        title="{$smarty.capture.grn_notification_portlet_GRN_NTFC_204}"
                        aria-label="{$smarty.capture.grn_notification_portlet_GRN_NTFC_204}">
                    <span class="icon_refresh_grn icon_inline_grn icon_only_grn"></span>
                </button>
            </div>
        </div>

        <div class="list_message_grn js_message"></div>

        <ul class="js_content">
            {include file="notification/ajax/_page_header_body.tpl"}
        </ul>
        <div class="cloudHeader-grnNotification-item-grn js_more" style="display: none">
            {grn_link page='notification/index' caption=$notification_app_name}
        </div>
    </div>
{/strip}
{include file="grn/end_xss_prevent.tpl"}
{literal}
<script>
    (function () {
        new grn.js.component.common.ui.page_header.NotificationDropDownList({
        {/literal}
            element: "#js_page_header_notification",
            params: {$data_notification|@json_encode}
            {literal}
        }).render();
    })();
</script>
{/literal}


