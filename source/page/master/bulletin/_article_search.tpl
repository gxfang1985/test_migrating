<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="in" value="1">
{literal}
<script language="JavaScript" type="text/javascript"><!--
function change_term( form, sel )
{
    if( sel.options[sel.selectedIndex].value == 'before' ) {
        form.elements['li'].disabled = true;
    } else {
        form.elements['li'].disabled = false;
    }
}
//--></script>
{/literal}

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-423' replace='true'}
  </th>
  <td>
      {grn_text necessary=true name="text" value=$search.text size="50"}&nbsp;{capture name='grn_bulletin_GRN_BLLT_424'}{cb_msg module='grn.bulletin' key='GRN_BLLT-424' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_GRN_BLLT_424}<br>{capture name='grn_bulletin_GRN_BLLT_425'}{cb_msg module='grn.bulletin' key='GRN_BLLT-425' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_bulletin_GRN_BLLT_425}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-426' replace='true'}
  </th>
  <td>
      <select name='te' onchange='change_term(this.form,this)'>
      <option value='all'{if $search.term == 'all'} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-427' replace='true'}
      <option value='before'{if $search.term == 'before'} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-428' replace='true'}
      <option value='published'{if $search.term == 'published'} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-429' replace='true'}
      <option value='expired'{if $search.term == 'expired'} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-430' replace='true'}
      </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-431' replace='true'}
  </th>
  <td>
{if $page_info.parts[1] == 'operation'}
 {$category.name|escape}
{else}
 {if ! $category_id}
 <input type="hidden" name="scid" value="">{cb_msg module='grn.bulletin' key='GRN_BLLT-432' replace='true'}
 {elseif $search.scid == $category_id}
 {grn_radio name="scid" id="select" value=$category.cid caption=$category.name checked=true}{cb_msg module='grn.bulletin' key='GRN_BLLT-433' replace='true'}{capture name='grn_bulletin_GRN_BLLT_434'}{cb_msg module='grn.bulletin' key='GRN_BLLT-434' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_434}
 {else}
 {grn_radio name="scid" id="select" value=$category.cid caption=$category.name}{cb_msg module='grn.bulletin' key='GRN_BLLT-435' replace='true'}{capture name='grn_bulletin_GRN_BLLT_436'}{cb_msg module='grn.bulletin' key='GRN_BLLT-436' replace='true'}{/capture}{grn_radio name="scid" id="all" value="-1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_436 checked=true}
 {/if}
{/if}
  </td>
 </tr>
{if $page_info.parts[1] != 'operation'}
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-437' replace='true'}
  </th>
  <td>
      {capture name='grn_bulletin_GRN_BLLT_438'}{cb_msg module='grn.bulletin' key='GRN_BLLT-438' replace='true'}{/capture}{grn_checkbox name="sb" id="sub" value="1" checked=$search.sub caption=$smarty.capture.grn_bulletin_GRN_BLLT_438}
  </td>
 </tr>
{/if}
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-439' replace='true'}
  </th>
  <td>
      <select name="li"{if $search.term == 'before'} disabled{/if}>
       <option value="1"{if $search.limit == 1} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-440' replace='true'}
       <option value="3"{if $search.limit == 3} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-442' replace='true'}
       <option value="6"{if $search.limit == 6} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-444' replace='true'}
       <option value="12"{if $search.limit == 12} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-446' replace='true'}
       <option value="0"{if ! $search.limit} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-448' replace='true'}</select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-449' replace='true'}
  </th>
  <td>
{**
{if $page_info.parts[1] == 'system'}
{capture name='grn_bulletin_GRN_BLLT_450'}{cb_msg module='grn.bulletin' key='GRN_BLLT-450' replace='true'}{/capture}{grn_checkbox name="ca" id="category" value="1" checked=$search.items.category     caption=$smarty.capture.grn_bulletin_GRN_BLLT_450}
{/if}
**}
{capture name='grn_bulletin_GRN_BLLT_451'}{cb_msg module='grn.bulletin' key='GRN_BLLT-451' replace='true'}{/capture}{grn_checkbox name="su" id="subject" value="1" checked=$search.items.subject      caption=$smarty.capture.grn_bulletin_GRN_BLLT_451}
{capture name='grn_bulletin_GRN_BLLT_452'}{cb_msg module='grn.bulletin' key='GRN_BLLT-452' replace='true'}{/capture}{grn_checkbox name="da" id="data"    value="1" checked=$search.items.data         caption=$smarty.capture.grn_bulletin_GRN_BLLT_452}
{capture name='grn_bulletin_GRN_BLLT_453'}{cb_msg module='grn.bulletin' key='GRN_BLLT-453' replace='true'}{/capture}{grn_checkbox name="cr" id="creator" value="1" checked=$search.items.creator_name caption=$smarty.capture.grn_bulletin_GRN_BLLT_453}
{capture name='grn_bulletin_GRN_BLLT_454'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name="fo" id="follow"  value="1" checked=$search.items.follow       caption=$smarty.capture.grn_bulletin_GRN_BLLT_454}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_bulletin_GRN_BLLT_455'}{cb_msg module='grn.bulletin' key='GRN_BLLT-455' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_GRN_BLLT_455}
  </td>
 </tr>
