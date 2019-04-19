<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/sandbox/command_index'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="command" value="delete">
    <p>
        <span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-15' replace='true'}</span>
    </p>
</form>
