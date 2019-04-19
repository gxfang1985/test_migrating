{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="search1"}<br>
<hr>
{if $enable_address}
    {grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="search_address"}<BR>
    
    {if ! $book_options}
        {cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-2' replace='true'}<BR>
    {else}
        {grn_cellular_form method=post page="$pagepath/search_address" cid=$cid aid=$aid}
        {grn_select name='bid' options=$book_options}<BR>
        {cb_msg module='grn.address.cellular' key="search_text"}<BR>
        <input type="text" name="s_name" istyle="1" mode="hiragana"><BR>
        {grn_cellular_submit accesskey=1 caption_module='grn.mail.cellular' caption_key="search_txt"}<br>
        </form>
    {/if}
    <br>
{/if}

{** Myアドレスグループが無い場合は、セレクトボックスとボタンを表示しない **}
{if $address_mygroups}

{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="select_my_address_group"}<BR>

{include file="cellular/my_address_group.tpl" accesskey=2 page="mail/cellular/my_address_select"}<BR>

{/if}

{grn_cellular_pictogram key="book"}{cb_msg module='grn.mail.cellular' key="search_user_list"}<BR>

{include file="cellular/group_tab.tpl" accesskey=3}

<br>
{grn_cellular_link page="$pagepath/create" aid=$aid cid=$cid  caption_module='grn.mail.cellular' caption_key="link_back"}<BR>
<hr>
{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
