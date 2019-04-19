{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>
{cb_msg module='grn.message.cellular' key="txt_search_notice"}{grn_cellular_appname app_id="message" no_icon="1"}

{grn_cellular_form name="form" method="get" page="$pagepath/search"}
<input type="text" name="text" value="{$text|escape}" istyle="1" mode="hiragana"><br>
{grn_cellular_submit name="GO" accesskey="1" caption_module='grn.message.cellular' caption_key="submit_search"}<br>
</form>

{if $result}
    {foreach from=$result item=item}
        {if $item.update}
            {grn_cellular_pictogram key="follow"}
        {elseif $item.unread}
            {grn_cellular_pictogram key="new"}
        {else}
            {grn_cellular_pictogram key="checked"}
        {/if}
        <a href={grn_cellular_pageurl page="$pagepath/look1" rid=$item.rid mid=$item.mid cid=$item.cid}>
        {if strlen($item.subject) > 0}
            {$item.subject|grn_cellular_truncate:$width|escape}
        {else}
            {cb_msg module='grn.message.cellular' key="no_subject"}
        {/if}
        </a><BR>
        {if $item.is_garbage}
            {cb_msg module='grn.message.cellular' key="garbage_mark"}
        {else}
            {if $item.type==1}
                {grn_cellular_pictogram key="send_box"}
            {elseif $item.type==2}
                {grn_cellular_pictogram key="pencil"}
            {else}
                {grn_cellular_pictogram key="memo"}
            {/if}
        {/if}
        {cb_date_format format='DateTimeCompact' date=$item.mtime}&nbsp;{$item.creator_name|escape}<br>
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search" text=$text sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search" text=$text sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=3 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{/strip}
{include file="cellular/footer.tpl"}
