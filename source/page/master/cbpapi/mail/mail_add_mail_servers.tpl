{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
    {foreach from=$servers item=server}
        {include file="cbpapi/mail/_mail_server_content.tpl"}
    {/foreach}
</returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}