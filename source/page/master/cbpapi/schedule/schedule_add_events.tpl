{include file="cbpapi/header.tpl"}
<schedule:ScheduleAddEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleAddEventsResponse>
{include file="cbpapi/footer.tpl"}