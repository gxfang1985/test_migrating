{include file="cbpapi/header.tpl"}
    <schedule:ScheduleGetFacilitiesByIdResponse>
    <returns>
        {foreach from=$facilities item=facility}
            <facility {grn_attr name="key" value=$facility._id require=true}
                           {grn_attr name="name" value=$facility.col_name require=true}
                           {grn_attr name="description" value=$facility.col_memo}
                           {grn_attr name="order" value=$facility.col_list_index}
                           {grn_attr name="version" value=$facility.col_mtime require=true}
                           {grn_attr name="facility_code" value=$facility.col_foreign_key}
                           {grn_attr name="belong_facility_group" value=$facility.col_group} />
        {/foreach}
    </returns>
    </schedule:ScheduleGetFacilitiesByIdResponse>
{include file="cbpapi/footer.tpl"}
