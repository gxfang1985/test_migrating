<form name="address/mygroup_delete" method="post" action="{grn_pageurl page='address/command_mygroup_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address' key='GRN_ADDR-139' replace='true'}{cb_msg module='grn.address' key='GRN_ADDR-140'  replace='true'}</p>
 <p><span class="bold">{grn_sentence image="myaddressgroup20.gif" caption=$mygroup.name|cb_mb_truncate}</span></p>
{assign var='form_name' value=$smarty.template|basename}
 <input type="hidden" name="mgid" value="{$mygroup.id}">
</form>
