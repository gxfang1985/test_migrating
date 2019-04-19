<script type="text/javascript">
grn.page.mail.mail_list.mail_info = {ldelim}sent : '{$mail.sent}', draft : '{$mail.draft}', no_source : '{$mail.no_source}', html_data : '{$mail.html_data}'{rdelim};
</script>
<table id="view_container" class="view_container_grn">
  <tr>
    <td id="view_button" class="view_button_left_grn"><span><a id="action_icon" class="action_grn" href="javascript:void(0);" title="{if $is_open_status}{cb_msg module='grn.mail' key='GRN_MAIL-460' replace='true'}{else}{cb_msg module='grn.mail' key='GRN_MAIL-461' replace='true'}{/if}" onclick="javascript:grn.page.mail.mail_3pane.enableOpenClose();"><span class="{if $is_open_status}expand_right_button_grn{else}expand_left_button_grn{/if}"></span></a></span></td>
    <td></td>
  </tr>
</table>
<div id="mail_content_scroll" class="mail_content_scroll_grn" tabindex="0">
  <div id="mail_content_all" class="mail_content_grn">
    <table class="mail_content_title_grn">
      <tr>
        {if $use_star && $category.type neq '4'}
        <td class="mail_content_title_left_grn">
          <span id="star_subject" class="msg_left_span_grn">
            {include file="star/star_init.tpl" list_id="star_subject" on_update="grn_mail_on_update_star"}
            {grn_star_icon module="grn.mail" star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid}
          </span>
        </td>
        {/if}
        <td class="mail_content_title_right_grn">
          <span class="mail_content_title_text_grn">
            {if $mail.subject eq ''}
              {grn_title caption_module='grn.mail' caption_key='no_title' class=$page_info.parts[0]}
            {else}
              {grn_title title=$mail.subject class=$page_info.parts[0]}
            {/if}
          </span>
        </td>
      </tr>
    </table>
    <div class="mail_content_info_grn">
      <table class="mail_view_detail" width="100%">
        <tbody>
          <tr>
            <td class="mail-detailLabel-grn nowrap-grn" width="5%">To:</td>
            <td class="detail_separator_grn" width="1%">&nbsp;：&nbsp;</td>
            <td>{$mail.to|escape}</td>
          </tr>
          <tr>
            <td class="mail-detailLabel-grn nowrap-grn">Cc:</td>
            <td class="detail_separator_grn">&nbsp;：&nbsp;</td>
            <td>{$mail.cc|escape}</td>
          </tr>
          <tr valign="top">
            <td class="mail-detailLabel-grn nowrap-grn">Bcc:</td>
            <td class="detail_separator_grn">&nbsp;：&nbsp;</td>
            <td>{$mail.bcc|escape}</td>
          </tr>
          {if $mail.attach_files}
            <tr>
              <td class="mail-detailLabel-grn nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}</td>
              <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}&nbsp;</td>
              <td>
                <ul>
                  {foreach from=$mail.attach_files item=attach_file key=file_key}
                    <li>
                      {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$attach_file.mime inline=$inline three_pane=true sent=$mail.sent hash=$attach_file.hash}
                    </li>
                  {/foreach}
                </ul>
              </td>
            </tr>
          {/if}
          <tr>
            <td class="mail-detailLabel-grn nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-370' replace='true'}</td>
            <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}&nbsp;</td>
            <td>
              {if $mail.html_data}
                {capture name='grn_mail_GRN_MAIL_371'}{cb_msg module='grn.mail' key='GRN_MAIL-371' replace='true'}{/capture}{grn_link image='view20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_371 page='mail/html_contents' mid=$mail.mid fid=$attach_file.fid text=1}
                <div id="mail_content" style="display:none"></div>
                <div id="sanbox" style="display:none">{$mail.data|grn_noescape}</div>
              {else}
                {grn_format body=$mail.data}
              {/if}
            </td>
          </tr>
          {if $send_set}
            {if $mail.give_open_check}
              <tr>
               <td class="mail-detailLabel-grn nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-373' replace='true'}</td>
               <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}&nbsp;</td>
               <td>{grn_image image='check16.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-374' replace='true'}</td>
              </tr>
            {/if}
          {/if}
        </tbody>
      </table>
    </div>
    {if $mail.html_data}
      <script type="text/javascript">
      {literal}
      (function() {
          var content = jQuery("#mail_content");
          var sanbox = jQuery("#sanbox");
          content.html(sanbox.html());
          content.show();
          G.resetWidth(G.left_fixed, G.center_fixed);
          G.resetHeight();
          sanbox.html("");
      })();
      {/literal}
      </script>
    {/if}
  </div><!-- mail_content_grn end-->
</div><!-- mail_content_scroll end-->

