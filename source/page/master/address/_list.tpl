{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
{include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}
{if ! $search && ( $access.operation || $access.add || 0 > $book_id )}
    <div class="list_menu"><nobr>
        <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="cid[]"}</span>
        <span class="list_menu_item">{capture name='grn_address_GRN_ADDR_4'}{cb_msg module='grn.address' key='GRN_ADDR-4' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_address_GRN_ADDR_4 onclick="return false;" id='btn_delete_multi1'}</span>
    </nobr></div>
{/if}
 <table class="list_column">
  <tr>
{if ! $search && ( $access.operation || $access.add || 0 > $book_id )}
    <th nowrap></th>
{/if}
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && $item.display && $item_id != 'map'}
        {if $item_id != 'route_time' && $item_id != 'route_fare'}
   <th nowrap>{cb_msg module='grn/address' key=$item_id}</th>
        {/if}
    {/if}
{/foreach}
{foreach from=$extended_items key=item_id item=item}
    {if $item.use && $item.display}
   <th nowrap>{$item.display_name|escape}</th>
    {/if}
{/foreach}
  </tr>
{foreach from=$cards key=card_id item=card}
  <tr class="{cycle values='linetwo,lineone'}">
    {if ! $search && ( $access.operation || $access.add || 0 > $book_id )}
   <td><input type="checkbox" name="cid[]" value="{$card_id}"></td>
    {/if}
    {foreach from=$builtin_items key=item_id item=item}
        {if $item.use && $item.display && $item_id != 'map'}
            {if $item_id != 'route_time' && $item_id != 'route_fare'}
                {capture name='body'}{/capture}
                {if $item_id == 'subject'}
                    {capture name='body'}{grn_link image='person20.gif' caption=$card.subject page='address/view' bid=$book_id cid=$card_id}{/capture}
                {elseif $item_id == 'personal_name'}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.family_name|escape} {$card.given_name|escape}{else}{$card.family_name} {$card.given_name}{/if}{/capture}
                {elseif $item_id == 'personal_sort_key'}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.family_sort_key|escape} {$card.given_sort_key|escape}{else}{$card.family_sort_key} {$card.given_sort_key}{/if}{/capture}
                {elseif (is_array($card.$item_id) && 0 < count( $card.$item_id )) || (is_string($card.$item_id) && 0 < strlen( $card.$item_id ))}
                    {if $item_id == 'route'}
                        {capture name='body'}{$card.route|escape|nl2br}<br>{$card.route_time|escape|nl2br}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-6' replace='true'}<br>{$card.route_fare|escape|nl2br}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-7' replace='true'}{/capture}
                    {elseif $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
                        {capture name='body'}{$card.$item_id|grn_autolink}{/capture}
                    {elseif $item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
                        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                    {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
                        {capture name='body'}{assign var=file value=$card.$item_id}{grn_filename dpage='address/file_download' bid=$book_id cid=$card_id fid=$file.oid name=$file.name mime=$file.mime}{/capture}
                    {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
                        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_format body=$card.$item_id}{else}{$card.$item_id}{/if}{/capture}
                    {else}
                        {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                    {/if}
                {/if}

       <td nowrap>{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="address" id_list=$card.sso}{/if}</td>
            {/if}
        {/if}
    {/foreach}
    {foreach from=$extended_items key=item_id item=item}
        {if $item.use && $item.display}
            {capture name='body'}{/capture}
            {if (is_array($card.$item_id) && 0 < count($card.$item_id)) || (is_string($card.$item_id) && 0 < strlen( $card.$item_id ))}
                {if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
                    {capture name='body'}{$card.$item_id|grn_autolink}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
                    {assign var=file value=$card.$item_id}
                    {capture name='body'}{grn_filename dpage='address/file_download' bid=$book_id cid=$card_id fid=$file.oid name=$file.name mime=$file.mime}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_format body=$card.$item_id}{else}{$card.$item_id}{/if}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_IP_PHONE}
                    {assign var=callto value=$card.$item_id|escape}
		    {assign var=callto_caption value=$card.$item_id}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_link page="callto:$callto" page_direct=true caption=$callto_caption}{else}{$callto}{/if}{/capture}
                {else}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                {/if}
            {/if}

   <td nowrap>{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="address" id_list=$card.sso}{/if}</td>
        {/if}
    {/foreach}
  </tr>
{/foreach}
 </table>
 
{if ! $search && ( $access.operation || $access.add || 0 > $book_id )}
{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
 <div class="list_menu"><nobr>
  <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="cid[]"}</span>
  <span class="list_menu_item">{grn_button_submit caption=$smarty.capture.grn_address_GRN_ADDR_4 onclick="return false;" id='btn_delete_multi2'}</span>
 </div>
{/if}
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>