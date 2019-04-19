<div id="one_parts">
 <!--view-->
 <div id="view">
  <!----->
   <div class="space-head">{cb_msg module='grn.mail' key='GRN_MAIL-331' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-332' replace='true'}</div>
   <div class="space-command">
    {include file="$button_file"}
   </div>
   <table class="mail_preview">
    <colgroup>
     <col width="10%">
     <col width="10%">
     <col width="80%">
    </colgroup>
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-333' replace='true'}</th>
     <td>{$mail.from|escape}</td>
    </tr>
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">To:</th>
     <td>{if $mail.to eq ''}&nbsp;{else}{$mail.to|escape}{/if}</td>
    </tr>
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">Cc:</th>
     <td>{if $mail.cc eq ''}&nbsp;{else}{$mail.cc|escape}{/if}</td>
    </tr>
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">Bcc:</th>
     <td>{if $mail.bcc eq ''}&nbsp;{else}{$mail.bcc|escape}{/if}</td>
    </tr>
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-335' replace='true'}</th>
     <td>{if $mail.subject eq ''}&nbsp;{else}{$mail.subject|escape}{/if}</td>
    </tr>
{if $mail.attach_files}
    <tr>
     <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}</th>
     <td>
 {foreach from=$mail.attach_files item=attach_file key=file_key}
      {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" tmpid=$mail.mid fid=$file_key mime=$attach_file.mime inline=$inline no_rfc822link=1 hash=$attach_file.hash}<br>
 {/foreach}
     </td>
    </tr>
{/if}
    <tr valign="top">
     <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-336' replace='true'}</th>
     <td>
{if $mail.html_data}
      {capture name='grn_mail_GRN_MAIL_337'}{cb_msg module='grn.mail' key='GRN_MAIL-337' replace='true'}{/capture}{grn_link image='view20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_337 page='mail/html_contents' tmpid=$mail.mid text=1 frm="prvw"}
     <div class="br">&nbsp;</div>
     <iframe id="mail_content" frameborder="0" scrolling="no" style="overflow:hidden;height:20px;width:100%;border: 0 none;display:none"></iframe>
     <div id="sanbox" style="display:none">
      {if $mail.data eq ''}&nbsp;{else}{$mail.data|grn_noescape}{/if}
     </div>
{else}
      {if $mail.data eq ''}&nbsp;{else}{grn_format body=$mail.data}{/if}
{/if}
    </td>
    </tr>
{if $send_set}
    <tr>
     <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-339' replace='true'}</th>
     <td>{if $mail.give_open_check}{capture name='grn_mail_GRN_MAIL_340'}{cb_msg module='grn.mail' key='GRN_MAIL-340' replace='true'}{/capture}{grn_sentence class="check16" caption=$smarty.capture.grn_mail_GRN_MAIL_340}{else}{cb_msg module='grn.mail' key='GRN_MAIL-341' replace='true'}{/if}</td>
    </tr>
{/if}
   </table>
   <p>
    {include file="$button_file"}
   </p>
  <!----->
 </div>
 <!--view_end--->
</div>
<input type="hidden" name="cmd">
{if $mail.html_data}
<script type="text/javascript">
{literal}
jQuery(function() {
    var f = jQuery('#mail_content');
    var sanbox = jQuery('#sanbox');
    var fdocument = setIFrameContent(f[0], sanbox.html(), "{/literal}{grn_get_url_prefix}{literal}");
    f.show();
    var frame_height_buffer = 0;
    if (grn.browser.msie) {
        f.css({width: f[0].parentNode.clientWidth + 'px'});
        frame_height_buffer = 15;
    }
    f.css({height: (fdocument.body.scrollHeight + frame_height_buffer) + 'px'});
    sanbox.html('');
});
{/literal}
</script>
{/if}
{grn_load_javascript file="grn/html/page/mail/_preview.js"}
