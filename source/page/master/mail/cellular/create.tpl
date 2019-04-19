{include file="cellular/header.tpl"}
{strip}

{capture name=validate_mail_title_emoji}
    {cb_msg module='grn.mail.cellular' key="title"}:
    {cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>
{/capture}

{capture name=validate_mail_content_emoji}
    {cb_msg module='grn.mail.cellular' key="create_content"}:
    {cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>
{/capture}
{capture name=validate_mail_address_emoji}
    {cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>
{/capture}

{capture name=validate_message_length}
    {cb_msg module='grn.cellular.common' key="validate_message_length"}<BR>
{/capture}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="create"}
<hr>
{grn_cellular_form name=$form_name method=post page="$pagepath/command_create" aid=$aid cid=$cid}

{validate form=$form_name field="title" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_mail_title_emoji}
{validate form=$form_name field="content" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_length}
{validate form=$form_name field="content" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_mail_content_emoji}
{validate form=$form_name field="to" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_mail_address_emoji}
{validate form=$form_name field="cc" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_mail_address_emoji}
{validate form=$form_name field="bcc" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_mail_address_emoji}

{if $empty_flag}
{cb_msg module='grn.mail.cellular' key="validate_mail_address_empty"}<BR>
{/if}

To:<input type=submit name=to_button value="{cb_msg module='grn.mail.cellular' key="create_search"}" ><br>
<textarea name="to"  rows=1 istyle="3" mode="alphabet">{$to|escape}</textarea><br>
Cc:<input type=submit name=cc_button value="{cb_msg module='grn.mail.cellular' key="create_search"}" ><br>
<textarea name="cc"  rows=1 istyle="3" mode="alphabet">{$cc|escape}</textarea><br>
Bcc:<input type=submit name=bcc_button value="{cb_msg module='grn.mail.cellular' key="create_search"}" ><br>
<textarea name="bcc"  rows=1 istyle="3" mode="alphabet">{$bcc|escape}</textarea><br>


{grn_cellular_pictogram key="pencil"}{cb_msg module='grn.mail.cellular' key="title"}<BR>
<input type=text name=title value="{$subject|escape}" istyle="1" mode="hiragana"><br>

{grn_cellular_pictogram key="pencil"}{cb_msg module='grn.mail.cellular' key="create_content"}<BR>
<textarea name=content istyle="1" mode="hiragana">{$data|escape}</textarea><BR>

{grn_cellular_pictogram key="pencil"}{cb_msg module='grn.mail.cellular' key="signature"}
<select name=signature>
<option value="0">{cb_msg module='grn.mail.cellular' key="no_signature"}</option>
{foreach from=$user_sign item=user_sign_data}
<option value="{$user_sign_data.id}" {if $user_sign_data.selected}selected  {/if}>{$user_sign_data.name|escape}</option>
{/foreach}
</select>
<BR>
<input type=submit name=confirm value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.mail.cellular' key="confirm_button"}"  accesskey=1><br>

</form>

<hr>

{grn_cellular_link page="$pagepath/list" aid=$aid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
