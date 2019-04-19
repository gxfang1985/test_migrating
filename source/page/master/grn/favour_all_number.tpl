{strip}
    <button class="cloudHeader-grnNotificationTitle-grn button_style_off_grn"
            type="button" id="cloudHeader-grnFavourTitle-grn"
            aria-controls="popup_favour_header"
            aria-haspopup="true" aria-expanded="false"
            title="{$favour_menu_title}"
            aria-label="{$favour_menu_title}">
        <span id="favour_title">
            <span class="cloudHeader_reaction_icon_grn"></span>
            <span id="favour_notify_number" class="cloudHeader-grnNotification-count-grn"
                  {if $number_of_favour == 0}style="display:none"{/if}>
                {$number_of_favour}
            </span>
        </span>
    </button>
{/strip}
