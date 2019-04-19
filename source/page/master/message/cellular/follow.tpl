{include file='cellular/header.tpl'}
{strip}

{capture name=validate_message_follow_empty}{cb_msg module='grn.cellular.common' key="validate_message_empty"}{/capture}
{capture name=validate_message_follow_emoji}{cb_msg module='grn.cellular.common' key="validate_message_emoji"}{/capture}
{capture name=validate_message_follow_length}{cb_msg module='grn.cellular.common' key="validate_message_length"}{/capture}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>

{if !$is_snapshot && !$is_garbage && $message_type != 2}
    {if $message_type == 0 && $need_confirm && !$confirmed}
        {grn_cellular_appname app_id="message" no_icon=1}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-10' replace='true'}<br>
        {cb_msg module='grn.message.cellular' key='GRN_MSG_CE-11' replace='true'}<br>
        <br>
        {if $attach_files}
            {cb_msg module='grn.message.cellular' key='GRN_MSG_CE-12' replace='true'}<br>
        {else}
            {assign var='form_name' value='message/cellular/confirm'}
            {grn_cellular_form name=$form_name method=post page="$pagepath/command_confirm" rid="$rid" mid="$mid"}
            {grn_cellular_submit accesskey=1 caption_module='grn.message.cellular' caption_key="submit_confirm"}
            </form>
        {/if}
    {else}
        {assign var='form_name' value='message/cellular/follow'}
        {validate form=$form_name field="follow" criteria="notEmpty" message=$smarty.capture.validate_message_follow_empty}
        {validate form=$form_name field="follow" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_message_follow_emoji}
        {validate form=$form_name field="follow" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_follow_length}
        
        {grn_cellular_form name=$form_name method=post page="$pagepath/command_follow" rid="$rid" mid="$mid"}
<textarea name=follow cols=16 rows=3 istyle="1" mode="hiragana">{$follow|escape}</textarea><br>
        {grn_cellular_submit accesskey=1 caption_module='grn.message.cellular' caption_key="submit_follow"}
        </form>
    {/if}
    <hr>
{/if}

{grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look"}<br>
{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
