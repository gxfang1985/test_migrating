<form name="workflow/delete_multi" method="post" action="{grn_pageurl page='workflow/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div class="explanation">
{cb_msg module='grn.workflow' key='GRN_WKF_6' replace='true'}<br>
{cb_msg module='grn.workflow' key='GRN_WKF_7' replace='true'}{$folder_name}<br>
{cb_msg module='grn.workflow' key='GRN_WKF_8' replace='true'}<span class="bold delete_count"></span><br>
</div>
</p>
<input type="hidden" name="fid" value="{$fid|escape}">
</form>
