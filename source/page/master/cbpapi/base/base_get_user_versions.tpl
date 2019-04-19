{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$user_item item=user}
        <user_item id="{$user.id}" version="{$user.version}" operation="{$user.operation}"/>
{/foreach}
      </returns>
    </base:{$action}Response>
    
{include file="cbpapi/footer.tpl"}