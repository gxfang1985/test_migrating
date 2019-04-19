{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetFacilityProfileVersions>
    <returns>
        {foreach from=$facilities item=facility}
            <facility_profile_item id="{$facility.id}" version="{$facility.version}" operation="{$facility.operation}" />
        {/foreach}
    </returns>
</schedule:ScheduleGetFacilityProfileVersions>
{include file="cbpapi/footer.tpl"}
