{capture name='head'}{/capture}
{capture name='body'}{/capture}
{capture name='foot'}{/capture}
{capture name='display_name'}{$item.display_name|escape}{/capture}
{if $item_id == 'personal_name'}
    {* 個人名 *}	
    {capture name='display_name'}{cb_msg module='grn/address' key='personal_name'}{/capture}
    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.family_name|escape} {$card.given_name|escape}{else}{$card.family_name} {$card.given_name}{/if}{/capture}
{elseif $item_id == 'personal_sort_key'}
    {* 個人名（よみ） *}
    {capture name='display_name'}{cb_msg module='grn/address' key='personal_sort_key'}{/capture}
    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.family_sort_key|escape} {$card.given_sort_key|escape}{else}{$card.family_sort_key} {$card.given_sort_key}{/if}{/capture}
{elseif $item_id == 'map'}
    {* 地図 *}
    {if $is_cbwebsrv && 0 < strlen( $card.$item_id )}
        {if $is_show}
            {capture name='grn_address_GRN_ADDR_89'}{cb_msg module='grn.address' key='GRN_ADDR-89' replace='true'}{/capture}{assign var='caption' value=$smarty.capture.grn_address_GRN_ADDR_89}
            {assign var='is_show' value=0}
            {assign var='show_icon' value='hideup20.gif'}
            {capture name='foot'}<br><img align="absmiddle" src="{$card.$item_id}">{/capture}
        {else}
            {capture name='grn_address_GRN_ADDR_90'}{cb_msg module='grn.address' key='GRN_ADDR-90' replace='true'}{/capture}{assign var='caption' value=$smarty.capture.grn_address_GRN_ADDR_90}
            {assign var='is_show' value=1}
            {assign var='show_icon' value='showdown20.gif'}
        {/if}
        {capture name='body'}{grn_link page='address/view' caption=$caption image=$show_icon bid=$book_id cid=$card_id mp=$is_show}
            &nbsp;{cb_msg module='grn.cbwebsrv' key='GRN_WBS-5' replace='true'}
        {/capture}
    {/if}
{elseif $item_id == 'route' && ( 0 < strlen( $card.route ) || 0 < strlen( $card.route_time ) || 0 < strlen( $card.route_fare ) )}
    {* 路線 *}
    {capture name='body'}{$card.route|escape}<br>{$card.route_time|escape}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-91' replace='true'}<br>{$card.route_fare|escape}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-92' replace='true'}{/capture}	
{elseif 0 < strlen( (string)$card.$item_id )}
    {if $item_id == 'company_name'}
        {* 会社名 *}
        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|escape}{else}{$card.$item_id}{/if}{/capture}
    {elseif $item.type == GRN_ADDRESS_ITEM_URL}
        {* URL *}
        {capture name='body'}{$card.$item_id|grn_autolink}{/capture}		
    {elseif $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
        {* 画像URL *}
        {capture name='body'}{grn_image image=$card.$item_id direct=true}{/capture}
    {elseif $item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
        {* E-Mailアドレス *}		
        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}		
    {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
        {* ファイル *}		
        {assign var='file' value=$card.$item_id}		
        {capture name='body'}{grn_filename dpage='address/file_download' bid=$book_id cid=$card_id fid=$file.oid name=$file.name mime=$file.mime inline=true hash=$file.hash}{/capture}
    {elseif $item.type == GRN_ADDRESS_ITEM_IP_PHONE}
        {* IP電話 *}
        {assign var=callto value=$card.$item_id|escape}
        {assign var=callto_caption value=$card.$item_id}
        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_link page="callto:$callto" page_direct=true caption=$callto_caption}{else}{$callto}{/if}{/capture}
    {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
        {* 複数行文字列 *}
        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_format body=$card.$item_id}{else}{$card.$item_id}{/if}{/capture}
    {else}
        {* 1行文字列 *}
        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
    {/if}	
{/if}
