{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>

{include file="cellular/group_tab.tpl"}

{grn_cellular_form method=post page="$pagepath/add_search" params=$params}
<input type="text" name="str" value="{$str|escape}" istyle="1" mode="hiragana"><br>
{if $group_search_only}
    {grn_cellular_submit name="submit_group" accesskey=1 caption_module='grn.message.cellular' caption_key="submit_group_search"}<br>
{else}
    {grn_cellular_submit name="submit_user" accesskey=1 caption_module='grn.message.cellular' caption_key="submit_user_search"}<br>
    {grn_cellular_submit name="submit_group" accesskey=2 caption_module='grn.message.cellular' caption_key="submit_group_search"}<br>
{/if}
</form>
<br>
{if $submit_user}
    {foreach from=$lists item=item}
        {grn_cellular_pictogram key="person"}
        {if $item.set}
            {$item.name|escape}[{capture name='grn_message_cellular_GRN_MSG_CE_8'}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-8' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_message_cellular_GRN_MSG_CE_8 uid=$item.mid }]
        {else}
            {grn_cellular_link page=$page_user params=$params mid=$item.mid caption=$item.name}  [{capture name='grn_message_cellular_GRN_MSG_CE_9'}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-9' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_message_cellular_GRN_MSG_CE_9 uid=$item.mid }]
        {/if}
        <br>
    {/foreach}
    {if $prev || $next}
        <br>
        {if $prev}
            {grn_cellular_link page="$pagepath/add_search" params=$params str=$str submit_user='TRUE' pg=$prev_page caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
        {/if}
        {if $next}
            {grn_cellular_link page="$pagepath/add_search" params=$params str=$str submit_user='TRUE' pg=$next_page caption_module='grn.cellular.common' caption_key="link_next"}
        {/if}
        <br>
    {/if}
{/if}

{if $submit_group}
    {foreach from=$lists item=item}
        {grn_cellular_pictogram key="organization"}
        {grn_cellular_link page=$page_group params=$params gid=$item.gid caption=$item.name}<br>
    {/foreach}
    {if $prev || $next}
        <br>
        {if $prev}
            {grn_cellular_link page="$pagepath/add_search" params=$params str=$str submit_group='TRUE' pg=$prev_page caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
        {/if}
        {if $next}
            {grn_cellular_link page="$pagepath/add_search" params=$params str=$str submit_group='TRUE' pg=$next_page caption_module='grn.cellular.common' caption_key="link_next"}
        {/if}
        <br>
    {/if}
{/if}

<br>
{grn_cellular_link page=$page_user params=$params caption_module='grn.message.cellular' caption_key="link_to_back"}<br>

<hr>

{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
