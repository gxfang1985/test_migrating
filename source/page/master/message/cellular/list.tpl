{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>
{grn_cellular_link page="$pagepath/create" accesskey=2 cs=1 cid=$current_cid caption_module='grn.message.cellular' caption_key="link_create"}<br>

{if $folders}

    {grn_cellular_form name="form" method="get" page="$pagepath/list"}
    <select name="cid">
    {foreach from=$folders item=item}
        <option value="{$item.cid|escape}"{if $item.cid === $current_cid} selected{/if}>
        {$item.name|escape}{if $item.unread_num > 0}[{$item.unread_num}]{/if}
        </option>
    {/foreach}
    </select><br>
    {grn_cellular_submit name="GO" accesskey="1" caption_module='grn.message.cellular' caption_key="submit_move"}<br>
    </form>

{/if}

{if $messages}
    {foreach from=$messages key=rid item=item}
        {if $item.status == 0}
            {grn_cellular_pictogram key="new"}
        {elseif $item.status == 1}
            {grn_cellular_pictogram key="follow"}
        {else}
            {grn_cellular_pictogram key="checked"}
        {/if}
        <a href={grn_cellular_pageurl page="$pagepath/look1" rid=$rid mid=$item.message_id cid=$current_cid}>
        {if strlen($item.subject) > 0}
            {$item.subject|grn_cellular_truncate:$width|escape}
        {else}
            {cb_msg module='grn.message.cellular' key="no_subject"}
        {/if}
        </a><BR>
        {if $is_garbage}
            {cb_msg module='grn.message.cellular' key="garbage_mark"}
        {else}
            {if $item.message_type==1}
                {grn_cellular_pictogram key="send_box"}
            {elseif $item.message_type==2}
                {grn_cellular_pictogram key="pencil"}
            {else}
                {grn_cellular_pictogram key="memo"}
            {/if}
        {/if}
        {cb_date_format format='DateTimeCompact' date=$item.date}&nbsp;{$item.user_name|escape}<br>
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/list" cid=$current_cid sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/list" cid=$current_cid sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
