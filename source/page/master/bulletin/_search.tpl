<input type="hidden" name="in" value="1">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-341' replace='true'}</th>
   <td>
    {grn_text necessary=true name="text" value=$search.text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-342' replace='true'}"><br>
    {capture name='grn_bulletin_GRN_BLLT_343'}{cb_msg module='grn.bulletin' key='GRN_BLLT-343' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_bulletin_GRN_BLLT_343}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-344' replace='true'}</th>
   <td>
{if ! $category_id}
 {if ! $search.personal}
 <input type="hidden" name="scid" value="">{cb_msg module='grn.bulletin' key='GRN_BLLT-345' replace='true'}
 {else}
 <input type="hidden" name="scid" value="">{cb_msg module='grn.bulletin' key='GRN_BLLT-346' replace='true'}
 {/if}
{else}
 {if $search.scid == $category_id}
 {grn_radio name="scid" id="select" value=$category_id caption=$category.name checked=true}{cb_msg module='grn.bulletin' key='GRN_BLLT-347' replace='true'}{capture name='grn_bulletin_GRN_BLLT_348'}{cb_msg module='grn.bulletin' key='GRN_BLLT-348' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_348}
 {else}
 {grn_radio name="scid" id="select" value=$category_id caption=$category.name}{cb_msg module='grn.bulletin' key='GRN_BLLT-349' replace='true'}{capture name='grn_bulletin_GRN_BLLT_350'}{cb_msg module='grn.bulletin' key='GRN_BLLT-350' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_350 checked=true}
 {/if}
{/if}
   </td>
  </tr>
{if $category_id}
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-351' replace='true'}</th>
   <td>{capture name='grn_bulletin_GRN_BLLT_352'}{cb_msg module='grn.bulletin' key='GRN_BLLT-352' replace='true'}{/capture}{grn_checkbox name="sb" id="sub" value="1" checked=$search.sub caption=$smarty.capture.grn_bulletin_GRN_BLLT_352}</td>
  </tr>
{/if}
{if $search.term != 'before'}
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-353' replace='true'}</th>
   <td>
    <select name="li">
     <option value="1"{if $search.limit == 1} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-354' replace='true'}
     <option value="3"{if $search.limit == 3} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-356' replace='true'}
     <option value="6"{if $search.limit == 6} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-358' replace='true'}
     <option value="12"{if $search.limit == 12} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-360' replace='true'}
     <option value="0"{if ! $search.limit} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-362' replace='true'}
    </select>
   </td>
  </tr>
{/if}
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-363' replace='true'}</th>
   <td>
{if $search.term != 'before'}
{capture name='grn_bulletin_GRN_BLLT_364'}{cb_msg module='grn.bulletin' key='GRN_BLLT-364' replace='true'}{/capture}{grn_checkbox name="ca" id="category" value="1" checked=$search.items.category     caption=$smarty.capture.grn_bulletin_GRN_BLLT_364}
{/if}
{capture name='grn_bulletin_GRN_BLLT_365'}{cb_msg module='grn.bulletin' key='GRN_BLLT-365' replace='true'}{/capture}{grn_checkbox name="su" id="subject"  value="1" checked=$search.items.subject      caption=$smarty.capture.grn_bulletin_GRN_BLLT_365}
{capture name='grn_bulletin_GRN_BLLT_366'}{cb_msg module='grn.bulletin' key='GRN_BLLT-366' replace='true'}{/capture}{grn_checkbox name="da" id="data"     value="1" checked=$search.items.data         caption=$smarty.capture.grn_bulletin_GRN_BLLT_366}
{if $search.term != 'before'}
{capture name='grn_bulletin_GRN_BLLT_367'}{cb_msg module='grn.bulletin' key='GRN_BLLT-367' replace='true'}{/capture}{grn_checkbox name="cr" id="creator"  value="1" checked=$search.items.creator_name caption=$smarty.capture.grn_bulletin_GRN_BLLT_367}
{capture name='grn_bulletin_GRN_BLLT_368'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name="fo" id="follow"   value="1" checked=$search.items.follow       caption=$smarty.capture.grn_bulletin_GRN_BLLT_368}
{/if}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>{strip}
           <div class="mTop15">
           {capture name='grn_bulletin_GRN_BLLT_369'}{cb_msg module='grn.bulletin' key='GRN_BLLT-369' replace='true'}{/capture}
           {grn_button action="submit" id="bulletin_button_search" ui="main" caption=$smarty.capture.grn_bulletin_GRN_BLLT_369}
           </div>
       {/strip}
   </td>
  </tr>
 </table>
</form>

{if $search.term != 'before' && $search.items.category}
<p>
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-370' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$category_navi.start_count end_num=$category_navi.end_count all_num=$category_navi.count}</div>
<div class="navi"><nobr>{include file="bulletin/_category_navi.tpl" navi=$category_navi.navi sp=$navi.start_count}</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="30%">
  <col width="70%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-373' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-374' replace='true'}</th>
 </tr>
{foreach from=$search_category.result item=item}
 <tr class="{cycle values='linetwo,lineone'}">
  <td>{grn_link page='bulletin/index' caption=$item.name image='category20.gif' cid=$item.cid}</td>
  <td>{grn_image image='category20.gif'}{$item.path|escape}</td>
 </tr>
{/foreach}
</table>
<div class="navi"><nobr>{include file="bulletin/_category_navi.tpl" navi=$category_navi.navi sp=$navi.start_count}</nobr></div>
{/if}


<p>
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-375' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
<div class="navi"><nobr>{include file="bulletin/_article_navi.tpl" navi=$navi.navi sp=$category_navi.start_count}</nobr></div>
<table class="list_column">
 <colgroup>
{if $search.term != 'before' || ! $search.personal}
  <col width="30%">
  <col width="30%">
  <col width="15%">
  <col width="15%">
  <col width="10%">
{else}
  <col width="33%">
  <col width="33%">
  <col width="20%">
  <col width="14%">
{/if}
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-378' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-379' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-380' replace='true'}</th>
{if $search.term != 'before' || ! $search.personal}
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-381' replace='true'}</th>
{/if}
{if $search.term != 'before'}
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-382' replace='true'}</th>
{else}
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-383' replace='true'}</th>
{/if}
 </tr>
{foreach from=$search.result item=item}
 <tr class="{cycle values='linetwo,lineone'}">
  <td nowrap>
 {if $item.unread == -1} {** 未読 **}
  {if $item.file_attached}
   {grn_link page=$view_page caption=$item.title image='bulletin_clip30x20.gif'   unread=1 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$item.title image='bulletin20.gif'         unread=1 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {/if}
 {elseif $item.unread == 1} {** 更新 **}
  {if $item.file_attached}
   {grn_link page=$view_page caption=$item.title image='bulletin_clip30x20_u.gif' unread=0 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$item.title image='bulletin20_u.gif'       unread=0 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {/if}
 {else}
  {if $item.file_attached}
   {grn_link page=$view_page caption=$item.title image='bulletin_clip30x20.gif'   unread=0 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$item.title image='bulletin20.gif'         unread=0 cid=$item.cid aid=$item.aid truncated_caption=$config.subject_width}
  {/if}
 {/if}
  </td>
 {if $item.dtype == 'a'}
  <td nowrap>{$item.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
 {else}
  <td nowrap><a href="{grn_pageurl page=$view_page cid=$item.cid aid=$item.aid follow_id=$item.follow_id fragment='follow'}">{$item.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</a></td>
 {/if}
  <td>
 {if $item.cid == 'deleted'}
{cb_msg module='grn.bulletin' key='GRN_BLLT-384' replace='true'}
 {elseif strlen($item.category_name) < 1}
{cb_msg module='grn.bulletin' key='GRN_BLLT-385' replace='true'}
 {else}
{grn_image image='category20.gif'}{$item.category_name|cb_mb_truncate:$config.truncate_width|escape:"html"}
 {/if}
  </td>
 {if $item.dtype == 'a'}
  {if $search.term != 'before' || ! $search.personal}
  <td nowrap>
      {if $item.manually_enter_sender != null}
          {grn_sender_name name=$item.manually_enter_sender truncated=$config.name_width no_image=true}
      {else}
          {if $item.group_name}{$item.group_name|escape} ({/if}{grn_user_name name=$item.creator_name uid=$item.creator_uid users_info=$users_info truncated=$config.name_width}{if $item.group_name} ){/if}
      {/if}
  </td>
  <td nowrap>{grn_date_format date=$item.ntime format="DateTimeCompact"}</td>
  {else}
  <td nowrap>{grn_date_format date=$item.stime format="DateTimeCompact"}</td>
  {/if}
 {else}
  {if $search.term != 'before' || ! $search.personal}
  <td nowrap>{if $item.group_name}{$item.group_name|escape} ({/if}{grn_user_name name=$item.creator_name uid=$item.creator_uid users_info=$users_info truncated=$config.name_width}{if $item.group_name} ){/if}</td>
  {/if}
  <td nowrap>{grn_date_format date=$item.ctime format="DateTimeCompact"}</td>
 {/if}
 </tr>
{/foreach}
</table>
<div class="navi"><nobr>{include file="bulletin/_article_navi.tpl" navi=$navi.navi sp=$category_navi.start_count}</nobr></div>
