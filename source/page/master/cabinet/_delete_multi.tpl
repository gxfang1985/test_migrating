{if ! $delete_numbers}
 <p>
{cb_msg module='grn.cabinet' key='GRN_CAB-276' replace='true'}
</p>
{else}
  {if $delete != ""}
    <p>{cb_msg module='grn.cabinet' key='GRN_CAB-278' replace='true'}<br>
    {cb_msg module='grn.cabinet' key='GRN_CAB-279' replace='true'}<span class="bold">{grn_sentence image='folder20.gif' caption=$folder_name|grn_noescape}</span><br>
    {cb_msg module='grn.cabinet' key='GRN_CAB-280' replace='true'}<span class="bold delete_count">{$delete_numbers|escape}</span>
    </p>        
  {else}
    <p>{cb_msg module='grn.cabinet' key='GRN_CAB-281' replace='true'}<br>
    {cb_msg module='grn.cabinet' key='GRN_CAB-282' replace='true'}<span class="bold">{grn_sentence image='folder20.gif' caption=$folder_name|grn_noescape}</span><br>
    {cb_msg module='grn.cabinet' key='GRN_CAB-283' replace='true'}<span class="bold  delete_count">{$delete_numbers|escape}</span>
    </p>
  {/if}
 {foreach from=$eid item=fid}
<input type="hidden" name="eid[]" value="{$fid}">
 {/foreach}
<input type="hidden" name="hid" value="{$folder_id}">
{/if}
