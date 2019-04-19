<form name="system/logging/delete_multi_files" method="post" action="{grn_pageurl page=system/logging/command_delete_multi_files}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if $delete_numbers}
 <p>{cb_msg module='grn.system.logging' key='GRN_SY_LO-146' replace='true'}<br>
{cb_msg module='grn.system.logging' key='GRN_SY_LO-147' replace='true'}<span class="bold  delete_count">{$delete_numbers|escape}</span>
 </p>
 {foreach from=$eid item=fid}
<input type="hidden" name="eid[]" value="{$fid}">
 {/foreach}
{/if}

</form>