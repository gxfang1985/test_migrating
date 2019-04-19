<div id="tree_structure">
 <div class="items">
  <div class="parent">
{foreach from=$list key=key item=item}
   {grn_structure_link caption=$item.title page=$page_info.all fagid=$item.id class=$class focus=$item.focus}
{/foreach}
  </div>
 </div>
 <!---><div class="br">&nbsp;</div>
</div>
