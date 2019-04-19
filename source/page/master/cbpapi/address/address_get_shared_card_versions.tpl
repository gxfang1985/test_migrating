{include file="cbpapi/header.tpl"}
<address:AddressGetSharedCardVersionsResponse>
<returns>
    {foreach from=$cards item=card}
    <card_item id="{$card.id}" version="{$card.version}" operation="{$card.operation}" />
    {/foreach}
</returns>
 </address:AddressGetSharedCardVersionsResponse>
{include file="cbpapi/footer.tpl"}