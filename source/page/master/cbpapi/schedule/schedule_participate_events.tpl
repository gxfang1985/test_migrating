{include file="cbpapi/header.tpl"}
<schedule:ScheduleParticipateEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleParticipateEventsResponse>
{include file="cbpapi/footer.tpl"}