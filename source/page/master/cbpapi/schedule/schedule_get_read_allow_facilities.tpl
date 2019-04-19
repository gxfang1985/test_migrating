{include file='cbpapi/header.tpl'}
<schedule:ScheduleGetReadAllowFacilitiesResponse >
<returns>
{foreach from=$facilities item=facilitie}
<facility_id>{$facilitie._id}</facility_id>
{/foreach}
</returns>
</schedule:ScheduleGetReadAllowFacilitiesResponse>
{include file='cbpapi/footer.tpl'}