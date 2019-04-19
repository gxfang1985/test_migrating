{include file="cbpapi/header.tpl"}
<schedule:ScheduleRemoveEventsFromRepeatEventResponse>
<returns>
{if $results}
    {foreach from=$results item=result}
    <result>
    {foreach from=$result item=event}
        {include file="cbpapi/schedule/_show_events.tpl"}
    {/foreach}
    </result>
  {/foreach}
{/if}
</returns>
</schedule:ScheduleRemoveEventsFromRepeatEventResponse>
{include file="cbpapi/footer.tpl"}