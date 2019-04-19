{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-180' replace='true'}</th>
   <td>
    {grn_text necessary=true name='search_text' value=$search_text size='50'}
    <input type="submit" name="Search" value="{cb_msg module='grn.mail' key='GRN_MAIL-181' replace='true'}">
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-182' replace='true'}</th>
   <td>
    {capture name='grn_mail_GRN_MAIL_183'}{cb_msg module='grn.mail' key='GRN_MAIL-183' replace='true'}{/capture}{grn_checkbox name='all_account' id='all_account1' value='1' caption=$smarty.capture.grn_mail_GRN_MAIL_183 checked=$all_account onclick="changeFolderOff(this,'saccount','scid','0');checkOn(this,'sub','cbx')"}<br>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-184' replace='true'}</th>
   <td>
    {include file='mail/_change_folder.tpl' a_name='saccount' c_name='scid' change_off=1 hide_garbage_folder=$hide_garbage_folder}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-185' replace='true'}</th>
   <td>
    {capture name='grn_mail_GRN_MAIL_186'}{cb_msg module='grn.mail' key='GRN_MAIL-186' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='sub' value='sub' checked=$search_keys.sub caption=$smarty.capture.grn_mail_GRN_MAIL_186}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-187' replace='true'}</th>
   <td>
    <select name="search_term">
     <option value="1"{if 1 == $search_term} selected{/if}>{cb_msg module='grn.mail' key='GRN_MAIL-188' replace='true'}
     <option value="3"{if 3 == $search_term} selected{/if}>{cb_msg module='grn.mail' key='GRN_MAIL-190' replace='true'}
     <option value="6"{if 6 == $search_term} selected{/if}>{cb_msg module='grn.mail' key='GRN_MAIL-192' replace='true'}
     <option value="12"{if 12 == $search_term} selected{/if}>{cb_msg module='grn.mail' key='GRN_MAIL-194' replace='true'}
     <option value="-1"{if -1 == $search_term} selected{/if}>{cb_msg module='grn.mail' key='GRN_MAIL-196' replace='true'}
    </select>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-197' replace='true'}</th>
   <td>
    {capture name='grn_mail_GRN_MAIL_198'}{cb_msg module='grn.mail' key='GRN_MAIL-198' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='subject' value='subject' checked=$search_keys.subject caption=$smarty.capture.grn_mail_GRN_MAIL_198}
    {capture name='grn_mail_GRN_MAIL_199'}{cb_msg module='grn.mail' key='GRN_MAIL-199' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='data' value='data' checked=$search_keys.data caption=$smarty.capture.grn_mail_GRN_MAIL_199}
    {capture name='grn_mail_GRN_MAIL_200'}{cb_msg module='grn.mail' key='GRN_MAIL-200' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='from' value='from' checked=$search_keys.from caption=$smarty.capture.grn_mail_GRN_MAIL_200}
    {grn_checkbox name='search_keys[]' id='to' value='to' checked=$search_keys.to caption='To'}
    {grn_checkbox name='search_keys[]' id='cc' value='cc' checked=$search_keys.cc caption='Cc'}
    {grn_checkbox name='search_keys[]' id='bcc' value='bcc' checked=$search_keys.bcc caption='Bcc'}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
       {strip}
           <div class="mTop10">
               {capture name='grn_mail_GRN_MAIL_201'}{cb_msg module='grn.mail' key='GRN_MAIL-201' replace='true'}{/capture}
               {grn_button id="mail_button_search" ui="main" action="submit" caption=$smarty.capture.grn_mail_GRN_MAIL_201}
           </div>
       {/strip}
   </td>
  </tr>
 </table>
 <input type="hidden" name="optional_search" value="1">
 <input type="hidden" name="aid" value="{$aid}">
 <input type="hidden" name="cid" value="{$cid}">
 <input type="hidden" name="said" value="{$said}">
 <input type="hidden" name="shid" value="{$shid}">
</form>

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<form name="{$form_name|cat:'_cmd'}" method="post" action="{grn_pageurl page='mail/command_search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <div class="sub_title">{cb_msg module='grn.mail' key='GRN_MAIL-202' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>

{strip}
<div class="list_menu">
  <nobr>
    <span class="list_menu_item">
      {include file="grn/checkall.tpl" form_name=$form_name|cat:'_cmd' elem_name="ids[]"}
    </span>
    <span class="list_menu_item">
      {capture name='grn_mail_GRN_MAIL_210'}{cb_msg module='grn.mail' key='GRN_MAIL-210' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_210 id="btn_delete_multi1" onclick="return false;"}
    </span>
    <span class="list_menu_item">
      {capture name='grn_message_GRN_MAIL_406'}{cb_msg module='grn.mail' key='GRN_MAIL-406' replace='true'}{/capture}
      {include file='mail/_change_folder.tpl' no_account=1 checkon=1 moveon=1 hide_root_folder=1 hide_garbage_folder=1 show_another_account=$show_another_account c_name='dcid' c_id='dcid1' ids='ids[]' mv_disabled='true' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 mv_id='move1' default_selected='true' onchange="onChangeFolderSelect(this, 'dcid2', ['move1', 'move2']);"}
    </span>
  </nobr>
</div>
{/strip}

 <table class="list_column">
  <colgroup>
   <col width="2%">
   <col width="20%">
   <col width="15%">
   <col width="15%">
   <col width="12%">
   <col width="12%">
   <col width="12%">
   <col width="12%">
  </colgroup>
  <tr>
   <th nowrap></th>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-205' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-206' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-207' replace='true'}</th>
   <th nowrap>To</th>
   <th nowrap>Cc</th>
   <th nowrap>Bcc</th>
{if $sort eq 'rtime'}
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-208' replace='true'}</th>
{else}
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-209' replace='true'}</th>
{/if}
  </tr>
{foreach from=$search.search_item item=search_item name="search_loop"}
  <tr class="{if $search_item.unread}unread_color{else}{if $smarty.foreach.search_loop.iteration % 2 == 0}lineone{else}linetwo{/if}{/if}">
   <td><input type="checkbox" name="ids[]" value="{$search_item.id}"></td>
   <td>
 {if $search_item.draft neq '1'} {* 下書き以外 *}
  {* イメージファイル名の決定 *}
  {if $search_item.attach_file}
   {if $search_item.unread}
    {assign var='mail_image' value='mail_clip30x20.gif'}
   {else}
    {if $search_item.action}
     {if $search_item.action eq '1'}{* 返信 *}
      {assign var='mail_image' value='mail_clip30x20_r.gif'}
     {elseif $search_item.action eq '2'}{* 全員に返信 *}
      {assign var='mail_image' value='mail_clip30x20_a.gif'}
     {elseif $search_item.action eq '3'}{* 転送 *}
      {assign var='mail_image' value='mail_clip30x20_f.gif'}
     {else}
     {/if}
    {else}
      {assign var='mail_image' value='mail_clip30x20.gif'}
    {/if}
   {/if}
  {else}
   {if $search_item.unread}
    {assign var='mail_image' value='mail20.gif'}
   {else}
    {if $search_item.action}
     {if $search_item.action eq '1'}{* 返信 *}
      {assign var='mail_image' value='mail20_r.gif'}
     {elseif $search_item.action eq '2'}{* 全員に返信 *}
      {assign var='mail_image' value='mail20_a.gif'}
     {elseif $search_item.action eq '3'}{* 転送 *}
      {assign var='mail_image' value='mail20_f.gif'}
     {else}
     {/if}
    {else}
     {assign var='mail_image' value='mail20.gif'}
    {/if}
   {/if}
  {/if}
  {* 標題の表示 *}
  {if $search_item.subject eq ''}
   {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image=$mail_image truncated_caption=$characters.subject unread=1 mid=$search_item.id}
  {else}
   {grn_link page='mail/view' caption=$search_item.subject image=$mail_image truncated_caption=$characters.subject unread=1 mid=$search_item.id}
  {/if}
 {else} {* 下書き *}
  {* イメージファイル名の決定 *}
  {if $search_item.attach_file}
   {assign var='mail_image' value='draft_clip30x20.gif'}
  {else}
   {assign var='mail_image' value='draft20.gif'}
  {/if}
  {* 標題の表示 *}
  {if $search_item.subject eq ''}
    {grn_link page='mail/draft_view' caption_module='grn.mail' caption_key='no_title' image=$mail_image truncated_caption=$characters.subject mid=$search_item.id}
  {else}
    {grn_link page='mail/draft_view' caption=$search_item.subject image=$mail_image truncated_caption=$characters.subject mid=$search_item.id}
  {/if}
 {/if}
   </td>
   <td>{$search_item.data|escape:"html"|cb_mb_truncate:$characters.data}</td>
   <td>{grn_mail_name type=$name_type name_format=$name_format name=$search_item.from truncated=$characters.name mid=$search_item.id aid=$search_item.account_id cid=$search_item.folder_id}
   <td>{grn_mail_name type=$name_type name_format=$name_format name=$search_item.to truncated=$characters.name mid=$search_item.id aid=$search_item.account_id cid=$search_item.folder_id}
   <td>{grn_mail_name type=$name_type name_format=$name_format name=$search_item.cc truncated=$characters.name mid=$search_item.id aid=$search_item.account_id cid=$search_item.folder_id}
   <td>{grn_mail_name type=$name_type name_format=$name_format name=$search_item.bcc truncated=$characters.name mid=$search_item.id aid=$search_item.account_id cid=$search_item.folder_id}
<!--
   <td>{$search_item.from|escape|cb_mb_truncate:$characters.name}</td>
   <td>{if $search_item.to}{$search_item.to|escape|cb_mb_truncate:$characters.name}{else}&nbsp;{/if}</td>
   <td>{if $search_item.cc}{$search_item.cc|escape|cb_mb_truncate:$characters.name}{else}&nbsp;{/if}</td>
   <td>{if $search_item.bcc}{$search_item.bcc|escape|cb_mb_truncate:$characters.name}{else}&nbsp;{/if}</td>
-->
   <td>{grn_date_format date=$search_item.time}</td>
  </tr>
{/foreach}
 </table>
{*
 <input type="hidden" name="optional_search" value="1">
*}
 <input type="hidden" name="aid" value="{$aid}">
 <input type="hidden" name="cid" value="{$cid}">
{*
 <input type="hidden" name="said" value="{$said}">
 <input type="hidden" name="shid" value="{$shid}">
*}
 <input type="hidden" name="cmd">

{strip}
<div class="list_menu">
  <nobr>
    <span class="list_menu_item">
      {include file="grn/checkall.tpl" form_name=$form_name|cat:'_cmd' elem_name="ids[]"}
    </span>
    <span class="list_menu_item">
      {capture name='grn_mail_GRN_MAIL_210'}{cb_msg module='grn.mail' key='GRN_MAIL-210' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_210 id="btn_delete_multi2" onclick="return false;"}
    </span>
    <span class="list_menu_item">
      {capture name='grn_message_GRN_MAIL_406'}{cb_msg module='grn.mail' key='GRN_MAIL-406' replace='true'}{/capture}
      {include file='mail/_change_folder.tpl' no_account=1 checkon=1 moveon=1 hide_root_folder=1 hide_garbage_folder=1 show_another_account=$show_another_account c_name='dcid2' c_id='dcid2' ids='ids[]' mv_disabled='true' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 mv_id='move2' default_selected='true' onchange="onChangeFolderSelect(this, 'dcid1', ['move1', 'move2']);"}
    </span>
  </nobr>
</div>
{/strip}
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>

<!--
{foreach from=$shids item=shid key=temp_key}
 <input type="hidden" name="shid{$temp_key}" value="{$shid}">
{/foreach}
-->
</form>
<script language="JavaScript">
<!--
    window.onload = function(){literal}{{/literal}typeChangeWM("{$form_name}","all_account","saccount:scid:sub");{literal}}{/literal}
    
    {literal}
    function grn_is_checked_mail(form, target_name)
    {
        if(! grn_is_checked( form, target_name ))
        {
            document.getElementById("dcid2").selectedIndex = 0;
            document.getElementById("dcid1").selectedIndex = 0;
            return false;
        }
        return true;
    }
    {/literal}
//-->
</script>
</td></tr></tbody></table><!--end of maincontents_list-->

{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
{grn_load_javascript file="grn/html/folder_select.js"}

{include file='grn/footer.tpl'}
