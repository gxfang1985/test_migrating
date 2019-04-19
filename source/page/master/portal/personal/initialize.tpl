{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_initialize'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-168' replace='true'}{$app_name|escape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-169' replace='true'}</p>
    {grn_image image='portal20.gif'}<span id="initialize_portal_title" class="bold">{$portal.title|escape}</span>
    <input type="hidden" name="pid" value="{$portal.pid}">
</form>
<script type="text/javascript">
    jQuery("#initialize_portal_title").html(jQuery("#portal_setting_portal_name").html());
</script>
