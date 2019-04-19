{include file="grn/xss_prevent.tpl"}
<div class="summaryText">
    {if ($mail_data.sent neq '1') and ($confirm_type eq '1') and ($mail_data.confirmation_to neq '')}
      <div class="notes_mail_preview explanation" id="{$note_id}">
        {cb_msg module='grn.mail' key='GRN_MAIL-17' replace='true'}
      </div>
    {elseif ($mail_data.sent neq '1') and $confirm_type eq '2'}
        <div class="notes_mail_preview" id="{$note_id}">
           <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-23' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-24' replace='true'}<br>
             <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-25' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-26' replace='true'}</span><br>
           {if $mail_for_view.confirm.response_mails}
            {foreach from=$mail_for_view.confirm.response_mails item=response_mail name='responses'}
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
    {elseif $mail_data.confirmation_response}
        <div class="notes_mail_preview" id="{$note_id}">
           <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-27' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-28' replace='true'}<br>
          {if $mail_for_view.confirm.org_mail}
             <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-29' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-30' replace='true'}</span><br>
           {foreach from=$mail_for_view.confirm.org_mail item=org_mail name='org_mails'}
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
    {elseif $mail_data.sent and $mail_data.confirmation_request}
        <div class="notes_mail_preview" id="{$note_id}">
           <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-31' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-32' replace='true'}<br>
          {if $mail_for_view.confirm.response_mails}
             <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-33' replace='true'}</span><br>
          {else}
             <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-34' replace='true'}</span><br>
          {/if}
          {foreach from=$mail_for_view.confirm.response_mails item=response_mail name='responses'}
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
        <div id="{$div_id}" style='font-size:100%;overflow:hidden;{if $mail_data.html_data eq ""}line-height:20px;{/if}'>
            {if $mail_data.html_data eq '' || !$can_show_html}
              {grn_format body=$data}
            {else}
              {$data|grn_noescape}
            {/if}
        </div>
        <div id="{$flag}">
            {capture name='grn_see_more'}{cb_msg module='grn.mail' key='see_more' replace='true'}{/capture}{grn_link page='mail/view' caption=$smarty.capture.grn_see_more truncated_caption=$characters.subject mid=$mail_id}
        </div>
        {if ($confirm_type neq '1') or ($mail_data.confirmation_to eq '')}
           {if ! $disable_mail && $from_portlet neq '1' && $folder_type != 2 && $mail_data.sent neq '1'}
            {if $mail_data.draft neq '1'}
                <span class="mail-subItem-grn" onmouseover="show_another_tab_icon(jQuery('#new_tab_icon_reply_{$mail_id}'))" onmouseout="hide_another_tab_icon(jQuery('#new_tab_icon_reply_{$mail_id}'))">{capture name='grn_mail_GRN_MAIL_7'}{cb_msg module='grn.mail' key='GRN_MAIL-7' replace='true'}{/capture}{grn_link page='mail/reply' caption=$smarty.capture.grn_mail_GRN_MAIL_7 image='mail20_r.gif' mid=$mail_id disabled=$size_over}
                <span class="new_tab_icon_hide" id="new_tab_icon_reply_{$mail_id}">{grn_link page='mail/reply' caption="" image='image-app-mail/blank_sub16.png' target='_blank' mid=$mail_id disabled=$size_over}</span></span>
                <span class="mail-subItem-grn" onmouseover="show_another_tab_icon(jQuery('#new_tab_icon_reply_all_{$mail_id}'))" onmouseout="hide_another_tab_icon(jQuery('#new_tab_icon_reply_all_{$mail_id}'))">{capture name='grn_mail_GRN_MAIL_8'}{cb_msg module='grn.mail' key='GRN_MAIL-8' replace='true'}{/capture}{grn_link page='mail/reply_all' caption=$smarty.capture.grn_mail_GRN_MAIL_8 image='mail20_a.gif' mid=$mail_id disabled=$size_over}
                <span class="new_tab_icon_hide" id='new_tab_icon_reply_all_{$mail_id}'>{grn_link page='mail/reply_all' caption="" image='image-app-mail/blank_sub16.png' target='_blank' mid=$mail_id disabled=$size_over}</span></span>
                <span class="mail-subItem-grn" onmouseover="show_another_tab_icon(jQuery('#new_tab_icon_forward_{$mail_id}'))" onmouseout="hide_another_tab_icon(jQuery('#new_tab_icon_forward_{$mail_id}'))">{capture name='grn_mail_GRN_MAIL_9'}{cb_msg module='grn.mail' key='GRN_MAIL-9' replace='true'}{/capture}{grn_link page='mail/forward' caption=$smarty.capture.grn_mail_GRN_MAIL_9 image='mail20_f.gif' mid=$mail_id disabled=$size_over}
                <span class="new_tab_icon_hide" id="new_tab_icon_forward_{$mail_id}" >{grn_link page='mail/forward' caption="" image='image-app-mail/blank_sub16.png' target='_blank' mid=$mail_id disabled=$size_over}</span></span>
            <span class="mail-subItem-grn">{capture name='grn_mail_GRN_MAIL_12'}{cb_msg module='grn.mail' key='GRN_MAIL-12' replace='true'}{/capture}<a href="javascript:;" onclick="show_popup_delete('{$mail_data.subject}','{$mail_data.id}','{$mail_data.account_id}','{$mail_data.folder_id}','{$folder_type}','{$delete_info.data.use_garbagebox}');">{grn_image image='delete20.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-12' replace='true'}</a>
            {*{grn_link page='mail/delete' caption=$smarty.capture.grn_mail_GRN_MAIL_12 image='delete20.gif' script='#' onclick="test();" id='lnk_delete_mail_'|cat:$mail_data.id}*}</span>
            {/if}
        {/if}
    {/if}
    {if ($mail_data.sent eq '1') && ! $disable_mail && $from_portlet neq '1' && $mail_data.draft neq '1'}
                <span class="mail-subItem-grn" onmouseover="show_another_tab_icon(jQuery('#new_tab_icon_resend_{$mail_id}'))" onmouseout="hide_another_tab_icon(jQuery('#new_tab_icon_resend_{$mail_id}'))">{capture name='grn_mail_GRN_MAIL_2'}{cb_msg module='grn.mail' key='GRN_MAIL-2' replace='true'}{/capture}{grn_link page='mail/resend' caption=$smarty.capture.grn_mail_GRN_MAIL_2 image='reuse20.gif' mid=$mail_id disabled=$size_over}
                <span class="new_tab_icon_hide" id="new_tab_icon_resend_{$mail_id}">{grn_link page='mail/resend' caption="" image='image-app-mail/blank_sub16.png' target='_blank' mid=$mail_id disabled=$size_over}</span></span>
                <span class="mail-subItem-grn">{capture name='grn_mail_GRN_MAIL_12'}{cb_msg module='grn.mail' key='GRN_MAIL-12' replace='true'}{/capture}<a href="javascript:;" onclick="show_popup_delete('{$mail_data.subject}','{$mail_data.id}','{$mail_data.account_id}','{$mail_data.folder_id}','{$folder_type}','{$delete_info.data.use_garbagebox}');">{grn_image image='delete20.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-12' replace='true'}</a></span>
    {/if}
</div>
{include file="grn/end_xss_prevent.tpl"}