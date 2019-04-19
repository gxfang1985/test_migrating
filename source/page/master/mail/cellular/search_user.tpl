{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="search_user"}<br>

{include file="cellular/group_tab.tpl"}

{if $objects}
    <br>
    {foreach item=object_data from=$objects}
        {grn_cellular_pictogram key="person"}
        {$object_data.name|escape} [{capture name='grn_mail_cellular_GRN_MAIL_CE_10'}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-10' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_mail_cellular_GRN_MAIL_CE_10 uid=$object_data.mid }]<br>
	{foreach from=$object_data.emails item=email}
        &nbsp;&nbsp;
        <a href="{grn_cellular_pageurl page="$pagepath/create" cid=$cid aid=$aid add_b=$object_data.mid bid=$book.bid add_raw=$email}">
        {$email|grn_cellular_truncate:$width|escape}</a><br>
	{/foreach}
    {/foreach}
    {if $before || $next}
        <BR>
        {if $before}
            <a href="{grn_cellular_pageurl page="$pagepath/search_user" cid=$cid aid=$aid gid=$gid pg=$before_page}">
            {cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
        {/if}
        {if $next}
            <a href="{grn_cellular_pageurl page="$pagepath/search_user" cid=$cid aid=$aid gid=$gid pg=$next_page}">
            {cb_msg module='grn.cellular.common' key="link_next"}</a>
        {/if}
        <BR>
    {/if}
{/if}

<BR>
{grn_cellular_link page="$pagepath/search1" aid=$aid cid=$cid caption_module='grn.mail.cellular' caption_key="link_back"}<BR>
<hr>
{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
