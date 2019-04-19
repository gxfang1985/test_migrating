<form name="customization/group_delete_multi" method="post" action="{grn_pageurl page=$command_page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cmd" value="delete">
    <p>
        {strip}
            {cb_msg module='grn.customization' key='customization.group_list.multi_delete_confirmation1' replace='true'}
            <span class="bold delete_count"></span>
            {cb_msg module='grn.customization' key='customization.group_list.multi_delete_confirmation2' replace='true'}
        {/strip}
    </p>
</form>