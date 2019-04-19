{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_base_reset'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="pid" value="{$portal.pid}">
    <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-216' replace='true'}</p>
</form>
