{strip}
    <button class="cloudHeader-grnNotificationTitle-grn button_style_off_grn"
            type="button" id="cloudHeader-grnNotificationTitle-grn"
            aria-controls="popup_notification_header"
            aria-haspopup="true" aria-expanded="false"
            title="{$notification_menu_title}"
            aria-label="{$notification_menu_title}">
        <span id="notification_title">
            <span class="cloudHeader-notification-icon-grn"></span>
            <span id="notification_number" class="cloudHeader-grnNotification-count-grn"
                  {if $number_of_notification == 0}style="display:none"{/if}>
                {$number_of_notification}
            </span>
        </span>
    </button>
{/strip}
