{include file="cbpapi/header.tpl"}
    <address:{$action}Response>
    <returns>
        {foreach from=$mygroups item=mygroup}
        <my_address_group_item id="{$mygroup.id}" version="{$mygroup.version}" operation="{$mygroup.operation}" />
        {/foreach}
    </returns>
    </address:{$action}Response>
{include file="cbpapi/footer.tpl"}