{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
    <returns>
    {if $proxies}
        <proxies xmlns="http://schemas.cybozu.co.jp/workflow/2008">
        {foreach from=$proxies key=user_id item=proxy}
            <user_proxy {grn_attr name="user_id" value=$user_id require=true} >
              {if $proxy.proxy_approver}
                <proxy_approver {grn_attr name="approver_id" value=$proxy.proxy_approver require=true} />
              {/if}
              {if $proxy.proxy_applicant}
                <proxy_applicant {grn_attr name="applicant_id" value=$proxy.proxy_applicant require=true} />
              {/if}
            </user_proxy>
        {/foreach}
        </proxies>
    {/if}
    </returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}