{include file="cbpapi/header.tpl"}
<address:{$action}Response>
<returns>
{foreach from=$books item=book}
    <book_item id="{$book.id}" version="{$book.version}" operation="{$book.operation}" />
{/foreach}
</returns>
 </address:{$action}Response>
{include file="cbpapi/footer.tpl"}