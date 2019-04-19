<div id="tree_structure">
 <div class="items">
  <div class="parent">
{foreach from=$roles item=role}
   {grn_structure_link page=$page_info.all caption=$role.title class='role20' rid=$role.rid focus=$role.focus}
{/foreach}
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
