{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{if $start_flag}
{cb_msg module='grn.address.cellular' key="search"}<br>
{else}
    {cb_msg module='grn.address.cellular' key="search_answer"}
{/if}

<hr>
{if ! $book_options}
    {cb_msg module='grn.address.cellular' key='GRN_ADDR_CELL-10' replace='true'}<BR>
{else}
    {grn_cellular_form method=post page="$pagepath/search" search_flag="$search_flag" me_pg=$me_pg}
    {grn_select name='bid' options=$book_options}
    <BR>
    {cb_msg module='grn.address.cellular' key="search_text"}<BR>
    <input type="text" name="s_name" value="{$search_str|escape}" istyle="1" mode="hiragana"><BR>
    
    <input type=submit accesskey="1" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.address.cellular' key="search"}"><br>
    </form>
{/if}

{foreach item=book from=$book_data}
    {grn_cellular_pictogram key="person"}
    <a href="{grn_cellular_pageurl page="$pagepath/look" cid=$book.cid bid=$book.bid }">{$book.subject|escape}</a>
    <BR>
    
    {if strlen($book.email) > 0}
        &nbsp;&nbsp;
        {grn_cellular_mailto mail=$book.email caption=$book.email  width=$width}
        <br>
    {/if}
    
    {if strlen($book.tel) > 0}
        &nbsp;&nbsp;
        {grn_cellular_tel tel=$book.tel}
        <BR>
    {/if}
{/foreach}

{if $navi}<BR>
{if $navi.previous_page_start_position != -1}
    <a href="{grn_cellular_pageurl page="$pagepath/search" sp=$navi.previous_page_start_position bid=$bid s_name=$search_str}">
    {cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
{/if}

{if $navi.next_page_start_position != -1}
    <a href="{grn_cellular_pageurl page="$pagepath/search" sp=$navi.next_page_start_position bid=$bid s_name=$search_str}">
    {cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}
{/if}

<br>

{grn_cellular_link page="cellular/menu" caption_module='grn.address.cellular' caption_key="link_back"}

<br>

<hr>
{/strip}
{grn_cellular_link page="$pagepath/my_address_select" accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>
{grn_cellular_link page="$pagepath/list" accesskey=9 caption_module='grn.address.cellular' caption_key="link_user_list"}<BR>
{include file="cellular/footer.tpl"}
