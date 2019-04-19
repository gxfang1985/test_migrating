{include file="cbpapi/header.tpl"}
<address:{$action}Response>
<returns>
{foreach from=$cards_for_view item=cards}
  {foreach from=$cards item=card}
    {include file="cbpapi/address/_view_card_content.tpl"}
  {/foreach}
{/foreach}
</returns>
</address:{$action}Response>
{include file="cbpapi/footer.tpl"}