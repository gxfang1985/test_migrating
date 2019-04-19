<script language="JavaScript" type="text/javascript">
    var __thisPage = grn.page.mail.mail_list;
    __thisPage.requireFileDeleteUrl = '{grn_pageurl page="mail/ajax/command_file_delete"}';
</script>
<form name="mail/file_delete" method="post"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
{if !empty($mail.attach_files)}
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-282' replace='true'}</th>
   <td>
    <div class="voice">
{foreach from=$mail.attach_files item=attach_file key=fid}
     <span class="bold">{grn_sentence caption=$attach_file.name class='clip8x20' truncated_caption=$truncate_len}</span><br>
{/foreach}
   </td>
  </tr>
{/if}
{if !empty($mail.inline_files)}
  <tr>
    <th>{cb_msg module='grn.mail' key='GRN_MAIL-474' replace='true'}</th>
      <td>
        <div class="voice">
          {foreach from=$mail.inline_files item=file key=fid}
            <span class="bold">{grn_sentence caption=$file.name class='clip8x20' truncated_caption=$truncate_len}</span><br>
          {/foreach}
        </div>
      </td>
  </tr>
{/if}
  </table>
 </p>
{if $mail.sent}
 <div>{cb_msg module='grn.mail' key='GRN_MAIL-283' replace='true'}</div>
 <p/>
{else}
 <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-284' replace='true'}
   <div class="explanation_list_grn mTop7">
     <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-285' replace='true'}</span>
     <ul>
       <li>{cb_msg module='grn.mail' key='GRN_MAIL-286' replace='true'}</li>
       <li>{cb_msg module='grn.mail' key='GRN_MAIL-287' replace='true'}</li>
       <li>{cb_msg module='grn.mail' key='GRN_MAIL-288' replace='true'}</li>
     </ul>
   </div>
 </div>
<p/>
{/if}
 <input type="hidden" name="mid" value="{$mail.mid}">
</form>
