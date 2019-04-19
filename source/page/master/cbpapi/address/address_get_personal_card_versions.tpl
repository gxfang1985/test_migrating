{include file="cbpapi/header.tpl"}
<address:{$action}Response>
<returns>
{foreach from=$cards item=card}
    <card_item id="{$card.id}" version="{$card.version}" operation="{$card.operation}" />
{/foreach}
</returns>
 </address:{$action}Response>
{include file="cbpapi/footer.tpl"}