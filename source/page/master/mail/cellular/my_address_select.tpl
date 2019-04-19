{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular'
key="select_my_address_group"}<br>

<hr>

{include file="cellular/my_address_group.tpl"
page='mail/cellular/my_address_select' }

<br>

{foreach from=$group_users item=user}
{grn_cellular_pictogram key="person"}
{$user.name|escape}<br>
&nbsp;&nbsp;
{grn_cellular_mailto mail=$user.email caption=$user.email width=$width}
<br>
{/foreach}

<BR>
{grn_cellular_link page="$pagepath/search1" aid=$aid cid=$cid caption_module='grn.mail.cellular' caption_key="link_back"}<BR>
<hr>

{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}

{include file="cellular/footer.tpl"}
