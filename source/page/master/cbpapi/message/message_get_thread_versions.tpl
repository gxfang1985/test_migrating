{include file="cbpapi/header.tpl"}
<message:{$action}Response>
<returns>
{foreach from=$threads item=thread}
    <thread_item id="{$thread.id}" version="{$thread.version}" operation="{$thread.operation}" />
{/foreach}
</returns>
 </message:{$action}Response>
{include file="cbpapi/footer.tpl"}