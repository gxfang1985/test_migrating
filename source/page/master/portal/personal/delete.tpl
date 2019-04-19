{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_delete'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-170' replace='true'}{$app_name|escape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-171' replace='true'}</p>
    {grn_image image='portal20.gif'}<span id="delete_portal_title" class="bold">{$portal.title|escape}</span>
    <input type="hidden" name="pid" value="{$portal.pid}">
</form>
<script type="text/javascript">
    jQuery("#delete_portal_title").html(jQuery("#portal_setting_portal_name").html());
</script>
