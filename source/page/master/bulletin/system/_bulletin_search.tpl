<input type="hidden" name="in" value="1">
<div id="one_parts">
 <!--action--->
 <div id="action">
  <!----->
   <div class="list">
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-104' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_text necessary=true name="text" value=$search.search_text size="50"}&nbsp;{capture name='grn_bulletin_system_GRN_BLLT_SYS_105'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-105' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_105}<br>{capture name='grn_bulletin_system_GRN_BLLT_SYS_106'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-106' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.search_sensitive caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_106}
      </div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-107' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">
{if ! $category_id}
 {if ! $search.search_personal}
 <input type="hidden" name="scid" value="-1">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-108' replace='true'}
 {else}
 <input type="hidden" name="scid" value="-1">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-109' replace='true'}
 {/if}
{elseif $search.items.scid == $category_id}
 {grn_radio name="scid" id="select" value=$category_id caption=$category.name checked=true}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-110' replace='true'}{capture name='grn_bulletin_system_GRN_BLLT_SYS_111'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-111' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_111}
{else}
 {grn_radio name="scid" id="select" value=$category_id caption=$category.name}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-112' replace='true'}{capture name='grn_bulletin_system_GRN_BLLT_SYS_113'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-113' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_113 checked=true}
{/if}
      </div>
     </div>
    </p>
{if $article_term}
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-114' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word"><select name='aterm'>
      <option value='all'{if $article_term == 'all'} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-115' replace='true'}
      <option value='before'{if $article_term == 'before'} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-116' replace='true'}
      <option value='published'{if $article_term == 'published'} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-117' replace='true'}
      <option value='expired'{if $article_term == 'expired'} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-118' replace='true'}
      </select></div>
     </div>
    </p>
{/if}
{if $category_id}
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-119' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">{capture name='grn_bulletin_system_GRN_BLLT_SYS_120'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-120' replace='true'}{/capture}{grn_checkbox name="sb" id="sub" value="1" checked=$search.search_sub caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_120}</div>
     </div>
    </p>
{/if}
{if $search.search_term != 'before'}
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-121' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word"><select name="li">
       <option value="1"{if $search.search_limit == 1} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-122' replace='true'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-123' replace='true'}
       <option value="3"{if $search.search_limit == 3} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-124' replace='true'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-125' replace='true'}
       <option value="6"{if $search.search_limit == 6} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-126' replace='true'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-127' replace='true'}
       <option value="12"{if $search.search_limit == 12} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-128' replace='true'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-129' replace='true'}
       <option value="0"{if ! $search.search_limit} selected{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-130' replace='true'}</select></div>
     </div>
    </p>
{/if}
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-131' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">
{capture name='grn_bulletin_system_GRN_BLLT_SYS_132'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-132' replace='true'}{/capture}{grn_checkbox name="su" id="subject" value="1" checked=$search.search_items.subject      caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_132}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_133'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-133' replace='true'}{/capture}{grn_checkbox name="da" id="data"    value="1" checked=$search.search_items.data         caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_133}
{if $search.search_term != 'before'}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_134'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-134' replace='true'}{/capture}{grn_checkbox name="cr" id="creator" value="1" checked=$search.search_items.creator_name caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_134}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_135'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name="fo" id="follow"  value="1" checked=$search.search_items.follow       caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_135}
{/if}
      </div>
     </div>
    </p>
    <p class="item">
     <div class="contents_button">
      <div class="word">
       {capture name='grn_bulletin_system_GRN_BLLT_SYS_136'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-136' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_136}
      </div>
     </div>
    </p>
   </div>
   <div class="br">&nbsp;</div>
   <hr>
   <h2 class="sub_title">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-137' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count} end_num=$navi.end_count all_num=$navi.count}</h2>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
{if $search.search_term != 'before' || ! $search.search_personal}
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
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-140' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-141' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-142' replace='true'}</th>
{if $search.search_term != 'before' || ! $search.search_personal}
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-143' replace='true'}</th>
{/if}
{if $search.search_term != 'before'}
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-144' replace='true'}</th>
{else}
     <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-145' replace='true'}</th>
{/if}
    </tr>
{foreach from=$search.search_result item=search_item}
    <tr valign="top">
     <td>
 {if $search_item.unread == -1} {** 未読 **}
  {if $search_item.file_attached}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20_clip8'   unread=1 cid=$search_item.cid aid=$search_item.aid}
  {else}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20'         unread=1 cid=$search_item.cid aid=$search_item.aid}
  {/if}
 {elseif $search_item.unread == 1} {** 更新 **}
  {if $search_item.file_attached}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20_u_clip8' unread=0 cid=$search_item.cid aid=$search_item.aid}
  {else}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20_u'       unread=0 cid=$search_item.cid aid=$search_item.aid}
  {/if}
 {else}
  {if $search_item.file_attached}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20_clip8'   unread=0 cid=$search_item.cid aid=$search_item.aid}
  {else}
   {grn_link page=$view_page caption=$search_item.title class='bulletin20'         unread=0 cid=$search_item.cid aid=$search_item.aid}
  {/if}
 {/if}
     </td>
 {if $search_item.dtype == 'a'}
     <td>{$search_item.data|escape:"html"}</td>
 {else}
     <td><a href="{grn_pageurl page=$view_page cid=$search_item.cid aid=$search_item.aid follow_id=$search_item.follow_id fragment='follow'}">{$search_item.data|escape:"html"}</a></td>
 {/if}
     <td>{$search_item.category_title|escape:"html"}</td>
 {if $search_item.dtype == 'a'}
  {if $search.search_term != 'before' || ! $search.search_personal}
     <td>{grn_user_name name=$search_item.creator_name uid=$search_item.creator_uid}</td>
     <td>{grn_date_format date=$search_item.ntime format="DateTimeCompact"}</td>
  {else}
     <td>{grn_date_format date=$search_item.stime format="DateTimeCompact"}</td>
  {/if}
 {else}
  {if $search.search_term != 'before' || ! $search.search_personal}
     <td>{grn_user_name name=$search_item.creator_name uid=$search_item.creator_uid}</td>
  {/if}
     <td>{grn_date_format date=$search_item.ctime format="DateTimeCompact"}</td>
 {/if}
    </tr>
{/foreach}
   </table>
   <div class="list">
    <p class="item">
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi.navi}
     </div>
    </p>
   </div>
  <!----->
 </div>
 <!--action_end--->
</div>
