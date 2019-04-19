{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{cb_msg module='grn.address.cellular' key="my_address_group"}<br>

<hr>

{if $address_mygroups}

{include file="cellular/my_address_group.tpl" page='address/cellular/my_address_select'}

<br>

{foreach from=$group_users item=user}
{grn_cellular_pictogram key="person"}
{$user.name|escape}
{if $user.show_email && $user.email}
<br>
&nbsp;&nbsp;
{grn_cellular_mailto mail=$user.email caption=$user.email  width=$width}
{/if}
{if $user.show_phone && $user.phone}
<br>
&nbsp;&nbsp;
{grn_cellular_tel tel=$user.phone}
{/if}

<br>
{/foreach}

{/if}

<br>

{grn_cellular_link page="cellular/menu" aid=$aid caption_module='grn.address.cellular' caption_key="link_back"}<br>

<hr>

{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=7
caption_module='grn.address.cellular' caption_key="link_address"}<br>

{grn_cellular_link page="$pagepath/list" aid=$aid accesskey=9
caption_module='grn.address.cellular' caption_key="link_user_list"}<br>

{/strip}

{include file="cellular/footer.tpl"}
