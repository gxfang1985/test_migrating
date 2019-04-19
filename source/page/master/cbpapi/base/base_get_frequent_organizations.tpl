{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$groups item=group_id}
        <organization_id>{$group_id}</organization_id>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}