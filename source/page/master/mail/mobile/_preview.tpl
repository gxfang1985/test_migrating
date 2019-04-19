<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-333' replace='true'}</div>
  <div class="mobile-contents-todoDetail-grn">{$mail.from|escape}</div>
</div>
<div class="mobile-separation-grn"></div>

<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">To</div>
  <div class="mobile_contents_detail_grn">{if $mail.to eq ''}&nbsp;{else}{$mail.to|escape}{/if}</div>
</div>
<div class="mobile-separation-grn"></div>

<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">Cc</div>
  <div class="mobile_contents_detail_grn">{if $mail.cc eq ''}&nbsp;{else}{$mail.cc|escape}{/if}</div>
</div>
<div class="mobile-separation-grn"></div>

<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">Bcc</div>
  <div class="mobile_contents_detail_grn">{if $mail.bcc eq ''}&nbsp;{else}{$mail.bcc|escape}{/if}</div>
</div>
<div class="mobile-separation-grn"></div>

<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-335' replace='true'}</div>
  <div class="mobile-contents-todoDetail-grn">{if $mail.subject eq ''}&nbsp;{else}{$mail.subject|escape}{/if}</div>
</div>
<div class="mobile-separation-grn"></div>

{if $mail.attach_files}
  <div class="mobile-attachmentButton-grn">
    <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}</div>
      {foreach from=$mail.attach_files item=attach_file key=file_key}
        {grn_mobile_attach_file_link name=$attach_file.name dpage=$file_dpage tmpid=$mail.mid fid=$file_key mime=$attach_file.mime inline=$inline no_rfc822link=1 hash=$attach_file.hash}<br>
      {/foreach}
  </div>
  <div class="mobile-separation-grn"></div>
{/if}

<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-336' replace='true'}</div>
  <div class="mobile-contents-todoDetail-grn">
    {if $mail.html_data}
      {capture name='grn_mail_GRN_MAIL_337'}{cb_msg module='grn.mail' key='GRN_MAIL-337' replace='true'}{/capture}{grn_link image='view20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_337 page='mail/html_contents' tmpid=$mail.mid text=1 frm="prvw"}
      <div class="br">&nbsp;</div>
      <div id="mail_content" style="overflow: auto;">{if $mail.data eq ''}&nbsp;{else}{$mail.data|grn_noescape}{/if}</div>
    {else}
      {if $mail.data eq ''}&nbsp;{else}{grn_format body=$mail.data}{/if}
    {/if}
  </div>
</div>
<div class="mobile-separation-grn"></div>

{if $send_set}
  <div class="mobile-list-todoDetail-grn">
    <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-339' replace='true'}</div>
    <div class="mobile-contents-todoDetail-grn">
    {if $mail.give_open_check}
      {capture name='grn_mail_GRN_MAIL_340'}{cb_msg module='grn.mail' key='GRN_MAIL-340' replace='true'}{/capture}
      {grn_sentence class="check16" caption=$smarty.capture.grn_mail_GRN_MAIL_340}
    {else}
      {cb_msg module='grn.mail' key='GRN_MAIL-341' replace='true'}
    {/if}
    </div>
  </div>
  <div class="mobile-separation-grn"></div>
{/if}
