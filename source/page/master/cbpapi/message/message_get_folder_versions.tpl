{include file="cbpapi/header.tpl"}
<message:{$action}Response>
<returns>
{foreach from=$folders item=folder}
    <folder_item id="{$folder.id}" version="{$folder.version}" operation="{$folder.operation}" />
{/foreach}
</returns>
 </message:{$action}Response>
{include file="cbpapi/footer.tpl"}