{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
<returns>
    {foreach from=$applications item=application}
        {include file="cbpapi/workflow/_application_content.tpl"}
    {/foreach}
</returns>
 </workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}