{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
<returns>
{foreach from=$folders item=folder}
    <category_item id="{$folder.id}" version="{$folder.version}" operation="{$folder.operation}" />
{/foreach}
</returns>
 </bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}