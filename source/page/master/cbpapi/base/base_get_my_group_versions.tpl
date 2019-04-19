{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$mygroup item=group}
        <my_group_item id="{$group.id}" version="{$group.version}" operation="{$group.operation}"/>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}