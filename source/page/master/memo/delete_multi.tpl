{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.memo' key='GRN_MEM-65' replace='true'}<br><br>
 
{if $folder_id}
{cb_msg module='grn.memo' key='GRN_MEM-59' replace='true'}{$folder.name}
{else}
{cb_msg module='grn.memo' key='lastest_folder_name'}
{/if}
<br>
 {cb_msg module='grn.memo' key='GRN_MEM-64' replace='true'}<span class="bold delete_count"></span>
 </p>
<input type="hidden" name="did" value="{$folder_id|escape}">
{foreach from=$eid item=id}
<input type="hidden" name="eid[]" value="{$id|escape}">
{/foreach}
</form>