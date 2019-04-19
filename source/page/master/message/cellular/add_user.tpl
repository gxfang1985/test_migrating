{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='message'}<br>
{$pagetitle|escape}<br>

{include file="cellular/group_tab.tpl"}
<br>

{foreach from=$objects item=_user}
    {grn_cellular_pictogram key="person"}
    {if $_user.set}
        {$_user.name|escape} [{capture name='grn_message_cellular_GRN_MSG_CE_6'}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-6' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_message_cellular_GRN_MSG_CE_6 uid=$_user.mid }]
    {else}
        <a href="{grn_cellular_pageurl page="$to_pagename" mid=$_user.mid params=$params}">{$_user.name|escape}</a> [{capture name='grn_message_cellular_GRN_MSG_CE_7'}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-7' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_message_cellular_GRN_MSG_CE_7 uid=$_user.mid }]
    {/if}
    <br>
{/foreach}

{if $prev || $next}
    <br>
    {if $prev}
        <a href="{grn_cellular_pageurl page="$pagepath/add_user" gid=$gid pg=$prev_page}" params=$params>{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
    {/if}
    {if $next}
        <a href="{grn_cellular_pageurl page="$pagepath/add_user" gid=$gid pg=$next_page}" params=$params>{cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
    <br>
{/if}

<br>
{grn_cellular_link page="$to_pagename" params=$params caption_module='grn.message.cellular' caption_key="link_to_back"}<br>

<hr>

{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
