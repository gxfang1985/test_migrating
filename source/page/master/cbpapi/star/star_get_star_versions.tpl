{include file="cbpapi/header.tpl"}
<star:{$action}Response>
<returns>
{foreach from=$stars item=star}
    <star_item id="{$star.id}" version="{$star.version}" operation="{$star.operation}" />
{/foreach}
</returns>
 </star:{$action}Response>
{include file="cbpapi/footer.tpl"}