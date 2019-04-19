{include file="cellular/header.tpl"}
{strip}

{capture name=validate_message_title_emoji}
    {cb_msg module='grn.message.cellular' key="txt_title"}:
    {cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>
{/capture}

{capture name=validate_message_title_notempty}
    {cb_msg module='grn.message.cellular' key="txt_title"}:
    {cb_msg module='grn.cellular.common' key="validate_message_empty"}<BR>
{/capture}

{capture name=validate_message_memo_emoji}
    {cb_msg module='grn.message.cellular' key="txt_info"}:
    {cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>
{/capture}

{capture name=validate_message_memo_length}
    {cb_msg module='grn.cellular.common' key="validate_message_length"}<BR>
{/capture}

{capture name=validate_message_address_notempty}
    {cb_msg module='grn.message.cellular' key="txt_address"}:
    {cb_msg module='grn.cellular.common' key="validate_message_empty"}<BR>
{/capture}

{grn_cellular_appname app_id='message'}<br>
{if $is_draft}
    {cb_msg module='grn.message.cellular' key="draftsend"}
{else}
    {$pagetitle|escape}
{/if}
<br>
<hr>

{grn_cellular_form name=$form_name method=post page="$pagepath/command_create" cid=$cid}

{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.validate_message_title_notempty}
{validate form=$form_name field="title" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_message_title_emoji}
{validate form=$form_name field="info" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_message_memo_emoji}
{validate form=$form_name field="info" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_memo_length}
{validate form=$form_name field="address" criteria="notEmpty" message=$smarty.capture.validate_message_address_notempty}

<input type=hidden name=cid value="{$cid}">

{grn_cellular_pictogram key="memo"}{cb_msg module='grn.message.cellular' key="txt_title"}<br>
<input type=text name=title value="{$message.title|escape}" istyle="1" mode="hiragana"><br>

{grn_cellular_pictogram key="memo"}{cb_msg module='grn.message.cellular' key="txt_info"}<br>
{if $message.edit_info}
    <input type=hidden name=edit_info value="1">
    <textarea name=info cols=16 rows=3 istyle="1" mode="hiragana">{$message.info|escape}</textarea><br>
    {if $message.org_format}
        (
        {cb_msg module='grn.message.cellular' key="txt_html_format1"}
        {grn_cellular_appname app_id="message" no_icon="1"}
        {cb_msg module='grn.message.cellular' key="txt_html_format2"}
        )<br>
    {/if}
{else}
    <input type=hidden name=info value="">
    ({cb_msg module='grn.message.cellular' key="no_editable_info"})<br>
{/if}

{grn_cellular_pictogram key="person"}{cb_msg module='grn.message.cellular' key="txt_address"}
{if $message.edit_users}
    {if $message.add_users}
        {grn_cellular_submit name=add_user caption_module='grn.message.cellular' caption_key="submit_add_address"}
    {/if}
    <br>
    {if empty( $message.users) }
        <input type=hidden name=address value="">
    {else}
        <input type=hidden name=address value="1">
        {foreach from=$message.users key=_id item=_name}
            &nbsp;&nbsp;
            {$_name|escape}
            {grn_cellular_submit name="delete_user[$_id]" caption_module='grn.message.cellular' caption_key="submit_del_address"}<br>
        {/foreach}
    {/if}
{else}
    <br>
    ({cb_msg module='grn.message.cellular' key="no_editable_user"})<br>
{/if}

<input type=checkbox name=confirm value="1"{if $message.confirm} checked{/if}>
{cb_msg module='grn.message.cellular' key="txt_confirm"}<br>

{grn_cellular_submit accesskey=1 caption_module='grn.message.cellular' caption_key="submit_send"}
</form>

<hr>
{if $is_draft}
    {grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look"}<br>
{/if}
{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
