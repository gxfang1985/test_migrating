{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="confirm"}
<hr>
{cb_msg module='grn.mail.cellular' key="confirm_text"}<BR>
<hr>
{if $mail_confirm_data.to}To:<br>{$mail_confirm_data.to|escape}<br>{/if}
{if $mail_confirm_data.cc}Cc:<br>{$mail_confirm_data.cc|escape}<br>{/if}
{if $mail_confirm_data.bcc}Bcc:<br>{$mail_confirm_data.bcc|escape}<br>{/if}
<br>

{grn_cellular_pictogram key="light"}{cb_msg module='grn.mail.cellular' key="title"}<BR>
{$mail_confirm_data.subject|escape}<br>

{if $mail_confirm_data.long_data}
<font color=#ff0000>{cb_msg module='grn.mail.cellular' key="long_data"}</font><BR>
{/if}
{grn_cellular_pictogram key="memo"}{cb_msg module='grn.mail.cellular' key="create_content"}<BR>
{$mail_confirm_data.data|escape|nl2br}<BR>
{if $signature_info}<BR>{$signature_info|escape|nl2br}{/if}
<hr>
{grn_cellular_form method=post page="$pagepath/command_confirm" }
<input type=submit name=send_button value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.mail.cellular' key="send"}"  accesskey=1><br>
<input type=submit name=modify_button value="{grn_cellular_pictogram key="num2"}{cb_msg module='grn.mail.cellular' key="modify"}"  accesskey=2><br>
</form>
<hr>

{grn_cellular_link page="$pagepath/list" aid=$aid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
