{include file='cbpapi/header.tpl'}
<schedule:ScheduleSearchEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleSearchEventsResponse>
{include file='cbpapi/footer.tpl'}