<div id="tree_structure">
 <div class="items">
  <div class="parent">
{foreach from=$mygroups item=mygroup}
   {grn_structure_link page=$form_name caption=$mygroup.name class='mygroup20' mgid=$mygroup.id focus=$mygroup.selected}
{/foreach}
  </div>
 </div>
 <!----->
</div>
