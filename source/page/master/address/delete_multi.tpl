<form name="address/delete_multi" method="post" action="{grn_pageurl page='address/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address' key='GRN_ADDR-84' replace='true'}</p>
 <p>
{assign var='form_name' value=$smarty.template|basename}
 {cb_msg module='grn.address' key='GRN_ADDR-85' replace='true'}<span class="bold">{grn_sentence caption=$book.display_name class='person20'}</span><br>
 {cb_msg module='grn.address' key='GRN_ADDR-86' replace='true'}<span class="bold delete_count"></span>
 </p>
<input type="hidden" name="bid" value="{$book_id}">
</form>
