{include file="cbpapi/header.tpl"}
<message:{$action}Response>
    <returns xmlns="">
        <personal_profile use_trash="{if $use_trash}true{else}false{/if}" trash_duration="{$duration}" />
    </returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}