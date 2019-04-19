{include file="cbpapi/header.tpl"}
<message:{$action}Response>
<returns xmlns="">
    {foreach from=$threads item=thread}
        {include file="cbpapi/message/_thread_content.tpl"}
    {/foreach}
</returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}