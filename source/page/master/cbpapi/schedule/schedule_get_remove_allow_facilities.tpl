{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetRemoveAllowFacilitiesResponse>
<returns>
{foreach from=$acc_list key=facility_id item=access}
  {if $access.delete == 1}
  <facility_id>{$facility_id}</facility_id>
  {/if}
{/foreach}
</returns>
</schedule:ScheduleGetRemoveAllowFacilitiesResponse>
{include file="cbpapi/footer.tpl"}
