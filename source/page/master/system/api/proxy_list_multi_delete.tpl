<form name="system/api/proxy_api_multi_delete" method="post"
      action="{grn_pageurl page='system/api/command_proxy_list'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cmd" value="delete">
    <p>
        {cb_msg module='grn.system.api' key='proxy_api_multi_delete_confirmation_prefix' replace='true'}<span class="bold delete_count"></span>{cb_msg module='grn.system.api' key='proxy_api_multi_delete_confirmation_postfix' replace='true'}<br>
    </p>
</form>