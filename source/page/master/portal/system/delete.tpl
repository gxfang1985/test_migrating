{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_delete'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="pid" value="{$portal.pid}">
    {cb_msg module='grn.portal.system' key='GRN_POT_SY-95' replace='true'}{grn_image image='portal20.gif'}<span id="delete_portal_title" class="bold">{$portal.title|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-96' replace='true'}
</form>
<script type="text/javascript">
    jQuery("#delete_portal_title").html(jQuery("#portal_setting_portal_name").html());
</script>
