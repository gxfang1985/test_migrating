{if $delete_continue}
<p>
{cb_msg module='grn.memo' key='GRN_MEM-163' replace='true'}<br>
{cb_msg module='grn.memo' key='GRN_MEM-164' replace='true'}
</p> 
{/if}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
{if ! $folder}
{cb_msg module='grn.memo' key='GRN_MEM-165' replace='true'}{$app_name}{cb_msg module='grn.memo' key='GRN_MEM-166' replace='true'} </p>
{else}
{cb_msg module='grn.memo' key='GRN_MEM-167' replace='true'}{$app_name}{cb_msg module='grn.memo' key='GRN_MEM-168' replace='true'}<br><br>
{cb_msg module='grn.memo' key='GRN_MEM-130' replace='true'}:{grn_sentence caption=$folder.name class='bold' image='folder20.gif'}

{/if}
<input type="hidden" name="did" value="{$folder_id}">
</form>
