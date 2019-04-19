{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetEventsByIdResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleGetEventsByIdResponse>
{include file="cbpapi/footer.tpl"}
