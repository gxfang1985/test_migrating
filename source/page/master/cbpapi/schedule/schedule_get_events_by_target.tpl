{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetEventsByTargetResponse>
<returns>
  {foreach from=$events item=evnt}
    {foreach from=$evnt item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
    {/foreach}
  {/foreach}
</returns>
</schedule:ScheduleGetEventsByTargetResponse>
{include file="cbpapi/footer.tpl"}