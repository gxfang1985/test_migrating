<form name="cabinet/delete" method="post" action="{grn_pageurl page='cabinet/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fid" value="{$file.id}">
{cb_msg module='grn.cabinet' key='GRN_CAB-49' replace='true'}<br>
{if strlen($file.title) > 0}
 <p>{cb_msg module='grn.cabinet' key='GRN_CAB-50' replace='true'}{grn_sentence caption=$file.title image='file20.gif' class='bold'}&nbsp;({$file.filename|escape:"html"}{cb_msg module='grn.cabinet' key='GRN_CAB-51' replace='true'}
{else}
 <p>{cb_msg module='grn.cabinet' key='GRN_CAB-52' replace='true'}{grn_sentence caption='('|cat:$file.filename|cat:')' image='file20.gif' class='bold'}
{/if}
 </p>
<input type="hidden" name="hid" value="{$folder_id}">
</form>
