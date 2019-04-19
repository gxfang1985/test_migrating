{include file="cbpapi/header.tpl"}
    <schedule:ScheduleGetFacilityGroupsVersionsResponse>
    <returns>
        {foreach from=$groups item=group}
        <facility_group_item id="{$group.id}" version="{$group.version}" operation="{$group.operation}" />
        {/foreach}
    </returns>
    </schedule:ScheduleGetFacilityGroupsVersionsResponse>
{include file="cbpapi/footer.tpl"}