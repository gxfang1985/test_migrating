<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{cb_msg module='grn.memo' key='GRN_MEM-184' replace='true'}<br>
{if strlen($file.title) > 0}
 <p>{cb_msg module='grn.memo' key='GRN_MEM-185' replace='true'}{grn_sentence caption=$file.title image='file20.gif' class='bold'}&nbsp;({$file.filename|escape:"html"})
{else}
 <p>{cb_msg module='grn.memo' key='GRN_MEM-185' replace='true'}{grn_sentence caption='('|cat:$file.filename|cat:')' image='file20.gif' class='bold'}
{/if}
 </p>
 
<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="iid" value="{$item_id}">
</form>
