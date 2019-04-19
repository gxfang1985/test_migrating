{include file="cbpapi/header.tpl"}
    <schedule:ScheduleGetFacilityGroupsByIdResponse>
    <returns>
        {foreach from=$groups item=group}
         <facility_group {grn_attr name="id" value=$group.id require=true}
                                 {grn_attr name="name" value=$group.name require=true}
                                 {grn_attr name="version" value=$group.version require=true}
                                 {grn_attr name="order" value=$group.order}
                                 {grn_attr name="parent_facility_group" value=$group.parent} xmlns="http://schemas.cybozu.co.jp/schedule/2008">
            {foreach from=$group.children item=child_group}
              <facility_group {grn_attr name="id" value=$child_group require=true} />
            {/foreach}
            {foreach from=$group.facilities item=facility}
               <facility {grn_attr name="id" value=$facility.id require=true} />
            {/foreach}
         </facility_group>
        {/foreach}
    </returns>
    </schedule:ScheduleGetFacilityGroupsByIdResponse>
{include file="cbpapi/footer.tpl"}
