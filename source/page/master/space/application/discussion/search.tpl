<div class="space-discussion-searchArea-grn">
      <form name="form_search" method="get" action="{grn_pageurl page=space/application/discussion/search}">
      <input type="hidden" name="spid" value="{$spaceId}">
      <input type="hidden" name="tid" value="{$thread_id}">
      <span class="space-discussion-searchBox-grn">
        <input type="text" id="inp_srch" name="text" maxlength="100" value="{$text}"/>
      </span><span class="space-discussion-searchBtn-grn">
        <input type="submit" value=""/>
      </span>
      <div class="clear_both_0px"></div>
      </form>
</div>
{assign var='view_page' value='space/application/discussion/index'}
<p>
<div class="sub_title">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-33' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="33%">
  <col width="33%">
  <col width="20%">
  <col width="14%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-36' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-37' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-38' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-39' replace='true'}</th>
 </tr>
{foreach from=$result item=item}
 <tr class="{cycle values='linetwo,lineone'}">
  <td nowrap>
 {if $item.unread} {** 未読 **}
    {if $item.file_attached}
      {grn_link page=$view_page caption=$item.title class='space-thread-searchResult-unread-files-grn' spid=$spaceId fragment='tid='|cat:$item.tid}
    {else}
      {grn_link page=$view_page caption=$item.title class='space-thread-searchResult-unread-grn' spid=$spaceId fragment='tid='|cat:$item.tid}
    {/if}
 {else}
    {if $item.file_attached}
      {grn_link page=$view_page caption=$item.title class='space-thread-searchResult-read-files-grn' spid=$spaceId fragment='tid='|cat:$item.tid}
    {else}
      {grn_link page=$view_page caption=$item.title class='space-thread-searchResult-read-grn' spid=$spaceId fragment='tid='|cat:$item.tid}
    {/if}   
 {/if}
  </td>
 {if $item.dtype == '1'}
  <td nowrap>{$item.data|escape:"html"}</td>
 {else}
  <td nowrap><a href="{grn_pageurl page=$view_page spid=$spaceId fragment='tid='|cat:$item.tid|cat:'&cmno='|cat:$item.comment_num}">{$item.data|escape:"html"}</a></td>
 {/if}
 <td>
   {grn_space_user_link user=$item.creator}
 </td>
 <td>
   {if $item.dtype == '1'}
     {$item.mtime|escape}
   {else}
     {$item.ctime|escape}
   {/if}
 </td>
 </tr>
{/foreach}
</table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
