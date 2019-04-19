{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="search2"}

{include file="cellular/group_tab.tpl"}

{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="search_user"}<br>

{grn_cellular_form method=post page="$pagepath/search2" search_flag="$search_flag" aid=$aid cid=$cid}
<input type=text name=s_text value="{if $str}{$str|escape}{/if}" istyle="1" mode="hiragana"><BR>
<input type=submit accesskey="1" name="submit_user" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.mail.cellular' key="user_search"}"><br>
<input type=submit accesskey="2" name="submit_group" value="{grn_cellular_pictogram key="num2"}{cb_msg module='grn.mail.cellular' key="group_search"}"><br>
</form>

{if $lists}
    <BR>
    {foreach item=list_data from=$lists}
        {grn_cellular_pictogram key="building"}
        <a href="{grn_cellular_pageurl page="$pagepath/search_user" gid=$list_data.gid}">{$list_data.name|escape}</a><BR>
    {/foreach}
    {if $before || $next}
        <BR>
        {if $before}
            <a href="{grn_cellular_pageurl page="$pagepath/search2"  pg=$before_page s_text=$str submit_group=true}">
            {cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
        {/if}
        {if $next}
            <a href="{grn_cellular_pageurl page="$pagepath/search2"  pg=$next_page s_text=$str submit_group=true}">
            {cb_msg module='grn.cellular.common' key="link_next"}</a>
        {/if}
        <BR>
    {/if}
{/if}


{if $datas_for_view}
    <BR>
    {foreach item=data_for_view from=$datas_for_view}
        {grn_cellular_pictogram key="person"}
        {$data_for_view.name|escape} [{capture name='grn_mail_cellular_GRN_MAIL_CE_1'}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-1' replace='true'}{/capture}{grn_cellular_link page='address/cellular/view' caption=$smarty.capture.grn_mail_cellular_GRN_MAIL_CE_1 uid=$data_for_view.mid }]<br>
	{foreach from=$data_for_view.emails item=email}
        &nbsp;&nbsp;
        <a href="{grn_cellular_pageurl page="$pagepath/create" cid=$cid aid=$aid add_b=$data_for_view.mid bid=$book.bid add_raw=$email}">
        {$email|grn_cellular_truncate:$width|escape}</a><BR>
	{/foreach}	

    {/foreach}
    {if $before || $next}
        <BR>
        {if $before}
            <a href="{grn_cellular_pageurl page="$pagepath/search2"  pg=$before_page s_text=$str submit_user=true}">
            {cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
        {/if}
        {if $next}
            <a href="{grn_cellular_pageurl page="$pagepath/search2"  pg=$next_page s_text=$str submit_user=true}">
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
