<div id="tree_structure">
 <div class="items">
  <div class="parent">
{foreach from=$books key=key item=item}
   {grn_structure_link class=$class page="address/`$sub_dir``$shared_book_page`" caption=$item.display_name bid=$key focus=$item.focus}
{/foreach}
  </div>
 </div>
 <!--
 -->
 <div class="br">&nbsp;</div>
</div>
