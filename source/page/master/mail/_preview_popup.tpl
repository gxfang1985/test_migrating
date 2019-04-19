<div class="subwindow_header_grn">
  <div class="subwindow_title_grn">
    {grn_image image='mail20.gif'}<span class="subwindow_title_name_grn">{$page_title|escape}</span>
  </div>
  <div class="subwindow_menupart_grn">
    <div class="mBottom7">{cb_msg module='grn.mail' key='GRN_MAIL-331' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-332' replace='true'}</div>
    <div class="button_base_grn tAlignLeft-grn">
      {include file="$button_file" suffix="_top"}
    </div>
  </div>
</div>

<div class="mail_send_confirm_grn">
  <div class="mainarea">
    <div class="mainarea-mail">
      <div id="one_parts">
        <div id="view">
          <table class="mail_preview">
            <tbody>
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn" style="width: 1%;">{cb_msg module='grn.mail' key='GRN_MAIL-333' replace='true'}</th>
                <td>{$mail.from|escape}</td>
              </tr>
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn">To:</th>
                <td>{if $mail.to eq ''}&nbsp;{else}{$mail.to|escape}{/if}</td>
              </tr>
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn">Cc:</th>
                <td>{if $mail.cc eq ''}&nbsp;{else}{$mail.cc|escape}{/if}</td>
              </tr>
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn">Bcc:</th>
                <td>{if $mail.bcc eq ''}&nbsp;{else}{$mail.bcc|escape}{/if}</td>
              </tr>
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-335' replace='true'}</th>
                <td>{if $mail.subject eq ''}&nbsp;{else}{$mail.subject|escape}{/if}</td>
              </tr>
            {if $mail.attach_files}
              <tr>
                <th colspan="2" nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}</th>
                <td>
                  {foreach from=$mail.attach_files item=attach_file key=file_key}
                    {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" tmpid=$mail.mid fid=$file_key mime=$attach_file.mime inline=$inline no_rfc822link=1 hash=$attach_file.hash three_pane=true}<br>
                  {/foreach}
                </td>
              </tr>
            {/if}
              <tr valign="top">
                <th colspan="2" class="bg_color nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-336' replace='true'}</th>
                <td>
                  {if $mail.html_data}
                    <iframe id="mail_content" frameborder="0" scrolling="no" style="overflow: hidden; height: 20px; width: 100%; border: 0 none; display: none"></iframe>
                    <div id="sanbox" style="display: none">{if $mail.data eq ''}&nbsp;{else}{$mail.data|grn_noescape}{/if}</div>
                  {else}
                    {if $mail.data eq ''}&nbsp;{else}{grn_format body=$mail.data}{/if}
                  {/if}
                </td>
              </tr>
            {if $send_set}
              <tr>
                <th colspan="2" class="bg_color nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-339' replace='true'}</th>
                <td>
                  {if $mail.give_open_check}
                    {capture name='grn_mail_GRN_MAIL_340'}{cb_msg module='grn.mail' key='GRN_MAIL-340' replace='true'}{/capture}
                    {grn_sentence class="check16" caption=$smarty.capture.grn_mail_GRN_MAIL_340}
                  {else}
                    {cb_msg module='grn.mail' key='GRN_MAIL-341' replace='true'}
                  {/if}
                </td>
              </tr>
            {/if}
            </tbody>
          </table>
          <div class="button_base_grn tAlignLeft-grn mTop15">
            {include file="$button_file" suffix="_bottom"}
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--end of mainarea-->
</div>

<input type="hidden" name="cmd">
{if $mail.html_data}
<script type="text/javascript">
{literal}
jQuery(function()
{
    var f = jQuery('#mail_content');
    var sanbox = jQuery('#sanbox');
    var fdocument = setIFrameContent(f[0], sanbox.html(), "{/literal}{grn_get_url_prefix}{literal}");
    f.show();
    var frame_height_buffer = 0;
    if (grn.browser.msie)
    {
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
