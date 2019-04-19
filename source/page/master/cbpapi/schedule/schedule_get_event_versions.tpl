{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetEventVersionsResponse>
<returns>
{foreach from=$events item=event}
    <event_item id="{$event.id}" version="{$event.version}" operation="{$event.operation}" />
{/foreach}     
</returns>
 </schedule:ScheduleGetEventVersionsResponse>
{include file="cbpapi/footer.tpl"}