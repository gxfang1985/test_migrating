{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="get" action="{grn_pageurl page='bulletin/draft_search'}">
<input type="hidden" name="in" value="1">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-157' replace='true'}</th>
   <td>{grn_text necessary=true name="text" value=$search.text size="50"}&nbsp;{capture name='grn_bulletin_GRN_BLLT_158'}{cb_msg module='grn.bulletin' key='GRN_BLLT-158' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_GRN_BLLT_158}<br>{capture name='grn_bulletin_GRN_BLLT_159'}{cb_msg module='grn.bulletin' key='GRN_BLLT-159' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_bulletin_GRN_BLLT_159}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-160' replace='true'}</th>
   <td>{cb_msg module='grn.bulletin' key='GRN_BLLT-161' replace='true'}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-162' replace='true'}</th>
   <td>
    {capture name='grn_bulletin_GRN_BLLT_163'}{cb_msg module='grn.bulletin' key='GRN_BLLT-163' replace='true'}{/capture}{grn_checkbox name="su" id="subject" value="1" checked=$search.items.subject caption=$smarty.capture.grn_bulletin_GRN_BLLT_163}
    {capture name='grn_bulletin_GRN_BLLT_164'}{cb_msg module='grn.bulletin' key='GRN_BLLT-164' replace='true'}{/capture}{grn_checkbox name="da" id="data"    value="1" checked=$search.items.data    caption=$smarty.capture.grn_bulletin_GRN_BLLT_164}
  </tr>
  <tr>
   <td></td>
   <td>{capture name='grn_bulletin_GRN_BLLT_165'}{cb_msg module='grn.bulletin' key='GRN_BLLT-165' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_165}</td>
  </tr>
 </table>

 <p>
 <div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-166' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
 <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="33%">
   <col width="33%">
   <col width="20%">
   <col width="14%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-169' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-170' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-171' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-172' replace='true'}</th>
  </tr>
{foreach from=$search.result item=search_item}
  <tr>
   <td nowrap>
 {if $search_item.file_attached}
    {grn_link page='bulletin/draft_view' caption=$search_item.title image='bulletin_clip30x20.gif' unread=0 aid=$search_item.aid truncated_caption=$config.subject_width}
 {else}
    {grn_link page='bulletin/draft_view' caption=$search_item.title image='bulletin20.gif'       unread=0 aid=$search_item.aid truncated_caption=$config.subject_width}
 {/if}
   </td>
   <td nowrap>{$search_item.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
 {if $search_item.cid === "deleted"}
   <td nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-173' replace='true'}</td>
 {elseif strlen($search_item.category_name) < 1}
   <td nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-174' replace='true'}</td>
 {else}
   <td nowrap>{grn_image image='category20.gif'}{$search_item.category_name|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
 {/if}
   <td nowrap>{grn_date_format date=$search_item.mtime format="DateTimeCompact"}</td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
</form>

{include file="grn/footer.tpl"}
