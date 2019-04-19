{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetFacilityProfilesById>
    <returns>
        {foreach from=$facility_settings item=setting key=facility_id}
            <facility_profile
                {grn_attr name="key" value=$facility_id require=true}
                {grn_attr name="approval_required" value=$setting.approval require=true}
            />
        {/foreach}
    </returns>
</schedule:ScheduleGetFacilityProfilesById>
{include file="cbpapi/footer.tpl"}