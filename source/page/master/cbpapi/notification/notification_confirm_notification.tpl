{include file="cbpapi/header.tpl"}
<notification:{$action}Response>
    <returns xmlns="">
        {foreach from=$notifications item=notification}
            {include file="cbpapi/notification/_notification_content.tpl"}
        {/foreach}
    </returns>
</notification:{$action}Response>
{include file="cbpapi/footer.tpl"}