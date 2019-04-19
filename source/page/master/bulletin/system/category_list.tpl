{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

{capture name="tmp"}{$page_title|grn_noescape}({$category.name|grn_noescape}){/capture}
{grn_title title=$smarty.capture.tmp class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_22'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-22' replace='true'}{/capture}{grn_link page='bulletin/system/category_add' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_22 image='category20.gif' cid=$category_id element_id="bulletin_category_add"}</span>
   {if $category_id}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_23'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-23' replace='true'}{/capture}{grn_link page='bulletin/system/category_view' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_23 image='detail20.gif' cid=$category_id}</span>
   {else}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_24'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-24' replace='true'}{/capture}{grn_link page='bulletin/system/category_view' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_24 image='detail20.gif' cid=$category_id disabled=TRUE}</span>
   {/if}
   {if $category.child_count > 1 || (! $category_id && $category.child_count > 1)}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_25'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-25' replace='true'}{/capture}{grn_link page='bulletin/system/category_order_all' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_25 image='order20.gif' cid=$category_id}</span>
   {else}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_26'}{cb_msg module='grn.system' key='GRN_SY-15' replace='true'}{/capture}{grn_link page='bulletin/system/category_order_all' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_26 image='order20.gif' cid=$category_id disabled=TRUE}</span>
   {/if}
</div>
{*
{include file="bulletin/_category_path.tpl" no_search=1}
*}
<table width="100%">
<tr valign="top">
<td id="tree_part">

 {*include file="bulletin/_category_structure.tpl" no_extra=1*}
 {include file="grn/org_tree_26.tpl"}

</td>
<td id="view_part" width="90%">

<div class="margin_bottom">
<div>
<span class="bold">{$category.name|escape}</span>
{capture name='grn_bulletin_system_GRN_BLLT_SYS_27'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-27' replace='true'}{/capture}{grn_link image='detail20.gif' page='bulletin/system/category_view' cid=$category_id caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_27 element_id="bulletin_category_detail"}
</div>
{if 0 < $category.memo|count_characters:true}
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}
</div>

   <div class="sub_title">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-28' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="40%">
     <col width="25%">
     <col width="20%">
     <col width="15%">
    </colgroup>
    <tr valign="top">
     {if $sort == 'suu'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_31'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-31' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_31   page=$page_info.all cid=$category_id sort='sud' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'sud'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_32'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-32' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_32   page=$page_info.all cid=$category_id sort='suu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_33'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-33' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_33   page=$page_info.all cid=$category_id sort='sud' sp=0 disable=1}</th>
      {/if}
     {/if}
     <th nowrap><div style="padding-top: 2px;">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-34' replace='true'}</div></th>
     {if $sort == 'guu'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_35'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-35' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_35   page=$page_info.all cid=$category_id sort='gud' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'gud'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_36'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-36' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_36   page=$page_info.all cid=$category_id sort='guu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_37'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-37' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_37   page=$page_info.all cid=$category_id sort='gud' sp=0 disable=1}</th>
      {/if}
     {/if}
     {if $sort == 'ntu'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_38'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-38' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_38 page=$page_info.all cid=$category_id sort='ntd' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'ntd'}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_39'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-39' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_39 page=$page_info.all cid=$category_id sort='ntu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_system_GRN_BLLT_SYS_40'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-40' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_40 page=$page_info.all cid=$category_id sort='ntd' sp=0 disable=1}</th>
      {/if}
     {/if}
    </tr>
{foreach from=$articles.article item=article}
    <tr valign="top">
     <td>
 {grn_link caption=$article.title image='bulletin20.gif' disabled=TURE truncated_caption=$config.subject_width}
     </td>
     <td>{if ! $article.published}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-41' replace='true'}{elseif $article.expired}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-42' replace='true'}{else}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-43' replace='true'}{/if}</td>
     <td>
         {if $article.manually_enter_sender != null}
            {grn_sender_name name=$article.manually_enter_sender truncated=$config.name_width no_image=true}
         {else}
            {if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name truncated=$config.name_width users_info=$users_info}{if $article.group_name} ){/if}
         {/if}
     </td>
     <td>{grn_date_format format='DateTimeCompact' date=$article.ntime}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi.navi}
     </div>

</td>
</tr>
</table>

{include file="grn/system_footer.tpl"}
