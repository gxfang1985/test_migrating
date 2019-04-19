{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetModifyAllowFacilitiesResponse>
<returns>
{foreach from=$acc_list item=facility_id}
  <facility_id>{$facility_id}</facility_id>
{/foreach}
</returns>
</schedule:ScheduleGetModifyAllowFacilitiesResponse>
{include file="cbpapi/footer.tpl"}
