{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{cb_msg module='grn.address.cellular' key="list"}<br>

{include file="cellular/group_tab.tpl"}

<br>
{foreach item=object_data from=$objects}
    {grn_cellular_pictogram key="person"}
    <a href="{grn_cellular_pageurl page="$pagepath/view" uid=$object_data.mid}">
    {$object_data.name|escape}
    </a>
    <br>
    {if count( $object_data.item_codes )}
      {foreach from=$object_data.item_codes key=item_key item=item_code}
&nbsp;&nbsp;{grn_cellular_display_field item_code=$item_code item_data=$object_data.items.$item_key}
      {/foreach}
    {/if}
    
{/foreach}
{if $before}
    <a href="{grn_cellular_pageurl page="$pagepath/list" cid=$cid aid=$aid gid=$gid pg=$before_page}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
{/if}
{if $next}
    <a href="{grn_cellular_pageurl page="$pagepath/list" cid=$cid aid=$aid gid=$gid pg=$next_page}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}

{grn_cellular_link page="cellular/menu" caption_module='grn.address.cellular' caption_key="link_back"}

<hr>

{/strip}
{grn_cellular_link page="$pagepath/search" accesskey=7 caption_module='grn.address.cellular' caption_key="link_address"}<BR>
{grn_cellular_link page="$pagepath/my_address_select" accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>
{include file="cellular/footer.tpl"}
