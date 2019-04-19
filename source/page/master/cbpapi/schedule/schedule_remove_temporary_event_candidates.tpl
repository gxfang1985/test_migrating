{include file="cbpapi/header.tpl"}
<schedule:ScheduleRemoveTemporaryEventCandidatesResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleRemoveTemporaryEventCandidatesResponse>
{include file="cbpapi/footer.tpl"}