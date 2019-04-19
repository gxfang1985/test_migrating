{include file="sysapi/header.tpl"}

<admin:GetRequestTokenResponse>
    <returns>
        <request_token>{$csrf_ticket}</request_token>
    </returns>
</admin:GetRequestTokenResponse>

{include file="sysapi/footer.tpl"}