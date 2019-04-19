<form name="mail/personal/signature_delete" method="post" action="{grn_pageurl page='mail/personal/command_signature_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-88' replace='true'}<span class="bold">{grn_sentence image='mailaccount20.gif' caption=$set.account truncated_caption=$truncate_len}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-89' replace='true'}<span class="bold">{grn_sentence image="signature20.gif" caption=$set.name truncated_caption=$truncate_len}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-90' replace='true'}
 </p>
 <input type="hidden" name="aid" value="{$set.aid}">
 <input type="hidden" name="sid" value="{$set.sid}">
</form>
