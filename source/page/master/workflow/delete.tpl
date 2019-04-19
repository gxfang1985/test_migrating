<form name="workflow/delete" method="post" action="{grn_pageurl page='workflow/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div class="explanation">
{cb_msg module='grn.workflow' key='GRN_WKF_12' replace='true'}<br>
{cb_msg module='grn.workflow' key='GRN_WKF_7' replace='true'}{cb_msg module='grn.workflow' key="col_folder_type_`$folder.col_folder_type`"}<br>
{cb_msg module='grn.workflow' key='GRN_WKF_17' replace='true'}<span class="bold"> {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url} {$petition.name|escape|cb_mb_truncate:30}</span><br>
</div>
</p>
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="pid" value="{$pid|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
</form>
