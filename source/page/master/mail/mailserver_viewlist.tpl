{include file='grn/popup_head.tpl'}
{include file='grn/popup_header.tpl'}
{foreach name=mailservers from=$mailservers item=mailserver}
 <p>
 <table class="view_table" width="80%">
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-299' replace='true'}</th>
   <td>{$mailserver.title|escape}</td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-300' replace='true'}</th>
   <td>{$mailserver.smtp_server|escape}</td>
  </tr>
  <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-505' replace='true'}</th>
  <td>{$mailserver.type_encrypted_connection|escape}</td>
  </tr>
 {if $mailserver.smtp_auth eq 'NONE'}
    {if $smarty.const.ON_FOREST != 1}
        <tr>
            <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-301' replace='true'}<br>{cb_msg module='grn.mail' key='GRN_MAIL-302' replace='true'}</th>
            <td>{if $mailserver.is_pop_before_smtp}{cb_msg module='grn.mail' key='GRN_MAIL-304' replace='true'}{else}{cb_msg module='grn.mail' key='GRN_MAIL-305' replace='true'}{/if}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-306' replace='true'}&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-307' replace='true'}</th>
            <td>{if $mailserver.is_pop_before_smtp}{$mailserver.pop_before_smtp_wait}&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-308' replace='true'}{else}----{/if}</td>
        </tr>
    {/if}
 {else}
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-309' replace='true'}</th>
   <td>{$mailserver.smtp_auth|escape}</td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-310' replace='true'}</th>
   <td>{if $mailserver.smtp_account_set}{cb_msg module='grn.mail' key='GRN_MAIL-311' replace='true'}{else}{cb_msg module='grn.mail' key='GRN_MAIL-312' replace='true'}{/if}</td>
  </tr>
 {/if}
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-313' replace='true'}</th>
   <td>{$mailserver.received_server|escape}</td>
  </tr>
  <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-490' replace='true'}</th>
  <td>{if $mailserver.received_ssl == '1'}{capture name='grn_mail_system_GRN_MAIL_SY_491'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-491' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_491}{else}{capture name='grn_mail_system_GRN_MAIL_SY_493'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-493' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_493 image='spacer20.gif'}{/if}</td>
  </tr>
 {if $mailserver.received_protocol eq 'POP3'}
  <tr>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-314' replace='true'}</th>
   <td>{if $mailserver.apop}{cb_msg module='grn.mail' key='GRN_MAIL-315' replace='true'}{else}{cb_msg module='grn.mail' key='GRN_MAIL-316' replace='true'}{/if}</td>
  </tr>
 {/if}
 </table>
{/foreach}

</div><!--body_end-->
