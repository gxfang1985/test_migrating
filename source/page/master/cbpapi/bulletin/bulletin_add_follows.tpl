{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
<returns xmlns="">
    {foreach from=$topics item=topic}
        {include file="cbpapi/bulletin/_topic_content.tpl"}
    {/foreach}
</returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}