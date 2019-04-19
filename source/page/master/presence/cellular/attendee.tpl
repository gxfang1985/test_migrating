{include file="cellular/header.tpl"}
{strip}

{capture name=validate_message_emoji}{cb_msg module='grn.cellular.common' key="validate_message_emoji"}{/capture}

{*
    {grn_cellular_appname app_id='presence'}<br>
*}
{grn_cellular_pictogram key="book"}
{cb_msg module='grn.presence.cellular' key="attendee"}<br>
{cb_msg module='grn.presence.cellular' key="attendee_modify"}<br>
<hr>

{if $attendee}
    {grn_cellular_pictogram key="clock"}
    {if $attendee.mtime}
        {grn_date_format date=$attendee.mtime format="DateTimeCompact"}<br>
    {/if}
    {$attendee.info|escape}<br>
    <br>
{/if}

{validate form=$form_name field="str" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_message_emoji}

{grn_cellular_form name=$form_name method=post page="$pagepath/command_attendee"}
<select name=sel>
{foreach from=$options key=_key item=_one}
    <option value="{$_one.value}" {if $_one.selected}selected{/if}>{$_one.label|escape}</option>
{/foreach}
</select><br>

<input type="text" name="str" value="{$str|escape}" istyle="1" mode="hiragana"><br>
{grn_cellular_submit accesskey=1 caption_module='grn.presence.cellular' caption_key="submit_atte"}
</form>

<hr>

{/strip}
{include file="cellular/footer.tpl"}

