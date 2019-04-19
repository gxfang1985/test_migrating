{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="schedule"}<br>
{cb_msg module='grn.schedule.cellular' key="title_change_user"}<br>
<hr>

{grn_cellular_form method=get page="$pagepath/change_user" from="$from" day="$day" mid="$mid"}
{grn_cellular_select_group name="gid" selected=$gid access_plugin=$access_plugin option_add=$option_add}<br>
{grn_cellular_submit accesskey=1 caption_module='grn.schedule.cellular' caption_key="link_gr"}<br>
</form>

{foreach from=$objects item=one}
    {if ! strncmp($one.mid,"f",1)}
        {grn_cellular_pictogram key="building"}
    {elseif ! strncmp($one.mid,"g",1)}
        {grn_cellular_pictogram key="organization"}
    {else}
        {grn_cellular_pictogram key="person"}
    {/if}
    {grn_cellular_link page=$to_pagename mid=$one.mid day=$day caption=$one.name} [<a href="#">{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-6' replace='true'}</a>]<br>
{/foreach}

{if $prev}
    {grn_cellular_link page="$pagepath/change_user" from=$from gid=$gid pg=$prev_page day=$day mid=$mid caption_module='grn.cellular.common' caption_key="link_back"}
    &nbsp;
{/if}
{if $next}
    {grn_cellular_link page="$pagepath/change_user" from=$from gid=$gid pg=$next_page day=$day mid=$mid caption_module='grn.cellular.common' caption_key="link_next"}
{/if}
<br>

<hr>
{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
