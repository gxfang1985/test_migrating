{include file="cellular/header.tpl"}
{strip}

{capture name=validate_message_follow_empty}{cb_msg module='grn.bulletin.cellular' key="validate_message_empty"}{/capture}
{capture name=validate_message_follow_emoji}{cb_msg module='grn.cellular.common' key="validate_message_emoji"}{/capture}
{capture name=validate_message_follow_length}{cb_msg module='grn.cellular.common' key="validate_message_length"}{/capture}

{grn_cellular_appname app_id="bulletin"}<br>
{$pagetitle|escape}<br>
<hr>
{validate form=$form_name field="follow" criteria="notEmpty" message=$smarty.capture.validate_message_follow_empty}
{validate form=$form_name field="follow" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_message_follow_emoji}
{validate form=$form_name field="follow" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_follow_length}

{grn_cellular_form name=$form_name method="post" page="bulletin/cellular/command_follow" cid=$cid aid=$aid}

<textarea name=follow cols=16 rows=3 istyle="1" mode="hiragana">{$follow|escape}</textarea>
<br>

{grn_cellular_submit accesskey=1 caption_module='grn.bulletin.cellular' caption_key="txt_submit"}
</form>

<hr>

{grn_cellular_link page="$pagepath/look1" aid=$aid caption_module='grn.bulletin.cellular' caption_key="link_look1"}<br>

{grn_cellular_link page="$pagepath/list" cid=$cid accesskey="3" caption_module='grn.bulletin.cellular' caption_key="list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey="4" caption_module='grn.bulletin.cellular' caption_key="search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
