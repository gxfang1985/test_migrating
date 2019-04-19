{include file='cbpapi/header.tpl'}
<schedule:ScheduleAddFollowsResponse >
<returns>
{foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
{/foreach}
</returns>
</schedule:ScheduleAddFollowsResponse>
{include file='cbpapi/footer.tpl'}