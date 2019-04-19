{include file="cbpapi/header.tpl"}
    <workflow:{$action}Response>
    <returns>
        {foreach from=$applications item=application}
        <application_item id="{$application.id}" version="{$application.version}" operation="{$application.operation}" />
        {/foreach}
    </returns>
    </workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}