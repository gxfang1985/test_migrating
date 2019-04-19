{if ! $page_prefix}{assign var='page_prefix' value='bulletin'}{/if}
{if ! $article_view}{assign var='article_view' value='view'}{/if}
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-548' replace='true'}{grn_sentence caption=$article.title image='bulletin20.gif'}{cb_msg module='grn.bulletin' key='GRN_BLLT-549' replace='true'}</div>
<table class="list_column">
 <colgroup>
  <col width="20%">
  <col width="20%">
  <col width="30%">
  <col width="10%">
  <col width="10%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-550' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-551' replace='true'}</th>
  <th nowrap>{cb_msg module='grn' key='grn.comment.body.and.comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-553' replace='true'}</th>
{if $sort != 'ctd'}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_554'}{cb_msg module='grn.bulletin' key='GRN_BLLT-554' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_554 page=$page_info.all cid=$article.cid aid=$article.aid sort='ctd' reverse=1}</th>
{else}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_555'}{cb_msg module='grn.bulletin' key='GRN_BLLT-555' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_555 page=$page_info.all cid=$article.cid aid=$article.aid sort='ctu'}</th>
{/if}
 </tr>
{foreach from=$article.all_attach_files item=file}
 <tr>
  <td nowrap>{grn_link image='file20.gif' caption=$file.title|cb_mb_truncate:$config.subject_width page=$page_prefix|cat:'/file_view' cid=$article.cid aid=$article.aid follow_id=$file.follow_id fid=$file.fid}</td>
  <td nowrap>{grn_link image='disk20.gif' caption=$file.filename page=$page_prefix|cat:'/file_download' cid=$article.cid aid=$article.aid follow_id=$file.follow_id fid=$file.fid postfix=$file.filename ticket=$download_ticket}</td>
{if $file.follow_id}
  <td nowrap><a href="{grn_pageurl page=$page_prefix|cat:'/'|cat:$article_view cid=$article.cid aid=$article.aid follow_id=$file.follow_id fragment='follow'}">{$file.abstruct|cb_mb_truncate:$config.truncate_width|escape:"html"}</a></td>
{else}
  <td nowrap><a href="{grn_pageurl page=$page_prefix|cat:'/'|cat:$article_view cid=$article.cid aid=$article.aid}">{$file.abstruct|cb_mb_truncate:$config.truncate_width|escape:"html"}</a></td>
{/if}
  <td nowrap>{grn_user_name uid=$file.creator_uid name=$file.creator_name users_info=$users_info truncated=$config.name_width}</td>
  <td nowrap>{grn_date_format date=$file.ctime format="DateTimeCompact"}</td>
 </tr>
{/foreach}
</table>
