{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
 </schedule:ScheduleGetEventsResponse>
{include file="cbpapi/footer.tpl"}