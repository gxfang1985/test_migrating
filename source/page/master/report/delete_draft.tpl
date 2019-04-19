<form name="report/delete" method="post" action="{grn_pageurl page='report/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="rid" value="{$rid|escape}">
<p>
{cb_msg module='grn.report' key='GRN_RPRT-360' replace='true'}<br>
{grn_sentence caption=$report.name|cb_mb_truncate:30 image='report20.gif' class='bold'}
</p>
</form>
