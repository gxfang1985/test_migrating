{include file="cbpapi/header.tpl"}
<address:{$action}Response>
<returns>
  {foreach from=$my_groups item=mgroup}
    <my_address_group {grn_attr name="id" value=$mgroup.id require=true}
                                   {grn_attr name="name" value=$mgroup.name require=true}
                                   {grn_attr name="version" value=$mgroup.version require=true}
                                   {grn_attr name="description" value=$mgroup.description}
                                   />
  {/foreach}
</returns>
</address:{$action}Response>
{include file="cbpapi/footer.tpl"}
