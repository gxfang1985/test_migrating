{if $article.unread == -1 && $article.published}
 {assign var='unread' value=1}
{else}
 {assign var='unread' value=0}
{/if}

{if $no_read_status}
 {if $article.file_attached}
  {grn_link page=$view_page caption=$article.title image='bulletin_clip30x20.gif' unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
 {else}
  {grn_link page=$view_page caption=$article.title image='bulletin20.gif'         unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
 {/if}
{else}
 {if $article.published && ! $article.expired && $article.unread == -1} {** 未読 **}
  {if $article.file_attached}
   {grn_link page=$view_page caption=$article.title image='bulletin_clip30x20.gif' unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$article.title image='bulletin20.gif'      unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {/if}
 {elseif $article.published && ! $article.expired && $article.unread == 1} {** 更新 **}
  {if $article.file_attached}
   {grn_link page=$view_page caption=$article.title image='bulletin_clip30x20_u.gif' unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$article.title image='bulletin20_u.gif'       unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {/if}
 {else}
  {if $article.file_attached}
   {grn_link page=$view_page caption=$article.title image='bulletin_clip30x20.gif' unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {else}
   {grn_link page=$view_page caption=$article.title image='bulletin20.gif'       unread=$unread cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
  {/if}
 {/if}
{/if}
