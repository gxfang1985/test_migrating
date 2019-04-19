{include file="cbpapi/header.tpl"}
<schedule:ScheduleDetermineTemporaryEventsResponse>
<returns>
  {foreach from=$events item=event}
    {include file="cbpapi/schedule/_show_events.tpl"}
  {/foreach}
</returns>
</schedule:ScheduleDetermineTemporaryEventsResponse>
{include file="cbpapi/footer.tpl"}