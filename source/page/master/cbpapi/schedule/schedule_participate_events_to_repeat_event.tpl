{include file="cbpapi/header.tpl"}
<schedule:ScheduleParticipateEventsToRepeatEventResponse>
<returns>
  {foreach from=$results item=result}
    <result>
    {foreach from=$result item=event}
        {include file="cbpapi/schedule/_show_events.tpl"}
    {/foreach}
    </result>
  {/foreach}
</returns>
</schedule:ScheduleParticipateEventsToRepeatEventResponse>
{include file="cbpapi/footer.tpl"}