{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
    <returns>
      {foreach from=$delegators item=delegator}
        <delegator_id>{$delegator.user}</delegator_id>
      {/foreach}
    </returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}