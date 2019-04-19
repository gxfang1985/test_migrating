{include file="cbpapi/header.tpl"}
<notification:{$action}Response>
<returns>
{foreach from=$notifications item=notification}
    <notification_history_item version="{$notification.version}" operation="{$notification.operation}" >
        <notification_id module_id="{$notification.module_id}" item="{$notification.item}" />
    </notification_history_item>
{/foreach}
</returns>
 </notification:{$action}Response>
{include file="cbpapi/footer.tpl"}