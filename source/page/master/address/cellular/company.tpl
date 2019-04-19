{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{cb_msg module='grn.address.cellular' key="company_title"}<br>
<hr>

<BR>
{grn_cellular_pictogram key="building"}{cb_msg module='grn.address.cellular' key="company_name"}({cb_msg module='grn.address.cellular' key="company_yomi"})<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{$book_data.company_name|escape}({$book_data.company_sort_key|escape})<BR>
{if strlen($book_data.zip_code) > 0}
{grn_cellular_pictogram key="post"}{cb_msg module='grn.address.cellular' key="company_zip"}&nbsp;&nbsp;<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{$book_data.zip_code|escape}<BR>
{/if}
{if strlen($book_data.physical_address) > 0}
{grn_cellular_pictogram key="libra"}{cb_msg module='grn.address.cellular' key="company_address"}<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{$book_data.physical_address|escape}<br>
{/if}
{if strlen($book_data.company_telephone_number) > 0}
{grn_cellular_pictogram key="tel"}{cb_msg module='grn.address.cellular' key="company_tel"}<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{grn_cellular_tel tel=$book_data.company_telephone_number}<BR>
{/if}
{if strlen($book_data.facsimile_number) > 0}
{grn_cellular_pictogram key="fax"}{cb_msg module='grn.address.cellular' key="company_fax"}&nbsp;&nbsp;<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{$book_data.facsimile_number|escape}<BR>
{/if}
{if strlen($book_data.url) > 0}
{grn_cellular_pictogram key="freedial"}{cb_msg module='grn.address.cellular' key="company_url"}<BR>
{cb_msg module='grn.address.cellular' key="right_angle"}{$book_data.url|escape}<br>
{/if}
<BR>

{grn_cellular_link page="$pagepath/look" cid=$cid bid=$bid caption_module='grn.address.cellular' caption_key="link_back"}

<BR>

<hr>

{/strip}
{include file="address/cellular/footer.tpl"}
{grn_cellular_link page="$pagepath/my_address_select" accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>
{grn_cellular_link page="$pagepath/list" accesskey=9 caption_module='grn.address.cellular' caption_key="link_user_list"}<BR>
{include file="cellular/footer.tpl"}
