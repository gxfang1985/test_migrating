<script type="text/javascript">
grn.page.mail.mail_list.mail_info = {ldelim}sent : '{$mail.sent}', draft : '{$mail.draft}', no_source : '{$mail.no_source}', html_data : '{$mail.html_data}', has_files : '{$mail.has_files}', attach_file_type : '{$mail.attach_file_type}'{rdelim};
grn.page.mail.mail_3pane.mail_source_id = '{$mail.source_id|escape}';
{if $is_open_status}
{literal}
jQuery(document).ready(function () {
    if (G.mid)
    {
        var num_of_unread_mails = {
            {/literal}{foreach from=$num_of_unread_mails item=value key=key}
                '{$key}' : '{$value}',
            {/foreach}{literal}
        };
        setTimeout(function(){
            var updater = grn.component.mail.MailPartsUpdater;
            updater.updateEachFolderNumOfUnreadMail(num_of_unread_mails);
         }, 1000);
        jQuery('#mail_list-row_'+G.mid).removeClass('unread_grn').addClass('read_grn');
    }
});
{/literal}
{/if}
</script>
{if !empty($mail.inline_files) || !empty($mail.attach_files)}
  {if $mail.attach_file_type neq '2'}
    {grn_delete title=$file_delete_info.title page=$file_delete_info.page no_confirm=$file_delete_info.no_confirm data=$file_delete_info.data handler=$file_delete_info.handler custom_submit='grn.page.mail.mail_list.attachFileDelete()'}
  {/if}
{/if}

  <table id="view_container" class="view_container_grn">
    <tr>
      <td id="view_button" class="view_button_left_grn"><span><a id="action_icon" class="action_grn" href="javascript:void(0);" title="{if $is_open_status}{cb_msg module='grn.mail' key='GRN_MAIL-460' replace='true'}{else}{cb_msg module='grn.mail' key='GRN_MAIL-461' replace='true'}{/if}" onclick="javascript:grn.page.mail.mail_3pane.enableOpenClose();"><span class="{if $is_open_status}expand_right_button_grn{else}expand_left_button_grn{/if}"></span></a></span></td>
      <td></td>
    </tr>
  </table>
  <div id="mail_content_scroll" class="mail_content_scroll_grn" tabindex="0">
    <div id="mail_content_all" class="mail_content_grn">

      {if $mail.sent eq "0"}
        {if $charset_on}
          <div id="display_mail_charset_header">
        {else}
          <div id="display_mail_charset_header" style="display:none">
        {/if}
            <div class="mail_charset">
              <form name="charset_change_header" method="post" action="{grn_pageurl page='mail/ajax/command_change_charset'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <table cellpadding="2" cellspacing="2">
                  <tr>
                    <td>
                      {cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}
                      {grn_mail_charset name='charset_header' default=$charset_header 3pane=1}
                      <input type="button" onclick="if(this.form.charset_header.selectedIndex == 0) return false; grn.page.mail.mail_list.changeCharset('save',this.form.name);" value="{cb_msg module='grn.mail' key='GRN_MAIL-41' replace='true'}" class="buttonStandard-grn">
                      <span id="charset_change_header_loading"></span>
                    </td>
                  </tr>
                </table>
                <input type="hidden" name="mid" value="{$mail.mid}">
                <input type="hidden" name="cmd" value="">
                <input type="hidden" name="charset_on" value="1">
                <input type="hidden" name="use_ajax" value="1">
              </form>
            </div>
          </div>
      {/if}

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
            {if $status_mail != -1}
              {if $status_mail.value == 1}
                <span id="mail_view_status_{$mail.mid}"></span>
              {elseif $status_mail.value == 2}
                <span id="mail_view_status_{$mail.mid}" class="mail-statusUnCheck-grn mRight5 status_content_title_grn">{$status_mail.label}</span>
              {elseif $status_mail.value == 3}
                <span id="mail_view_status_{$mail.mid}" class="mail-statusNeedSend-grn mRight5 status_content_title_grn">{$status_mail.label}</span>
              {elseif $status_mail.value == 4}
                <span id="mail_view_status_{$mail.mid}" class="mail-statusCheck-grn mRight5 status_content_title_grn">{$status_mail.label}</span>
              {elseif $status_mail.value == 5}
                <span id="mail_view_status_{$mail.mid}" class="mail-statusHold-grn mRight5 status_content_title_grn">{$status_mail.label}</span>
              {elseif $status_mail.value == 6}
                <span id="mail_view_status_{$mail.mid}" class="mail-statusWaitSend-grn mRight5 status_content_title_grn">{$status_mail.label}</span>
              {/if}
            {/if}
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

      {if $use_confirm}
        {if ! $mail.sent and $mail.confirmation_request}
          {if ! $disable_mail and ($mail.open eq '1') and ($mail.confirmation_to neq '')}
            <div id="open_send" class="notes">
              <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-17' replace='true'}<br>
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-18' replace='true'}</span><br>
                <span>{cb_msg module='grn.mail' key='GRN_MAIL-19' replace='true'}{$mail.confirmation_to|escape}{cb_msg module='grn.mail' key='GRN_MAIL-20' replace='true'}<br></span>
              </div>
              <div class="button_base_grn tAlignLeft-grn mTop7">
                <span class="aButtonStandard-grn aButtonMain-grn"><a onclick="grn.page.mail.mail_list.sendReadMail('open','mail_open')" href="javascript:void(0);">{cb_msg module='grn.mail' key='GRN_MAIL-21' replace='true'}</a></span>
                <span class="mLeft15 aButtonStandard-grn"><a onclick="grn.page.mail.mail_list.sendReadMail('ignored','mail_open')" href="javascript:void(0);" id="">{cb_msg module='grn.mail' key='GRN_MAIL-22' replace='true'}</a></span>
                <span id="mail_open_loading" class="mRight15"></span>
              </div>
              <form name="mail_open" method="post" action="{grn_pageurl page='mail/ajax/command_open'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <input type='hidden' name='cmd'>
                <input type='hidden' name='mid' value="{$mail.mid}">
                <input type='hidden' name='aid' value="{$mail.aid}">
                <input type='hidden' name='use_ajax' value="1">
              </form>
            </div>
            <div id="open_return" class="notes" style="display:none;">
              <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-23' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-24' replace='true'}<br>
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-25' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-26' replace='true'}</span><br>
                <span id="mail_subject" class="nowrap-grn"><a href="{grn_pageurl page='mail/view'}">{grn_image image='mail20.gif'}</a></span>
              </div>
            </div>
          {elseif $mail.open eq '2'}{*送信済み*}
            <div class="notes">
              <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-23' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-24' replace='true'}<br>
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-25' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-26' replace='true'}</span><br>
                {if $mail.confirm.response_mails}
                  {foreach from=$mail.confirm.response_mails item=response_mail name='responses'}
                    {if $response_mail.mid eq ''}
                      {assign var='response_disabled' value=1}
                    {else}
                      {assign var='response_disabled' value=0}
                    {/if}
                    {grn_link image='mail20.gif' page='mail/view' caption="`$response_mail.subject`" mid=$response_mail.mid disabled=$response_disabled}{if ! $smarty.foreach.responses.last}, {/if}
                  {/foreach}
                {/if}
              </div>
            </div>
          {/if}
        {elseif $mail.confirmation_response}
          <div class="notes">
            <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-27' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-28' replace='true'}<br>
              {if $mail.confirm.org_mail}
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-29' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-30' replace='true'}</span><br>
                {foreach from=$mail.confirm.org_mail item=org_mail name='org_mails'}
                  {if $org_mail.mid eq ''}
                    {assign var='org_disabled' value=1}
                  {else}
                    {assign var='org_disabled' value=0}
                  {/if}
                  {if $org_mail.subject eq ''}
                    {grn_link image='mail20.gif' page='mail/view' caption_module='grn.mail' caption_key='no_title' mid=$org_mail.mid disabled=$org_disabled}
                  {else}
                    {grn_link image='mail20.gif' page='mail/view' caption="`$org_mail.subject`" mid=$org_mail.mid disabled=$org_disabled}
                  {/if}
                  {if ! $smarty.foreach.org_mails.last}, {/if}
                {/foreach}
              {/if}
            </div>
          </div>
        {elseif $mail.sent and $mail.confirmation_request}
          <div class="notes">
            <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-31' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-32' replace='true'}<br>
              {if $mail.confirm.response_mails}
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-33' replace='true'}</span><br>
              {else}
                <span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-34' replace='true'}</span><br>
              {/if}
              {foreach from=$mail.confirm.response_mails item=response_mail name='responses'}
                {if $response_mail.mid eq ''}
                  {assign var='response_disabled' value=1}
                {else}
                  {assign var='response_disabled' value=0}
                {/if}
                {grn_link image='mail20.gif' page='mail/view' caption="`$response_mail.from`" mid=$response_mail.mid disabled=$response_disabled}{if ! $smarty.foreach.responses.last}, {/if}
              {/foreach}
            </div>
          </div>
        {/if}
      {/if}

      <div class="mail_content_info_grn">
        <table class="mail_view_detail" width="100%">
          <tbody>
            <tr>
              <td class="mail-detailLabel-grn nowrap-grn" width="5%">{cb_msg module='grn.mail' key='GRN_MAIL-44' replace='true'}</td>
              <td class="detail_separator_grn" width="1%">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-45' replace='true'}&nbsp;</td>
              <td>{grn_mail_name type=$name_type data_type='from' name_format=$name_format show_address=1 name=$mail.from aid=$category.aid cid=$category.cid mid=$mail.mid page='address/index' 3pane=1}</td>
            </tr>
            <tr>
              <td class="mail-detailLabel-grn nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-46' replace='true'}</td>
              <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}&nbsp;</td>
              <td>{grn_date_format date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</td>
            </tr>
            {if $to_count || ($cc_count || $has_cc neq '') || ($mail.sent and $bcc_count) }
              {if $to_count}
                <tr valign="top">
                  <td class="mail-detailLabel-grn nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-48' replace='true'}&nbsp;{if $to_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$to_count}{cb_msg module='grn.mail' key='GRN_MAIL-54' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;</span>{/if}&nbsp;</td>
                  <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
                  <td>
                    {if $to_count < 2}
                      {grn_mail_name show_faddress=1 type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                    {else}
                      <span id="all_addressee_close">{grn_mail_name show_faddress=1 type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}&nbsp;...&nbsp;{if !$has_cc && !$has_bcc}<small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>{/if}</span>
                      <span id="all_addressee_open" style="display: none">
                        {if $to_count }
                          {grn_mail_name type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                          {if !$has_cc && !$has_bcc}<small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>{/if}
                        {/if}
                      </span>
                    {/if}
                  </td>
                </tr>
              {/if}
              {if $cc_count || $has_cc neq '' }
                <tr valign="top">
                  <td class="mail-detailLabel-grn nowrap-grn" nowrap="">{if $cc_count }Cc&nbsp;{if $cc_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$cc_count}{cb_msg module='grn.mail' key='GRN_MAIL-55' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;&nbsp;&nbsp;</span>{/if}{/if}&nbsp;</td>
                  <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
                  <td>
                    {if $to_count + $cc_count > 2 || $cc_count > 1 }
                      <span id="display_addressee_close">{grn_mail_name show_faddress=1 type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}{if $cc_count >= 2}&nbsp;...&nbsp;{/if}
                        {if !$has_bcc}
                          <small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>
                        {/if}
                      </span>
                      <span id="display_addressee_open" style="display:none">
                        {if $has_cc neq ''}
                          {grn_mail_name type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                          {if !$has_bcc}
                            <small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>
                          {/if}
                        {/if}
                      </span>
                    {else}
                      {grn_mail_name show_faddress=1 type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                    {/if}
                  </td>
                </tr>
              {/if}
              {if $has_bcc}
                <tr valign="top">
                  <td class="mail-detailLabel-grn nowrap-grn" nowrap="">{cb_msg module='grn.mail' key='GRN_MAIL-426' replace='true'}&nbsp;{if $bcc_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$bcc_count}{cb_msg module='grn.mail' key='GRN_MAIL-55' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;&nbsp;&nbsp;</span>{/if}</td>
                  <td class="detail_separator_grn">&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
                  <td>
                    {if ($to_count + $cc_count + $bcc_count > 3) || ($bcc_count eq 1 && $to_count > 1) || ($bcc_count eq "1" && $cc_count>1) || $bcc_count >1}
                      <span id="display_swith_image_close_bcc">{grn_mail_name show_faddress=1 type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}{if $bcc_count >= 2}&nbsp;...&nbsp;{/if}
                        {if $has_bcc}
                         <small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open:display_swith_image_open_bcc:display_swith_image_close_bcc')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>
                        {/if}
                      </span>
                      <span id="display_swith_image_open_bcc" style="display:none">
                        {if $has_bcc neq ''}
                          {grn_mail_name type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                          <small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open:display_swith_image_open_bcc:display_swith_image_close_bcc')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>
                        {/if}
                      </span>
                    {else}
                      {grn_mail_name show_faddress=1 type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all 3pane=1}
                    {/if}
                  </td>
                </tr>
              {/if}
            {/if}
          </tbody>
        </table>
      </div>

      <div class="mail_header_sub_grn">
        <div class="border-partition-common-grn"></div>
        {if $mail.attach_files && !empty($mail.attach_files)}
          <div class="mLeft7">
            {foreach from=$mail.attach_files item=attach_file key=file_key}
                {if $mail.attach_file_type eq '2'}
                  <span class="mail_attachment_list_grn disable_filter_grn" aria-disabled="true">
                  <span class="icon_attachment_small_grn">{$attach_file.name|escape}</span>
                {else}
                  <span class="mail_attachment_list_grn">
                  {if $mail.sent eq '1'}
                    {if $attach_file.exists}
                      {assign var='no_source' value=false}
                    {else}
                      {assign var='no_source' value=true}
                    {/if}
                  {else}
                    {assign var='no_source' value=$mail.no_source}
                  {/if}
                  {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$attach_file.mime browse=true three_pane=true no_source=$no_source receive=$mail.receive hash=$attach_file.hash}
                {/if}
              </span>
            {/foreach}
          </div>
          <div class="border-partition-common-grn"></div>
        {/if}
      </div>
      {if $no_body}
        <div class='explanation'>
          {cb_msg module='grn.mail' key='GRN_MAIL-63' replace='true'}<br>
          {cb_msg module='grn.mail' key='GRN_MAIL-64' replace='true'}
        </div>
      {elseif $mail.is_partial}
        <div class='explanation'>
          {cb_msg module='grn.mail' key='GRN_MAIL-65' replace='true'}<br>
          {cb_msg module='grn.mail' key='GRN_MAIL-68' replace='true'}<br>
          {cb_msg module='grn.mail' key='GRN_MAIL-70' replace='true'}
        </div>
      {else}
        {if $mail.html_data}
          {if !$can_show_html}
            <script type="text/javascript">
              <!--
              var __confirmShowHtml = grn.component.mail.confirm_show_html;
              __confirmShowHtml.dialogMessage = "{cb_msg module='grn.mail' key='GRN_MAIL-471' replace='true'}";
              __confirmShowHtml.getDataUrl = "{grn_pageurl page='mail/html_contents'}";
              __confirmShowHtml.param = "mid={$mail.mid}&newpage=1";
              //-->
            </script>
            <span>
              <div class="mLeft7 textSub-grn"><a href="javascript:void(0);" onclick="javascript:__confirmShowHtml.showConfirmDialog(true);">{cb_msg module='grn.mail' key='GRN_MAIL-470' replace='true'}</a></div>
            </span>
            <div class="border-partition-common-grn"></div>
          {elseif $show_display_image_button}
            <span id="display_image">
            <div class="mLeft7 textSub-grn"><a href="{grn_pageurl page='mail/view' mid=$mail.mid}" onclick="javascript:showFullMailContent(event)">{cb_msg module='grn.mail' key='GRN_MAIL-74' replace='true'}</a></div>
            </span>
            <div class="border-partition-common-grn"></div>
          {/if}
        {/if}

        {if $mail.sent eq "0"}
          {if $charset_on}
            <div id="display_mail_charset_body">
          {else}
            <div id="display_mail_charset_body" style="display:none">
          {/if}
            <div class="mail_charset">
              <form name="charset_change_body" method="post" action="{grn_pageurl page='mail/ajax/command_change_charset'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <table cellpadding="2" cellspacing="2">
                  <tr>
                    <td>
                      {cb_msg module='grn.mail' key='GRN_MAIL-78' replace='true'}
                      {grn_mail_charset name='charset_body' default=$charset_body 3pane=1}
                      <input type="button" onclick="if(this.form.charset_body.selectedIndex == 0) return false; grn.page.mail.mail_list.changeCharset('save',this.form.name);" value="{cb_msg module='grn.mail' key='GRN_MAIL-79' replace='true'}" class="buttonStandard-grn">
                      <span id='charset_change_body_loading'></span>
                    </td>
                  </tr>
                </table>
                <input type="hidden" name="mid" value="{$mail.mid}">
                <input type="hidden" name="cmd" value="">
                <input type="hidden" name="charset_on" value="1">
                <input type="hidden" name="use_ajax" value="1">
              </form>
            </div>
          </div>
        {/if}

        <div class="mail_content_text_grn">
          {if $mail.html_data eq "1" && $can_show_html}
            {literal}
            <script type="text/javascript">
            var html_mail_url = '{/literal}{grn_pageurl page="mail/html_contents"}{literal}';
            var post_data = 'mid={/literal}{$mail.mid}{literal}&csrf_ticket={/literal}{$csrf_ticket}{literal}';
            function resize(){
                var f = document.getElementById("the_iframe");
                var fdocument = f.contentDocument || f.contentWindow.document;
                jQuery(f).css( "height", fdocument.body.scrollHeight + "px" );
            }
            function setFrameContent(bodyContents) {
                var f = document.getElementById("the_iframe");
                setIFrameContent(f, bodyContents, "{/literal}{grn_get_url_prefix}{literal}");
                G.resetWidth(G.left_fixed, G.center_fixed);
                G.resetHeight();
            }
            function showFullMailContent(evt) {
                if (evt.preventDefault) {
                    evt.preventDefault();
                }
                else {
                    evt.returnValue = false;
                }
                jQuery("#display_image").hide();

                var ajaxRequest = new grn.component.ajax.request({
                    url: html_mail_url,
                    method: "post",
                    data: post_data,
                    grnRedirectOnLoginError: true
                });

                ajaxRequest.send().done(function (data) {
                     setFrameContent(data);
                });
            }
            jQuery(function(){
                var mc = jQuery("#mail_content");
                setFrameContent(mc.html());
                mc.html("");
            });
            </script>
            {/literal}
            <iframe id="the_iframe" frameborder="0" class="mail_content_frame_grn"></iframe>
            <div id="mail_content" style='display:none'>{$mail.data|grn_noescape}</div>
          {else}
            {if $truncated}
              <div class='attention'><span class='subnotify16 bold'>{cb_msg module='grn.mail' key='mail_truncated' replace='true'}</span></div>
              <div class="border-partition-common-grn"></div>
            {/if}
            {grn_format body=$mail.data}
          {/if}
        </div>

        {if $mail.inline_files && !empty($mail.inline_files)}
          <div class="border-partition-common-grn"></div>
          <div>
            <div class="mLeft7">
                <div class="mBottom7">
                    <span class="action_text_grn">
                        <a href="javascript:void(0);" id="mail_show_inline_files_button"><span class="icon_inline_grn icon_show_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-472' replace='true'}</span></a>
                        <a href="javascript:void(0);" id="mail_hide_inline_files_button" style="display:none;"><span class="icon_inline_grn icon_hide_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-473' replace='true'}</span></a>
                    </span>
                </div>
            </div>
            <div style="display: none;" id="mail_inline_files" class="mail_attachment_bottom_grn">
              <ul>
                {foreach from=$mail.inline_files item=file key=file_key}
                    {if $mail.attach_file_type eq '2'}
                      <li class="disable_filter_grn disable_filter_block_grn" aria-disabled="true">
                      <span class="with_lang icon_attachment_grn">{$file.name|escape}</span>
                    {else}
                      <li>
                      {if $mail.sent eq '1'}
                        {if $file.exists}
                          {assign var='no_source' value=false}
                        {else}
                          {assign var='no_source' value=true}
                        {/if}
                      {else}
                        {assign var='no_source' value=$mail.no_source}
                      {/if}
                      {grn_mail_attach_file_link name=$file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$file.mime inline=$inline three_pane=true no_source=$no_source receive=$mail.receive hash=$file.hash}
                    {/if}
                  </li>
                {/foreach}
              </ul>
            </div>
          </div>
        {/if}

        {if $mail.attach_files && !empty($mail.attach_files)}
          <div class="border-partition-common-grn"></div>
          <div class="mail_attachment_bottom_grn">
            <ul>
              {foreach from=$mail.attach_files item=attach_file key=file_key}
                  {if $mail.attach_file_type eq '2'}
                    <li class="disable_filter_grn disable_filter_block_grn" aria-disabled="true">
                        <span class="with_lang icon_attachment_grn">{$attach_file.name|escape}</span>
                  {else}
                    <li>
                    {if $mail.sent eq '1'}
                      {if $attach_file.exists}
                        {assign var='no_source' value=false}
                      {else}
                        {assign var='no_source' value=true}
                      {/if}
                    {else}
                      {assign var='no_source' value=$mail.no_source}
                    {/if}
                    {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$attach_file.mime inline=$inline three_pane=true no_source=$no_source receive=$mail.receive hash=$attach_file.hash}
                  {/if}
                </li>
              {/foreach}
            </ul>
          </div>
        {/if}
      {/if}

    </div>
  </div>
