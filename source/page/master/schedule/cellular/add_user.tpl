{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_add_user"}<br>

{include file="cellular/group_tab.tpl"}
<br>

{foreach from=$objects item=_user}
    {if ! strncmp($_user.mid,"g",1)}
        {grn_cellular_pictogram key="organization"}
        {if $_user.set}
            {$_user.name|escape}
        {else}
            <a href="{grn_cellular_pageurl page="$to_pagename" mid=$_user.mid}">{$_user.name|escape}</a>
        {/if}
    {else}
        {grn_cellular_pictogram key="person"}
        {if $_user.set}
            {$_user.name|escape} [{capture name='grn_schedule_cellular_GRN_SCH_CE_15'}{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-15' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_schedule_cellular_GRN_SCH_CE_15 uid=$_user.mid }]
        {else}
            <a href="{grn_cellular_pageurl page="$to_pagename" mid=$_user.mid}">{$_user.name|escape}</a> [{capture name='grn_schedule_cellular_GRN_SCH_CE_16'}{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-16' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_schedule_cellular_GRN_SCH_CE_16 uid=$_user.mid }]
        {/if}
    {/if}
    <br>
{/foreach}

{if $prev}
    <a href="{grn_cellular_pageurl page="$pagepath/add_user" gid=$gid pg=$prev_page params=$params}">{cb_msg module='grn.cellular.common' key="link_back"}</a>
&nbsp;{/if}
{if $next}
    <a href="{grn_cellular_pageurl page="$pagepath/add_user" gid=$gid pg=$next_page params=$params}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}
<br>
<br>

{grn_cellular_link page="$to_pagename" eid=$eid accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_to_back"}<br>

<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
