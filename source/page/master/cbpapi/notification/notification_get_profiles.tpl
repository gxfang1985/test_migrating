{include file="cbpapi/header.tpl"}
<notification:{$action}Response>
    <returns xmlns="">
        <personal_profile {grn_attr name="save_notification_duration" value=$notify_savedays}
                          {grn_attr name="save_notification_history_duration" value=$history_savedays} />
    </returns>
</notification:{$action}Response>
{include file="cbpapi/footer.tpl"}