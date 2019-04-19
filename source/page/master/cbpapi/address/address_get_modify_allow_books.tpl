{include file="cbpapi/header.tpl"}
<address:{$action}Response>
<returns>
  {foreach from=$books key=book_id item=book}
    <book_id>{$book_id}</book_id>
  {/foreach}
</returns>
</address:{$action}Response>
{include file="cbpapi/footer.tpl"}
