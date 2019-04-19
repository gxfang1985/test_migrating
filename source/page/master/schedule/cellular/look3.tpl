{include file="cellular/header.tpl"}
{strip}

{if $mode == "f"}
    {capture name=sub_title_string}{cb_msg module='grn.schedule.cellular' key="title_facility_info"}{/capture}
    {capture name=list_icon}{grn_cellular_pictogram key="building"}{/capture}
{else}
    {capture name=sub_title_string}{cb_msg module='grn.schedule.cellular' key="title_share_info"}{/capture}
    {capture name=list_icon}{grn_cellular_pictogram key="person"}{/capture}
{/if}

{grn_cellular_appname app_id='schedule'}<br>
{if $mode == "f"}
    {cb_msg module='grn.schedule.cellular' key="title_facility_info"}
{else}
    {cb_msg module='grn.schedule.cellular' key="title_share_info"}
{/if}
<hr>

{grn_cellular_pictogram key="light"}{$event_title|grn_noescape}<br>

<hr>

{foreach from=$list key=_id item=_str}
    {if $mode == "f"}
        {grn_cellular_pictogram key="building"}
    {else}
        {if strncmp($_id,"g",1)}
            {grn_cellular_pictogram key="person"}
        {else}
            {grn_cellular_pictogram key="organization"}
        {/if}
    {/if}
    {$_str|escape}<br>
{/foreach}

<br>
{if $prev}
    {grn_cellular_link page="$pagepath/look3" pg=$prev_p mode=$mode mid=$mid eid=$eid day=$day caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
{/if}
{if $next}
    {grn_cellular_link page="$pagepath/look3" pg=$next_p mode=$mode mid=$mid eid=$eid day=$day caption_module='grn.cellular.common' caption_key="link_next"}
{/if}

<hr>

{grn_cellular_link page="$pagepath/look1" mid=$mid day=$day eid=$eid accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_look"}<br>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}

