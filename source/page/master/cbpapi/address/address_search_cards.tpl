{include file="cbpapi/header.tpl"}

    <address:{$action}Response>
        <returns>
          {foreach from=$cards item=card}
            {include file="cbpapi/address/_view_card_content.tpl"}
          {/foreach}
        </returns>
    </address:{$action}Response>
    
{include file="cbpapi/footer.tpl"}