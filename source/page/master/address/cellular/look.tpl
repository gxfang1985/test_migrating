{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{cb_msg module='grn.address.cellular' key="look_title"}<br>
<hr>

<BR>
{grn_cellular_pictogram key="person"}{cb_msg module='grn.address.cellular' key="name"}<BR>
{$book_data.subject|escape}({$book_data.family_sort_key|escape}&nbsp;{$book_data.given_sort_key|escape})<BR>
{grn_cellular_pictogram key="building"}{cb_msg module='grn.address.cellular' key="company"}&nbsp;&nbsp;<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}<a href="{grn_cellular_pageurl page="$pagepath/company" cid=$cid bid=$bid }">{$book_data.company_name|escape}</a>
<BR>


{if strlen($book_data.email_address) > 0}
{grn_cellular_pictogram key="mail"}{cb_msg module='grn.address.cellular' key="mail"}<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}
    
    {grn_cellular_mailto mail=$book_data.email_address}<BR>
{/if}

{if strlen($book_data.personal_telephone_number) > 0 || strlen($book_data.company_telephone_number) > 0}
    {grn_cellular_pictogram key="tel"}{cb_msg module='grn.address.cellular' key="tel"}<BR>
    {cb_msg module='grn.address.cellular' key="right_angle"}
    {if strlen($book_data.personal_telephone_number) > 0 }
        {grn_cellular_tel tel=$book_data.personal_telephone_number}<br>
    {else}
        {grn_cellular_tel tel=$book_data.company_telephone_number}<br>
    {/if}
{/if}

<br>

{grn_cellular_link page="$pagepath/search" caption_module='grn.address.cellular' caption_key="link_back"}<br>

<hr>

{/strip}

{include file="address/cellular/footer.tpl"}
{grn_cellular_link page="$pagepath/my_address_select" accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>

{grn_cellular_link page="$pagepath/list" accesskey=9 caption_module='grn.address.cellular' caption_key="link_user_list"}<BR>
{include file="cellular/footer.tpl"}
