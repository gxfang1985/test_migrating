{grn_load_javascript file="grn/html/page/notification/mobile/pending_list.js"}
{grn_load_javascript file="grn/html/page/notification/mobile/common.js"}
{grn_load_javascript file="js/dist/notification_mobile.js"}
<script type="text/javascript">
    var __notifyCommon = grn.page.notification.mobile.common;
    {if !$is_history_list}
        __notifyCommon.postMoreUrl = '{grn_pageurl page="notification/mobile/ajax/ajaxGetMoreUnread"}';
        var __pendingPage = grn.page.notification.mobile.pendinglist;
        __pendingPage.postConfirmUrl = '{grn_pageurl page="notification/mobile/ajax/command_confirm_notification"}';
    {else}
        __notifyCommon.postMoreUrl = '{grn_pageurl page="notification/mobile/ajax/ajaxGetMoreReadNotifications"}';
    {/if}
</script>
{if !$data_theme}{assign var='data_theme' value='c'}{/if}
<div id="js_notification" data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    {include file='grn/mobile_breadcrumb.tpl' select_menu_include_file="notification/mobile/_select_menu.tpl"}

    <div class="mobile_notification_header_grn">
        {strip}
            <div class="mobile_notification_filter_base_grn">
                <div class="mobile_navi_viewchange_grn">
                    <div class="mobile_button_group_base_grn js_category"></div>
                    <div class="mobile_button_group_base_grn mobile_button_group_base_right_grn js_status"></div>
                </div>
            </div>
        {/strip}
    </div>
    <div class="js_content">
        {include file='notification/mobile/_data_list.tpl'}
    </div>
</div>
{literal}
<script>
    $(document).on("pageinit", function (event) {
        var settings = {
            element: "#js_notification",
            params: {/literal}{$data_notification|@json_encode}{literal},
            selectMenuName: "mobileSelectMenu_selectMenuNotify",
        };
        new grn.js.page.notification.mobile.Index(settings);
    });
</script>
{/literal}
