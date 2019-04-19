{if ! $off_word_navi}
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
{include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}

 <div id="userlist_address_book">
 <table class="list_column" {$font_size}>
{/if}
  <tr>
{foreach from=$builtin_items item=item}
    {if $item.use && $item.show && $item.display}
   <th nowrap>
        {$item.display_name|escape}
   </th>
    {/if}
{/foreach}
{foreach from=$extended_items item=item}
    {if $item.use && $item.show && $item.display}
   <th nowrap>
        {$item.display_name|escape}
   </th>
    {/if}
{/foreach}
  </tr>
{foreach from=$cards key=card_id item=card}
  <tr class="{cycle values='linetwo,lineone'}">
    {foreach from=$builtin_items key=item_id item=item}
        {if $item.use && $item.show && $item.display}
            {capture name='body'}{/capture}
            {if $item_id == 'display_name'}
                {* 名前 *}
                {if $imageIcon}
                    {capture name='body'}{grn_user_name uid=$card_id users_info=$users_info noimage=1}<div class="profileImageUserList">{grn_user_image_icon userInfo=$users_info.$card_id photoUrl=$users_info.$card_id.photoUrl userId=$card_id loginId=$loginId alt=$users_info.$card_id.col_display_name size=$iconSize userList=true}</div>{/capture}
                {else}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_user_name uid=$card_id users_info=$users_info userList=true}{else}{$card.$item_id}{/if}{/capture}
                {/if}
            {elseif $item.type == GRN_ADDRESS_ITEM_ATTENDEE}
                {* 在席情報 *}
                {capture name='body'}
                {assign var='presence' value=$card.presence}
                {grn_link page=$presence.page caption=$presence.info uid=$card_id disabled=$presence.disabled}
                {if $presence.mtime}<br>
                    {if $presence.old}<span class="attention">{/if}
                        {grn_date_format date=$presence.mtime format="DateTimeMiddle_YMDW_HM"}
                    {if $presence.old}</span>{/if}
                {/if}
                {/capture}
            {elseif $card.$item_id}
                {if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
                    {* URL、画像URL *}
                    {capture name='body'}{$card.$item_id|grn_autolink}{/capture}
                {elseif $item.type == GRN_ADDRESS_EMAIL_ADDRESS}
                    {* E-Mailアドレス *}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
                    {* ファイル *}
                    {assign var=file value=$card.$item_id}
                    {capture name='body'}{grn_filename dpage='grn/file_download' uid=$card_id fid=$file.oid name=$file.name mime=$file.mime}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_USER_GROUPS}
                    {* 所属する組織 *}
                    {capture name='body'}
                        {assign var="delimiter" value=""}
                        {foreach from=$card.$item_id key=group_id item=group}
                            {$delimiter|grn_noescape}
                            {if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$group.title|escape}<span class="org_path">({$group.path|escape})</span>{else}{$group.title} <span class="org_path">({$group.path})</span> {/if}
                            {assign var="delimiter" value="<br>"}
                        {/foreach}
                    {/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_LANGUAGE}
                    {capture name='body'}{cb_language_name id=$card.$item_id}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
                    {* 複数行文字列 *}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{grn_format body=$card.$item_id}{else}{$card.$item_id}{/if}{/capture}
                {else}
                    {* 1行文字列 *}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                {/if}
            {/if}

   <td nowrap>{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id='uum' id_list=$card.sso}{/if}</td>
        {/if}
    {/foreach}

    {foreach from=$extended_items key=item_id item=item}
        {if $item.use && $item.show && $item.display}
            {capture name='body'}{/capture}
            {if $card.$item_id}
                {if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
                    {* URL、画像URL *}
                    {capture name='body'}{$card.$item_id|grn_autolink}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
                    {* E-Mailアドレス *}
                    {capture name='body'}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$card.$item_id|grn_autolink}{else}{$card.$item_id}{/if}{/capture}
                {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
                    {* ファイル *}
                    {assign var=file value=$card.$item_id}
                    {capture name='body'}{grn_filename dpage='grn/file_download' uid=$card_id fid=$file.oid name=$file.name mime=$file.mime}{/capture}
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

   <td nowrap>{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id='uum' id_list=$card.sso}{/if}</td>
        {/if}
    {/foreach}
  </tr>
{/foreach}
{if ! $off_word_navi}
 </table>
 </div>
 <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
{/if}
