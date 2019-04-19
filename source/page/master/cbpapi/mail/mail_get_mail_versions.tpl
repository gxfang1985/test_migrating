{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
{foreach from=$mails item=mail}
    <mail_item id="{$mail.id}" version="{$mail.version}" operation="{$mail.operation}" />
{/foreach}
</returns>
 </mail:{$action}Response>
{include file="cbpapi/footer.tpl"}