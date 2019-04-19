<form name="mail/personal/signature_delete_multi" method="post" action="{grn_pageurl page='mail/personal/command_signature_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-29' replace='true'}<br><br>
  {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-30' replace='true'}<span class="bold delete_count"></span>
 </p>
 <input type="hidden" name="aid" value="{$set.aid}">
</form>
