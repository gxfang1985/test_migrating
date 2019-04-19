{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_add_facility"}<br>
<hr>
{grn_cellular_form method=post page="$pagepath/add_facility" params=$params}
<select name=fgid>
{foreach from=$select_list item=_id_and_name}
    {if $_id_and_name.extra_param == 1 || $_id_and_name.extra_param == 2}
        {if $fgid == $_id_and_name.id|cat:"_"|cat:$_id_and_name.extra_param}
            <option value="{$_id_and_name.id}_{$_id_and_name.extra_param}" selected>
        {else}
            <option value="{$_id_and_name.id}_{$_id_and_name.extra_param}">
        {/if}
    {else}
        {if $fgid == $_id_and_name.id && $_id_and_name.extra_param != '-'}
            <option value="{$_id_and_name.id}" selected>
        {else}
            <option value="{$_id_and_name.id}">
        {/if}
    {/if}
    {$_id_and_name.name|escape}
    </option>
{/foreach}
</select><br>
<input type=submit accesskey="1" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.schedule.cellular' key="link_gr"}"><br>
</form>
<br>
{foreach from=$objects item=_obj}
    {grn_cellular_pictogram key="building"}
    {if $_obj.conflict || $_obj.set}
        {cb_msg module='grn.schedule.cellular' key="x_sign"}{$_obj.name}
    {else}
        <a href="{grn_cellular_pageurl page="$to_pagename" fid=$_obj.fid}">{$_obj.name|escape}</a>
    {/if}
    <br>
    
{/foreach}

{if $prev}
    <a href="{grn_cellular_pageurl page="$pagepath/add_facility" fgid=$fgid pg=$prev_page params=$params}">{cb_msg module='grn.cellular.common' key="link_back"}</a>
    &nbsp;
{/if}
{if $next}
    <a href="{grn_cellular_pageurl page="$pagepath/add_facility" fgid=$fgid pg=$next_page params=$params}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}
<br>
<br>

{grn_cellular_link page="$to_pagename" eid=$eid accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_to_back"}<br>

<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
