<div id="tree_structure">
 <div class="items">
  <div class="parent">
{if ! $category.cid}
   {capture name='grn_todo_GRN_TOD_30'}{cb_msg module='grn.todo' key='GRN_TOD-30' replace='true'}{/capture}{grn_structure_link page=$page_info.all image='category20.gif' caption=$smarty.capture.grn_todo_GRN_TOD_30 focus=TRUE}
{else}
   {capture name='grn_todo_GRN_TOD_31'}{cb_msg module='grn.todo' key='GRN_TOD-31' replace='true'}{/capture}{grn_structure_link page=$page_info.all image='category20.gif' caption=$smarty.capture.grn_todo_GRN_TOD_31}
{/if}
{foreach from=$categories.category item=element}
 {if $element.cid == $category.cid}
    {grn_structure_link page=$page_info.all image='category20.gif' caption=$element.title cid=$element.cid focus=TRUE}
 {else}
    {grn_structure_link page=$page_info.all image='category20.gif' caption=$element.title cid=$element.cid}
 {/if}
{/foreach}
  </div>
 </div>
 <div class="br">&nbsp;</div>
</div>
