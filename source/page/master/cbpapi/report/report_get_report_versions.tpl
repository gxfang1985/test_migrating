{include file="cbpapi/header.tpl"}
<report:{$action}Response>
<returns>
    {foreach from=$reports item=report}
        <report_item id="{$report.id}" version="{$report.version}" operation="{$report.operation}" />
    {/foreach}
</returns>
</report:{$action}Response>
{include file="cbpapi/footer.tpl"}