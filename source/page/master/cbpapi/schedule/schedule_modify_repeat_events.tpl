{include file="cbpapi/header.tpl"}
<schedule:ScheduleModifyRepeatEventsResponse>
<returns>
{foreach from=$results item=result}
    <result>
    {foreach from=$result item=event}
      {if $event}
        {include file="cbpapi/schedule/_show_events.tpl"}
      {/if}
    {/foreach}
    </result>
{/foreach}
</returns>
</schedule:ScheduleModifyRepeatEventsResponse>
{include file="cbpapi/footer.tpl"}