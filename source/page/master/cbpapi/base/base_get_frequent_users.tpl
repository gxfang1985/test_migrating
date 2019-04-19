{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$users item=user_id}
        <user_id>{$user_id}</user_id>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}