{include file="cbpapi/header.tpl"}
<report:{$action}Response>
    <returns>
        {foreach from=$reports item=report}
            {include file='cbpapi/report/_report_content.tpl'}
        {/foreach}
    </returns>
 </report:{$action}Response>
{include file="cbpapi/footer.tpl"}