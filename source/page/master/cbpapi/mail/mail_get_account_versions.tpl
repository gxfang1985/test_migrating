{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
{foreach from=$accounts item=account}
    <account_item id="{$account.id}" version="{$account.version}" operation="{$account.operation}" />
{/foreach}
</returns>
 </mail:{$action}Response>
{include file="cbpapi/footer.tpl"}