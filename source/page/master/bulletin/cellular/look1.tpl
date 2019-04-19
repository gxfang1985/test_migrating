{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="bulletin"}<br>
{cb_msg module='grn.bulletin.cellular' key="title_look1"}<br>
<hr>
{if $is_expired_flag}
<font color="#ff0000">{cb_msg module='grn.bulletin.cellular' key="bulletin_expired_comment"}</font><br>
{/if}

{if !$is_expired_flag && $bbsdata.can_follow && $category_auth.follow }
    {grn_cellular_link page="$pagepath/follow" aid="$aid" accesskey="-1" caption_module='grn.bulletin.cellular' caption_key="link_follow"}<br>
{/if}
{$bbsdata.title|escape}<br>
<hr>

{cb_date_format format='DateTimeCompact' date=$bbsdata.ctime}&nbsp;
{if $bbsdata.manually_enter_sender}
    {$bbsdata.manually_enter_sender|escape}
{else}
    {if $bbsdata.group_name}
    {$bbsdata.group_name|escape}(
    {/if}
    {$bbsdata.creator_name|escape}
    {if $bbsdata.group_name}
    )
    {/if}
{/if}
<br>

{grn_cellular_pictogram key="memo"}
{grn_cellular_string_split string=$bbsdata.data page_paraname="bp"}
<br>

{if count($bbsdata.attach_files)}
    <br>
    [{grn_cellular_pictogram key="clip"}{cb_msg module='grn.bulletin.cellular' key="txt_attach_file"}]<br>
{/if}

{if count($followlist) gt 0}
    <hr>
    <a name = "follow"></a>
    {foreach item=one from=$followlist}
        {grn_cellular_pictogram key="follow"}
        {grn_cellular_link page="$pagepath/look2" fid=$one.follow_id aid=$aid caption=$one.data|regex_replace:"/[ \t\r\n]/":""|default:"."|grn_cellular_truncate:$width}<br>
        {$one.id}{cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-5' replace='true'}{cb_date_format format='DateTimeCompact' date=`$one.ctime`}&nbsp;{$one.creator_name|escape}<br>
    {/foreach}
    <br>
    {if $prev}
        {grn_cellular_link page="$pagepath/look1" fp=$prev_page aid=$aid fragment="follow" caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
    {/if}
    {if $next}
        {grn_cellular_link page="$pagepath/look1" fp=$next_page aid=$aid fragment="follow" caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/list" cid=$cid accesskey="3" caption_module='grn.bulletin.cellular' caption_key="list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey="4" caption_module='grn.bulletin.cellular' caption_key="search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
