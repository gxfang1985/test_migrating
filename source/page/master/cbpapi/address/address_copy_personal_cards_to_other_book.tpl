{include file="cbpapi/header.tpl"}

    <address:{$action}Response>
        <returns>
          {foreach from=$copied_books item=cards}
          {foreach from=$cards item=card}
            {include file="cbpapi/address/_view_card_content.tpl"}
          {/foreach}
          {/foreach}
        </returns>
    </address:{$action}Response>
    
{include file="cbpapi/footer.tpl"}