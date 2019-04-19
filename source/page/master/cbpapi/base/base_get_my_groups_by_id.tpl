{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$mygroup item=group}
        <my_group {grn_attr name="key" value=$group.key require=true} {grn_attr name="name" value=$group.name require=true} 
        {grn_attr name="version" value=$group.version require=true}
        {grn_attr name="description" value=$group.description}
        {grn_attr name="order" value=$group.order}>
{foreach from=$group.belong_member item=member_id}
          <belong_member>{$member_id}</belong_member>
{/foreach}
{foreach from=$group.belong_facility item=facility_id}
          <belong_facility>{$facility_id}</belong_facility>
{/foreach}
        </my_group>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}