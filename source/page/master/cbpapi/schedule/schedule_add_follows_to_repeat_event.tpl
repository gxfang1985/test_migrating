{include file='cbpapi/header.tpl'}
<schedule:ScheduleAddFollowsToRepeatEventResponse>
<returns>
{foreach from=$events item=event_spare}
<result>
{foreach from=$event_spare item=event}
{include file="cbpapi/schedule/_show_events.tpl"}
{/foreach}
</result>
{/foreach}
</returns>
</schedule:ScheduleAddFollowsToRepeatEventResponse>
{include file='cbpapi/footer.tpl'}