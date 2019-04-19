{if ! $folder_page}
 {assign var="folder_page" value=$page_info.all}
{/if}
{assign var="folder_focus" value=1}
{********************************************************************************************}
<div id="tree_structure">
 <div class="items">
  <div class="parent">
 {if $folder_id}
  {grn_structure_link page=$folder_page image="folder20.gif" caption_module='grn.memo' caption_key='lastest_folder_name'}
{*
  {if $folder_id == $portlet_folder_id}
  {grn_structure_link page=$folder_page image="unsentbox20.gif" caption_module='grn.memo' caption_key='portlet_folder_name' did=$portlet_folder_id focus=1}
  {else}
  {grn_structure_link page=$folder_page image="unsentbox20.gif" caption_module='grn.memo' caption_key='portlet_folder_name' did=$portlet_folder_id}
  {/if}
*}
 {else}
  {grn_structure_link page=$folder_page image="folder20.gif" caption_module='grn.memo' caption_key='lastest_folder_name' focus=1}
{*
  {grn_structure_link page=$folder_page image="unsentbox20.gif" caption_module='grn.memo' caption_key='portlet_folder_name' did=$portlet_folder_id}
*}
 {/if}
 {if count($folders) > 0}
 <div class="clear_both"><hr></div>
 {/if}
 {grn_memo_folder_tree folders=$folders}
  </div>
 </div>
</div>
