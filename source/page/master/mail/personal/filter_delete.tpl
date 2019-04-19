<form name="mail/personal/filter_delete" method="post" action="{grn_pageurl page='mail/personal/command_filter_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-125' replace='true'}<span class="bold">{grn_sentence image="mailaccount20.gif" caption=$set.account truncated_caption=$truncate_len}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-126' replace='true'}<span class="bold">{grn_sentence image="mailfilter20.gif" caption=$set.title truncated_caption=$truncate_len}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-127' replace='true'}
 </p>
<input type="hidden" name="mfid" value="{$set.mfid}">
</form>
