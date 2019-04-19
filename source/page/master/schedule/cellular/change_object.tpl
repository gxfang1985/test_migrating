{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="schedule"}<br>
{cb_msg module='grn.schedule.cellular' key="title_change_user"}<br>

{include file="cellular/group_tab.tpl"}
{if $tab.mode == 'f'}
    {cb_msg module='grn.schedule.cellular' key="tab2_facility"}<br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid access_plugin=$access_plugin option_list=$option_list}<br>
{/if}
<br>
{foreach from=$objects item=one}
    {if ! strncmp($one.mid,"f",1)}
        {grn_cellular_pictogram key="building"}
        {grn_cellular_link page=$to_pagename mid=$one.mid day=$day caption=$one.name}<br>
    {elseif ! strncmp($one.mid,"g",1)}
        {grn_cellular_pictogram key="organization"}
        {grn_cellular_link page=$to_pagename mid=$one.mid day=$day caption=$one.name}<br>
    {else}
        {grn_cellular_pictogram key="person"}
	{grn_cellular_link page=$to_pagename mid=$one.mid day=$day caption=$one.name}  [{capture name='grn_schedule_cellular_GRN_SCH_CE_5'}{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-5' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_schedule_cellular_GRN_SCH_CE_5 uid=$one.mid }]<br>
    {/if}

    
{/foreach}

{if $prev}
    {grn_cellular_link page="$pagepath/change_object" from=$from gid=$gid pg=$prev_page day=$day mid=$mid caption_module='grn.cellular.common' caption_key="link_back"}
    &nbsp;
{/if}
{if $next}
    {grn_cellular_link page="$pagepath/change_object" from=$from gid=$gid pg=$next_page day=$day mid=$mid caption_module='grn.cellular.common' caption_key="link_next"}
{/if}
<br>

<hr>
{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
