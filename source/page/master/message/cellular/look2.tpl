{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>

{if !$is_snapshot && !$is_garbage && $message_type != 2}
    {grn_cellular_link page="$pagepath/follow" rid="$rid" mid="$mid" accesskey="-1" caption_module='grn.message.cellular' caption_key="link_follow"}<br>
{/if}

{grn_cellular_pictogram key="memo"}{$title|escape}<br>
<hr>

{grn_cellular_pictogram key="clock"}
{cb_date_format format='DateTimeMiddle_YMDW_HM' date=$follow.date}<br>
{$follow.id}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-1' replace='true'}{grn_cellular_pictogram key="person"}
{$follow.creator_name|escape}<br>
<br>

<a name="body"></a>
{grn_cellular_pictogram key="follow"}

{grn_cellular_string_split string=$follow.body page_paraname="pg"}<br>

{if $follow.attach_files}
    <br>
    [{grn_cellular_pictogram key="clip"}{cb_msg module='grn.message.cellular' key="txt_attach_file"}]<br>
{/if}

{if $follow.prev_fid > 0 || $follow.next_fid > 0}
    <br>
    {if $follow.prev_fid > 0}
        {grn_cellular_link page="$pagepath/look2" rid="$rid" mid="$mid" fid=$follow.prev_fid caption_module='grn.cellular.common' caption_key="link_back"}
        &nbsp;
    {/if}
    {if $follow.next_fid > 0}
        {grn_cellular_link page="$pagepath/look2" rid="$rid" mid="$mid" fid=$follow.next_fid caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look"}<br>
{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
