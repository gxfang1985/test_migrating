{include file='cbpapi/header.tpl'}
<schedule:ScheduleGetAddAllowFacilitiesResponse >
<returns>
{foreach from=$facilities item=facilitie}
<facility_id>{$facilitie._id}</facility_id>
{/foreach}
</returns>
</schedule:ScheduleGetAddAllowFacilitiesResponse>
{include file='cbpapi/footer.tpl'}