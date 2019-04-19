<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/repeat_add'}">
 <p>{cb_msg module='grn.schedule' key='GRN_SCH-862' replace='true'}<br><br>
    {cb_msg module='grn.schedule' key='GRN_SCH-863' replace='true'}
    {cb_msg module='grn.schedule' key='GRN_SCH-864' replace='true'}<span class="bold">{$schedule.facilities|cb_mb_truncate|escape}</span>
 </p>
</form>
