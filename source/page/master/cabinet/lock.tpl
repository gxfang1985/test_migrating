<form name="cabinet/lock" method="post" action="{grn_pageurl page='cabinet/file_update'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if !$only_form}
    {include file="grn/file_lock.tpl" download_page="cabinet/download" linkparams=$linkparams}
{else}
    <input type="hidden" name="fid" value="">
{/if}
<input type="hidden" name="hid" value="{$folder_id}">
{if $index_return}
    <input type="hidden" name="index_return" value="{$index_return}">
{/if}
<input type="hidden" name="upload" value="{cb_msg module='grn.cabinet' key='GRN_CAB-213' replace='true'}">
</form>
