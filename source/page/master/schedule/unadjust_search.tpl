{**
 * @updated:
 *    2011/06/08 VCBSCH0010 Sync for V-CUBE
 **}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/adjust_search'}">
 <p>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-25' replace='true'}<br><br>
    {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-26' replace='true'}
    {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-27' replace='true'}<span class="bold">{$schedule.facilities|cb_mb_truncate|escape}</span>
 </p>
</form>
