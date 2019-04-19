<form name="address/delete" method="post" action="{grn_pageurl page='address/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address' key='GRN_ADDR-129' replace='true'}</p>
 <p><span class="bold">{grn_sentence caption=$card.subject class='person20'}</span></p>
{assign var='form_name' value=$smarty.template|basename}
<input type="hidden" name="bid" value="{$book_id}">
<input type="hidden" name="cid" value="{$card_id}">
</form>
