{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="schedule"}<br>
{if $submit_group}
{cb_msg module='grn.schedule.cellular' key="title_search_group"}<br>
{elseif $submit_user}
{cb_msg module='grn.schedule.cellular' key="title_search_user"}<br>
{else}
{cb_msg module='grn.schedule.cellular' key="title_search_group_user"}<br>
{/if}

{include file="cellular/group_tab.tpl"}

{grn_cellular_form method=post page="$pagepath/search_object" params=$params}
<input type="text" name="str" value="{$str|escape}" istyle="1" mode="hiragana"><br>
{if $group_search_only}
    {grn_cellular_submit name="submit_group" accesskey=1 caption_module='grn.schedule.cellular' caption_key="submit_group_search"}<br>
{else}
    {grn_cellular_submit name="submit_user" accesskey=1 caption_module='grn.schedule.cellular' caption_key="submit_user_search"}<br>
    {grn_cellular_submit name="submit_group" accesskey=2 caption_module='grn.schedule.cellular' caption_key="submit_group_search"}<br>
{/if}
</form>
<br>
{if $submit_user}
    {foreach from=$lists key=_id item=_name}
        {grn_cellular_pictogram key="person"}
        {if $page_group === 'schedule/cellular/add_user' && array_key_exists( $_id, $sess_event.joint ) }
            {$_name} [{capture name='grn_schedule_cellular_GRN_SCH_CE_18'}{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-18' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_schedule_cellular_GRN_SCH_CE_18 uid=$_id }]
        {else}
            {grn_cellular_link page=$to_page params=$params mid=$_id caption=$_name} [{capture name='grn_schedule_cellular_GRN_SCH_CE_19'}{cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-19' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_schedule_cellular_GRN_SCH_CE_19 uid=$_id }]
        {/if}
        <br>
    {/foreach}
    <br>
    {if $prev}
        {grn_cellular_link page="$pagepath/search_object" params=$params str=$str submit_user='TRUE' pg=$prev_page caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
    {/if}
    {if $next}
        {grn_cellular_link page="$pagepath/search_object" params=$params str=$str submit_user='TRUE' pg=$next_page caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
    {if $next || $prev}
    <br><br>
    {/if}
{/if}

{if $submit_group}
    {foreach from=$lists key=_id item=_name}
        {grn_cellular_pictogram key="organization"}
        {grn_cellular_link page=$to_page params=$params gid=$_id caption=$_name}<br>
    {/foreach}
    <br>
    {if $prev}
        {grn_cellular_link page="$pagepath/search_object" params=$params str=$str submit_group='TRUE' pg=$prev_page caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
    {/if}
    {if $next}
        {grn_cellular_link page="$pagepath/search_object" params=$params str=$str submit_group='TRUE' pg=$next_page caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
    {if $next || $prev}
    <br><br>
    {/if}
{/if}

{if $page_group === 'schedule/cellular/add_user' }
    {grn_cellular_link page="$to_pagename" eid=$eid accesskey="3" caption_module='grn.schedule.cellular' caption_key="link_to_back"}<br>
{/if}

<hr>
{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
