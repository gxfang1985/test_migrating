{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='message'}<br>
{$pagetitle|escape}<br>
<hr>

{$title|escape}<br>

{if $use_garbage and not $is_garbage}
    {cb_msg module='grn.message.cellular' key="txt_del_movegarbage"}<br>
{else}
    {cb_msg module='grn.message.cellular' key="txt_del_delete"}<br>
    {if not $is_draft}
        {cb_msg module='grn.message.cellular' key="txt_del_selfonly"}<br>
    {/if}
{/if}

{grn_cellular_form name=$form_name method=post page="$pagepath/command_delete" rid=$rid mid=$mid}

{if $is_operator and not $is_draft and not $is_garbage}
    {capture name=app_name}{grn_cellular_appname app_id='message' no_icon=1 no_escape=1}{/capture}
    {capture name=send_cancel}{cb_msg module='grn.message.cellular' key="txt_del_sendcancel"}{/capture}
    <br>
    {grn_cellular_appname app_id='message' no_icon=1}{cb_msg module='grn.message.cellular' key="txt_del_cancelcheck" cancel=$smarty.capture.send_cancel}<br>
    {if $use_garbage}
        <br>
        <font color=red>
        {cb_msg module='grn.message.cellular' key="txt_del_cancelcheck2" cancel=$smarty.capture.send_cancel}
        </font><br>
    {/if}
    <br>
    <input type="checkbox" name="send_cancel" value="1">{$smarty.capture.send_cancel|grn_noescape}<br>
{/if}

<br>
{grn_cellular_submit accesskey=1 caption_module='grn.message.cellular' caption_key="submit_delete"}
</form>

<hr>
{grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look"}<br>
{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
