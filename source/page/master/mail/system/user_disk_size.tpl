{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
    <div id="rare_menu_part">
     <form name="search" method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
         <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100">
         <input type="hidden" name="sort" value="{$sort_order_column}">
         <input class="small" type="submit" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-451' replace='true'}">{if $search_text}&nbsp;<input class="small" type="submit" name="clear" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-452' replace='true'}">{/if}
     </form>
    </div>
</div>

<table width="100%">
 <tr valign="top">
  <td id="view_part">
 {if $is_search}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-453' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-456' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
  <table class="list_column">
   <colgroup>
    <col width="30%">
    <col width="15%">
    <col width="30%">
    <col width="5%">
    <col width="5%">
    <col width="5%">
    <col width="5%">
    <col width="5%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-459' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-460' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-461' replace='true'}</th>
    <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_462'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-462' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_462 page='mail/system/user_disk_size' sort='size' reverse=$sort_size.reverse disable=$sort_size.disabled search_text=$sort_size.search_text}</th>
    <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_463'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-463' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_463 page='mail/system/user_disk_size' sort='mtl' reverse=$sort_mtl.reverse disable=$sort_mtl.disabled search_text=$sort_mtl.search_text}</th>
    <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_464'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-464' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_464 page='mail/system/user_disk_size' sort='mrl' reverse=$sort_mrl.reverse disable=$sort_mrl.disabled search_text=$sort_mrl.search_text}</th>
    <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_465'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-465' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_465 page='mail/system/user_disk_size' sort='msl' reverse=$sort_msl.reverse disable=$sort_msl.disabled search_text=$sort_msl.search_text}</th>
    <th nowrap></th>
   </tr>
   
 {foreach from=$user_list key=key item=item}
   <tr valign="top">
    <td  nowrap>{grn_user_name uid=$key users_info=$users_info}</td>
    <td nowrap>{$item.foreign_key|escape}</td>
     <td nowrap>
  {foreach from=$item.account_list item=account}
      {grn_image image='mailaccount20.gif'}{$account.title|escape}<br>
  {/foreach}
     </td>
  {if ($item.mail_size eq '') and ($item.mail_size neq '0')}
     <td>&nbsp;</td>
  {else}
     <td nowrap>
     {if $item.mail_size >= 1048576}
        {grn_format_filesize size=$item.mail_size unit="MB"}
     {else}
        {grn_format_filesize size=$item.mail_size unit="KB"}
     {/if}
     </td>
  {/if}
    <td nowrap>
    {if !$item.no_display_value}
        {if $item.user_limit > 999999}
            {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-466' replace='true'}
        {else}
            {$item.user_limit} MB
        {/if}
    {else}
    &nbsp;
    {/if}
    </td>
    <td nowrap>
    {if !$item.no_display_value}
        {if $item.receive_limit > 102400}
            {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-467' replace='true'}
        {else}
            {$item.receive_limit}
            {if $item.receive_unit} MB
            {else} KB
            {/if}
        {/if}
    {else}
    &nbsp;
    {/if}
    </td>
    <td nowrap>
    {if !$item.no_display_value}
        {if $item.send_limit > 30720}
            {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-468' replace='true'}
        {else}
            {$item.send_limit}
            {if $item.send_unit} MB
            {else} KB
            {/if}
        {/if}
    {else}
    &nbsp;
    {/if}
    </td>
    <td nowrap>
    {capture name='grn_mail_system_GRN_MAIL_SY_469'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-469' replace='true'}{/capture}{grn_link page='mail/system/user_mail_limit' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_469 uid=$key}
    </td>
   </tr>
 {/foreach}
  </table>
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi sort=$sort_order_column}
    </div>

  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
