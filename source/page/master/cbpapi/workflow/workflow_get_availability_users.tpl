{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
    <returns>
        {foreach from=$users key=uid item=user}
            <user id="{$user.id}" workflow="{$user.workflow}" keitai="{$user.keitai}" />
        {/foreach}
    </returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}