</table>

{**
{if $page_info.parts[1] == 'system' && $search.items.category}
<p>
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-456' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$category_navi.start_count end_num=$category_navi.end_count all_num=$category_navi.count}</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="30%">
  <col width="70%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-459' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-460' replace='true'}</th>
 </tr>
{foreach from=$search_category.result item=item}
 <tr>
  <td>{grn_link page=$page_prefix|cat:'/bulletin_list' caption=$item.name image='category20.gif' cid=$item.cid}</td>
  <td>{grn_image image='category20.gif'}{$item.path|escape}</td>
 </tr>
{/foreach}
</table>
<div class="contents_navi"><nobr>
{include file="bulletin/_category_navi.tpl" navi=$category_navi.navi sp=$navi.start_count}
</nobr></div>
{/if}
**}

   <p>
   <div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-461' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
{if $page_info.parts[1] == 'system'}
     <col width="25%">
     <col width="20%">
     <col width="20%">
     <col width="10%">
     <col width="15%">
     <col width="10%">
{else}
     <col width="35%">
     <col width="30%">
     <col width="10%">
     <col width="15%">
     <col width="10%">
{/if}
    </colgroup>
    <tr>
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-464' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-465' replace='true'}</th>
{if $page_info.parts[1] == 'system'}
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-466' replace='true'}</th>
{/if}
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-467' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-468' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-469' replace='true'}</th>
    </tr>
{foreach name="slist" from=$search.result item=search_item}
    <tr valign="top"><td>
{if $search_item.dtype == 'f' && ! $smarty.foreach.slist.first}
<br>
{else}
  {if $page_info.parts[1] == 'system'}
   {include file='bulletin/_article_subject.tpl' view_page=$page_prefix|cat:'/bulletin_view' article=$search_item no_read_status=1}
  {else}
   {include file='bulletin/_article_subject.tpl' view_page=$page_prefix|cat:'/bulletin_view' article=$search_item}
  {/if}
{/if}
     </td>
{if $search_item.dtype == 'a'}
     <td>{$search_item.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
{else}
     <td><a href="{grn_pageurl page=$page_prefix|cat:'/bulletin_view' cid=$search_item.cid aid=$search_item.aid follow_id=$search_item.follow_id fragment='follow'}">{$search_item.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</a></td>
{/if}
{if $page_info.parts[1] == 'system'}
     <td>{$search_item.category_name|escape:"html"}</td>
{/if}
     <td>{if ! $search_item.published}{cb_msg module='grn.bulletin' key='GRN_BLLT-470' replace='true'}{elseif $search_item.expired}{cb_msg module='grn.bulletin' key='GRN_BLLT-471' replace='true'}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-472' replace='true'}{/if}</td>
{if $search_item.dtype == 'a'}
     <td>
         {if $search_item.manually_enter_sender != null}
            {grn_sender_name name=$search_item.manually_enter_sender truncated=$config.name_width no_image=true}
         {else}
            {if $search_item.group_name}{$search_item.group_name|escape} ({/if}{grn_user_name name=$search_item.creator_name uid=$search_item.creator_uid truncated=$config.name_width users_info=$users_info}{if $search_item.group_name} ){/if}
         {/if}
     </td>
     <td>{grn_date_format date=$search_item.ntime format="DateTimeCompact"}</td>
{else}
     <td>{if $search_item.group_name}{$search_item.group_name|escape} ({/if}{grn_user_name name=$search_item.creator_name uid=$search_item.creator_uid truncated=$config.name_width}{if $search_item.group_name} ){/if}</td>
     <td>{grn_date_format date=$search_item.ctime format="DateTimeCompact"}</td>
{/if}
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="bulletin/_article_navi.tpl" navi=$navi.navi sp=$category_navi.start_count}
     </div>

