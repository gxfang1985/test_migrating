{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
    {foreach from=$mails item=mail}
        {include file="cbpapi/mail/_mail_content.tpl"}
    {/foreach}
</returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}