<form name="customization/group_delete" method="post" action="{grn_pageurl page=$command_page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cmd" value="delete">
    <input type="hidden" name="id" value="{$id|escape}">
    <p>
        {strip}
            {cb_msg module='grn.customization' key='customization.group_view.delete_confirmation1' replace='true'}
            <span class="bold">{$name|cb_mb_truncate|escape}</span>
            {cb_msg module='grn.customization' key='customization.group_view.delete_confirmation2' replace='true'}
        {/strip}
    </p>
</form>