{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
<returns>
    {foreach from=$topics item=topic}
        {foreach from=$topic item=topic}
            {include file="cbpapi/bulletin/_topic_content.tpl"}
        {/foreach}
    {/foreach}
</returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}