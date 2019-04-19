{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$groups item=group}
        <organization_item id="{$group.id}" version="{$group.version}" operation="{$group.operation}"/>
{/foreach}
      </returns>
    </base:{$action}Response>
    
{include file="cbpapi/footer.tpl"}