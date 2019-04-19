<div id="tree_structure">
 <div class="items">
  <div class="parent">

{** show root organization **}
{if $selected.category == ''}
 {assign var="is_selected" value=1}
{else}
 {assign var="is_selected" value=0}
{/if}
 {capture name='grn_grn_GRN_GRN_11'}{cb_msg module='grn.grn' key='GRN_GRN-11' replace='true'}{/capture}{grn_structure_link page=$page_info.all caption=$smarty.capture.grn_grn_GRN_GRN_11 class='folder20_c' category='' focus=$is_selected}

{** 兄弟を表示 **}
{if $target.siblings}
   <div class="child">
 {foreach from=$target.siblings item=sibling}
  {if $sibling.category == $selected.category}
   {assign var="is_selected" value=1 }
  {else}
   {assign var="is_selected" value=0}
  {/if}
  {if $sibling.child}
   {assign var="org_class" value="folder20_co"}
  {else}
   {assign var="org_class" value="folder20"}
  {/if}
   {grn_structure_link page=$page_info.all caption=$sibling.title class=$org_class category=$sibling.category focus=$is_selected}
 {/foreach}
   </div>
{/if}
   
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
