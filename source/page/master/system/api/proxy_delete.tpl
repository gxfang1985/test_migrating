<form name="system/api/proxy_delete" method="post" action="{grn_pageurl page='system/api/command_proxy_delete'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="id" value="{$proxy->getId()|escape}">
    <p>
        {cb_msg module='grn.system.api' key='proxy_api_delete_confirmation_prefix' replace='true'}<span class="bold">{$proxy->getCode()|cb_mb_truncate|escape}</span>{cb_msg module='grn.system.api' key='proxy_api_delete_confirmation_postfix' replace='true'}<br>
    </p>
</form>