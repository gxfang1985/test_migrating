{include file="cbpapi/header.tpl"}
<message:{$action}Response>
    <returns xmlns="">
        <personal_profile use_trash="{if $use_trash}true{else}false{/if}" trash_duration="{$duration}" />
        {if $include_system_profile}
        <system_profile check_send_confirm="{if $check_send_confirm}true{else}false{/if}" confirm_action="{$confirm_action}" />
        {/if}
    </returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}