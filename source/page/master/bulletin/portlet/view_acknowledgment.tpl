{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
 {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
 {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="fontsize" value='font-size:60%;'}
{else}
 {assign var="fontsize" value='font-size:80%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='bulletin/unconfirmed_list' uid=$category.cid tid=0}">{$portlet.title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_unacknowledged_topic_grn">
<table class="list_column" style="{$font_size}">
 <colgroup>
{if ! $portlet.settings.hide_columns.creator}
  <col width="25%">
{/if}
{if ! $portlet.settings.hide_columns.mtime}
  <col width="25%">
{/if}
<col width="25%">
{if ! $portlet.settings.hide_columns.abstract}
  <col width="25%">
{/if}
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-4' replace='true'}</th>
  {if ! $portlet.settings.hide_columns.creator}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-6' replace='true'}</th>
  {/if}
  {if ! $portlet.settings.hide_columns.mtime}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-26' replace='true'}</th>
  {/if}
  {if ! $portlet.settings.hide_columns.abstract}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-9' replace='true'}</th>
  {/if}
 </tr>
{foreach from=$articles item=article}
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
          {if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name truncated=$config.name_width users_info=$users_info}{if $article.group_name} ){/if}
      {/if}
  </td>
 {/if}
 {if ! $portlet.settings.hide_columns.mtime}
  <td nowrap style="{$fontsize}">{grn_date_format date=$article.mtime format="DateTimeCompact"}</td>
 {/if}
  {if ! $portlet.settings.hide_columns.abstract}
  <td nowrap>{$article.category_name|cb_mb_truncate:$config.truncate_width|escape:"category_name"}</td>
 {/if}
 </tr>
{/foreach}
</table>
</div> <!--end of portal_frame -->
