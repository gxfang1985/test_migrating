<input id="is_show_single" type="hidden" value="{$is_show_single}"/>
<div class="mobile_separation_line_grn"></div>
{strip}
{if $data_list|@count >=1 }
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_notification_list_grn" id="notification_data_list">
        {foreach from=$data_list key=key item=item}
            {if !($is_history_list && $key == '0')}
                <div class="mobile_notification_listtitle_grn" id="{$item.short_id}_title">{$item.label|escape}</div>
            {/if}
            <input type="hidden" id="{$item.short_id}_count_num" value="{$item.list|@count}"/>
            {include file='notification/mobile/_items.tpl' list=$item.list short_id=$item.short_id}
            {if $item.more}
                <div id="{$item.short_id}_more_div" class="mobile_notification_showMore_grn">
                    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn">
                        <li class="mobile-showMore-grn">
                            <input type="hidden" value="{$item.sp}" id="{$item.short_id}_sp"/>
                            <input type="hidden" value="{$item.lastDataId}" id="{$item.short_id}_last_data_id"/>
                            <div data-role="button"  data-theme="{$data_theme}" aria-disabled="false" onclick="__notifyCommon.getMoreNotificationList('{$key}')">{cb_msg module='grn.mobile' key='more_button' replace='true'}</div>
                        </li>
                    </ul>
                </div>
            {/if}
        {/foreach}
    </ul>
{else}
    <div class="mobile_balloon_grn">
        {if $show_has_unread_all}
            {cb_msg module='grn.notification.mobile' key='GRN_NTFC-7' replace='true'}
            <a class="js_has_unread_all ui-link" href="javascript:void(0)">
                {cb_msg module='grn.notification.mobile' key='GRN_NTFC-8' replace='true'}
            </a>
            {cb_msg module='grn.notification.mobile' key='GRN_NTFC-9' replace='true'}
        {else}
            {cb_msg module='grn.notification.mobile' key='GRN_NTFC-4' replace='true'}
        {/if}
    </div>
    <div class="mobile_balloon_down_grn">
        <div class="mobile_triangle_grn"></div>
    </div>
    <div class="mobile_balloon_icon_grn">
        <div class="mobile_app_notification_b_grn"></div>
    </div>
{/if}
{/strip}