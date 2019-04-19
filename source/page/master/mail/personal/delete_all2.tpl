<form name="mail/personal/delete_all2" method="post" action="{grn_pageurl page='mail/personal/command_delete_all2'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-148' replace='true'}</th>
  <td>
   <span class="bold account_name"></span>
  </td>
 </tr>
</table>

<p class="explanation">
{cb_msg module='grn.mail.personal' key='GRMSG_MAIL_PE-1' app_name=$app_name}<span class="bold term_date_popup_display"></span>&nbsp;{cb_msg module='grn.mail.personal' key='GRMSG_MAIL_PE-2' app_name=$app_name}<br>
<span class="attention">{cb_msg module='grn.mail.personal' key='GRMSG_MAIL_PE-3' app_name=$app_name}</span>
</p>
</form>
