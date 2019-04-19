{include file="cbpapi/header.tpl"}
<schedule:ScheduleLeaveEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleLeaveEventsResponse>
{include file="cbpapi/footer.tpl"}