{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
    <returns {if $use_pending}{grn_attr name="use_pending_approvals" value="true" require=true}{else}{grn_attr name="use_pending_approvals" value="false" require=true}{/if}
                    {if $use_proxy}{grn_attr name="use_proxy_approvals" value="true" require=true}{else}{grn_attr name="use_proxy_approvals" value="false" require=true}{/if}
                    {if $modify}{grn_attr name="modify_proxies" value="true" require=true}{else}{grn_attr name="modify_proxies" value="false" require=true}{/if} >
    </returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}