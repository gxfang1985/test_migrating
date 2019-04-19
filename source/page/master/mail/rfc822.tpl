{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
 {grn_load_css file="grn/html/image_grn.css"}
 {grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
 {grn_load_javascript file="grn/common/base.js"}
 {grn_load_javascript file="grn/html/page/mail/rfc822.js"}
</head>
<body>
 <table class="list_coulumn" border="0" cellspacing="1" cellpadding="3">
  <colgroup>
   <col width="10%">
   <col width="10%">
   <col width="80%">
  </colgroup>
  <tr valign="top" align="left">
   <th colspan="2" bgcolor="#cccccc">{cb_msg module='grn.mail' key='GRN_MAIL-390' replace='true'}</th>
   <td>{$mail.from|escape}</td>
  </tr>
  <tr valign="top" align="left">
   <th colspan="2" bgcolor="#cccccc">{cb_msg module='grn.mail' key='GRN_MAIL-391' replace='true'}</th>
   <td>{grn_date_format date=$mail.date format='DateTimeMiddle_YMDW_HM'}</td>
  </tr>
  <tr valign="top" align="left">
{if $mail.cc and ($mail.cc neq '')}
   <th rowspan="2" bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-392' replace='true'}</th>
{else}
   <th bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-393' replace='true'}</th>
{/if}
   <th bgcolor="#cccccc">To:</th>
   <td>{if $mail.to eq ''}&nbsp;{else}{$mail.to|escape}{/if}</td>
  </tr>
{if $mail.cc and ($mail.cc neq '')}
  <tr valign="top" align="left">
   <th bgcolor="#cccccc">Cc:</th>
   <td>{if $mail.cc eq ''}&nbsp;{else}{$mail.cc|escape}{/if}</td>
  </tr>
{/if}
  <tr valign="top" align="left">
   <th colspan="2" bgcolor="#cccccc">{cb_msg module='grn.mail' key='GRN_MAIL-394' replace='true'}</th>
   <td>{if $mail.subject eq ''}(no-title){else}{$mail.subject|escape}{/if}</td>
  </tr>
 </table>
 <hr>
{if $mail.html_data}
<a href="{grn_pageurl page='mail/html_contents' mid=$mail.mid pids=$pids newpage=1}" onclick='{literal}if(confirm("{/literal}{cb_msg module='grn.mail' key='GRN_MAIL-395' replace='true'}\n{cb_msg module='grn.mail' key='GRN_MAIL-397' replace='true'}\n\n{cb_msg module='grn.mail' key='GRN_MAIL-398' replace='true'}{literal}")){return true;}return false;{/literal}'>{grn_image image='view20.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-399' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-400' replace='true'}{capture name='grn_mail_GRN_MAIL_401'}{cb_msg module='grn.mail' key='GRN_MAIL-401' replace='true'}{/capture}{grn_link image='view20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_401 page='mail/html_contents' mid=$mail.mid pids=$pids text=1}{cb_msg module='grn.mail' key='GRN_MAIL-402' replace='true'}<br>{/if}<pre>{$mail.data|grn_autolink}</pre>
{if $mail.attach_file_type}
 {if !empty($mail.inline_files)}
  <hr>
  <a href="javascript:void(0);" id="mail_show_inline_files_button"><span class="icon_inline_grn icon_show_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-472' replace='true'}</span></a>
  <a href="javascript:void(0);" id="mail_hide_inline_files_button" style="display:none;"><span class="icon_inline_grn icon_hide_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-473' replace='true'}</span></a>
  <div id="mail_inline_files" style="display: none;">
   {foreach from=$mail.inline_files item=file key=file_key}
   {grn_mail_attach_file_link name=$file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$file.mime inline=$inline no_source=$mail.no_source receive=$mail.receive}<br>
   {/foreach}
  </div>
 {/if}
 {if !empty($mail.attach_files)}
  <hr>
  {foreach from=$mail.attach_files item=file key=file_key}
  {grn_mail_attach_file_link name=$file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$file.mime inline=$inline no_source=$mail.no_source receive=$mail.receive}<br>
  {/foreach}
 {/if}
{/if}
