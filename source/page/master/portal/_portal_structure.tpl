{if ! $category_page}
 {assign var="category_page" value=$page_info.all}
{/if}
{********************************************************************************************}
<div id="tree_structure">
 <div class="items">
  <div class="parent">
{foreach from=$list item=category}
   {grn_structure_link class=$class page=$category_page caption=$category.title pid=$category.id focus=$category.focus}
{/foreach}
  </div>
 </div>
 <!---><div class="br">&nbsp;</div>
</div>
