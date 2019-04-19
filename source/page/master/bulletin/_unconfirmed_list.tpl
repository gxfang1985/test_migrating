{include file="grn/head.tpl"}
{*GRN35-129*}
{include file='grn/header_no_siteposition.tpl'}
<table class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;"><tbody><tr><td width="100%" valign="bottom" nowrap>
{grn_image image="bulletin20.gif"}{$page_title}
</table>
<div class="mainarea">
{*GRN35-129*}
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
  {include file="grn/smart_word_navi_310.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="20%">
  <col width="20%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-16' replace='true'}</th> <!-- subject -->
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-21' replace='true'}</th>
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_604'}{cb_msg module='grn.bulletin' key='GRN_BLLT-604' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_604 page=$page_info.all sort='last_mtime' reverse=$sort_params.last_mtime.reverse disable=$sort_params.last_mtime.disable}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-107' replace='true'}</th>
 </tr>
 {foreach from=$bulletins item=article}
 <tr>
  <td nowrap>
   {if $article.file_attached}
     {grn_link page='bulletin/view' caption=$article.title image='bulletin_clip30x20.gif'   unread=1 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
    {else}
     {grn_link page='bulletin/view' caption=$article.title image='bulletin20.gif'         unread=1 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
    {/if}
   
  </td>
 {if ! $portlet.settings.hide_columns.creator}
  <td nowrap style="{$fontsize}">
      {if $article.manually_enter_sender != null}
          {grn_sender_name name=$article.manually_enter_sender truncated=$config.name_width no_image=true}
      {else}
          {if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name truncated=$config.name_width}{if $article.group_name} ){/if}
      {/if}
  </td>
 {/if}
 {if ! $portlet.settings.hide_columns.mtime}
  <td nowrap style="{$fontsize}">{grn_date_format date=$article.ntime format="DateTimeCompact"}</td>
 {/if}
  {if ! $portlet.settings.hide_columns.abstract}
  <td nowrap>{$article.category_name|cb_mb_truncate:$config.truncate_width|escape:"category_name"}</td>
 {/if}
 </tr>
{/foreach}

</table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi_info.navi}</nobr></div>

{include file="grn/footer.tpl"}
