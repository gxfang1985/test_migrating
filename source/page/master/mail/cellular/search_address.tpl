{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{*cb_msg module='grn.mail.cellular' key="search1"*}<!--br-->

{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="search_address"}
<hr>
{if ! $book_options}
    {cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-3' replace='true'}<BR>
{else}
    {grn_cellular_form method=post page="$pagepath/search_address" cid=$cid aid=$aid me_pg=$me_pg}
    {grn_select name='bid' options=$book_options}
    <BR>
    {cb_msg module='grn.address.cellular' key="search_text"}<BR>
    <input type="text" name="s_name" value="{$s_name|escape}" istyle="1" mode="hiragana"><BR>
    <input type=submit accesskey="1" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.mail.cellular' key="search_txt"}"><br>
    </form>
{/if}
<br>

{foreach item=book from=$book_data}
    {grn_cellular_pictogram key="person"}{$book.subject|escape}<br>
    <a href="{grn_cellular_pageurl page="$pagepath/create" cid=$cid aid=$aid add=$book.cid bid=$book.bid}">
    {$book.email|grn_cellular_truncate:$width|escape}</a><BR>
{/foreach}

{if $navi}<BR>
{if $navi.previous_page_start_position != -1}
 <a href="{grn_cellular_pageurl page="$pagepath/search_address" sp=$navi.previous_page_start_position bid=$bid cid=$cid aid=$aid }">
 {cb_msg module='grn.cellular.common' key="link_back"}</a>
{/if}

{if $navi.next_page_start_position != -1}
 &nbsp;<a href="{grn_cellular_pageurl page="$pagepath/search_address" sp=$navi.next_page_start_position bid=$bid cid=$cid aid=$aid }">
 {cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}<BR>
{/if}

{grn_cellular_link page="$pagepath/search1" aid=$aid cid=$cid caption_module='grn.mail.cellular' caption_key="link_back"}<BR>
<hr>
{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
