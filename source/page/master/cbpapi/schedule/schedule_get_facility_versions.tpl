{include file="cbpapi/header.tpl"}
    <schedule:ScheduleGetFacilityVersionsResponse>
    <returns>
        {foreach from=$facilities item=facility}
        <facility_item id="{$facility.id}" version="{$facility.version}" operation="{$facility.operation}" />
        {/foreach}
    </returns>
    </schedule:ScheduleGetFacilityVersionsResponse>
{include file="cbpapi/footer.tpl"}