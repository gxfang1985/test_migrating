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
                {if $category}
                    {capture name='portlet_title'}{$category.name|grn_noescape}{/capture}
                    {capture name='portlet_title_left'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-1' replace='true'}{/capture}
                    {capture name='portlet_title_right'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-2' replace='true'}{/capture}
                {else}
                    {capture name='portlet_title'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-3' replace='true'}{/capture}
                {/if}
                {if $category.cid == 1}
                    <a href="{grn_pageurl page='bulletin/index' top=$category.cid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_left|escape}</span>
                        {$smarty.capture.portlet_title|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_right|escape}</span>
                    </a>
                {else}
                    <a href="{grn_pageurl page='bulletin/index' cid=$category.cid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_left|escape}</span>
                        {$smarty.capture.portlet_title|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_right|escape}</span>
                    </a>
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_bulletin_grn">
{if $use_star}
{include file="star/star_init.tpl" list_id="bulletin_list`$portlet.plid`"}
<table class="list_column" style="{$font_size}" id="bulletin_list{$portlet.plid}">
 <colgroup>
  <col width="1%">
{else}
<table class="list_column" style="{$font_size}">
 <colgroup>
{/if}
  <col width="25%">
{if ! $portlet.settings.hide_columns.abstract}
  <col width="25%">
{/if}
{if ! $portlet.settings.hide_columns.creator}
  <col width="25%">
{/if}
{if ! $portlet.settings.hide_columns.mtime}
  <col width="25%">
{/if}
 </colgroup>
 <tr>
  {if $use_star}<th><br/></th>{/if}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-4' replace='true'}</th>
  {if ! $portlet.settings.hide_columns.abstract}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-5' replace='true'}</th>
  {/if}
  {if ! $portlet.settings.hide_columns.creator}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-6' replace='true'}</th>
  {/if}
  {if ! $portlet.settings.hide_columns.mtime}
  <th nowrap>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-7' replace='true'}</th>
  {/if}
 </tr>
{foreach from=$articles item=article}
 <tr>
  {if $use_star}<td>{grn_star_icon module="grn.bulletin" star_infos=$star_infos unique_id=$article.aid aid=$article.aid}</td>{/if}
  <td nowrap>
  {if $article.unread == -1} {** 未読 **}
   {if $article.file_attached}
     {grn_link page='bulletin/view' caption=$article.title image='bulletin_clip30x20.gif'   unread=1 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
    {else}
     {grn_link page='bulletin/view' caption=$article.title image='bulletin20.gif'         unread=1 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
    {/if}
   {elseif $article.unread == 1} {** 更新 **}
   {if $article.file_attached}
    {grn_link page='bulletin/view' caption=$article.title image='bulletin_clip30x20_u.gif' unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
   {else}
    {grn_link page='bulletin/view' caption=$article.title image='bulletin20_u.gif'       unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
   {/if}
  {else}
   {if $article.file_attached}
    {grn_link page='bulletin/view' caption=$article.title image='bulletin_clip30x20.gif'   unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
   {else}
    {grn_link page='bulletin/view' caption=$article.title image='bulletin20.gif'         unread=0 cid=$article.cid aid=$article.aid truncated_caption=$config.subject_width}
   {/if}
  {/if}
  </td>
 {if ! $portlet.settings.hide_columns.abstract}
  <td nowrap>{$article.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
 {/if}
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
  <td nowrap style="{$fontsize}">{grn_date_format date=$article.ntime format="DateTimeCompact"}</td>
 {/if}
 </tr>
{/foreach}
</table>
</div> <!--end of portal_frame -->
