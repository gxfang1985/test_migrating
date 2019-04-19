{include file="cbpapi/header.tpl"}
<schedule:ScheduleModifyEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleModifyEventsResponse>
{include file="cbpapi/footer.tpl"}