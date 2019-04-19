{include file="cbpapi/header.tpl"}
<schedule:ScheduleLeaveEventsFromRepeatEventResponse>
<returns>
  {foreach from=$results item=result}
    <result>
    {foreach from=$result item=event}
        {include file="cbpapi/schedule/_show_events.tpl"}
    {/foreach}
    </result>
  {/foreach}
</returns>
</schedule:ScheduleLeaveEventsFromRepeatEventResponse>
{include file="cbpapi/footer.tpl"}