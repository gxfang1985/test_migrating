<div id="tree_structure">
 <div class="items">
  <div class="parent">

{** show root organization **}
{if $organization_id == 0}
 {assign var="is_selected" value=1}
{else}
 {assign var="is_selected" value=0}
{/if}
 {capture name='grn_grn_GRN_GRN_244'}{cb_msg module='grn.grn' key='GRN_GRN-244' replace='true'}{/capture}{grn_structure_link page=$page_info.all caption=$smarty.capture.grn_grn_GRN_GRN_244 class='organize20_c' oid='0' focus=$is_selected}

{** 選択された組織までのパスを表示 **}
{foreach from=$organization.ancestors item=ancestor}
<div class="child">
  {grn_structure_link page=$page_info.all caption=$ancestor.title class='organize20_c' setup=$ancestor.setup oid=$ancestor.oid}
{/foreach}

{** 兄弟組織を表示 **}
{if $organization.siblings}
   <div class="child">
 {foreach from=$organization.siblings item=sibling}
  {if $sibling.oid == $organization.oid}
   {assign var="is_selected" value=1 }
  {else}
   {assign var="is_selected" value=0}
  {/if}
  {if $sibling.child}
   {assign var="org_class" value="organize20_co"}
  {else}
   {assign var="org_class" value="organize20"}
  {/if}
   {grn_structure_link page=$page_info.all caption=$sibling.title class=$org_class setup=$sibling.setup oid=$sibling.oid focus=$is_selected}

  {** 選択中の組織は子組織を表示する **}
  {if $sibling.oid == $organization.oid}
   {if $organization.children}
   <div class="child">
    {foreach from=$organization.children item=child}
     {if $child.children}
      {grn_structure_link page=$page_info.all caption=$child.title class='organize20_co' setup=$child.setup oid=$child.oid}
     {else}
      {grn_structure_link page=$page_info.all caption=$child.title class='organize20' setup=$child.setup oid=$child.oid}
     {/if}
    {/foreach}
   </div>
   {/if}
  {/if}
 {/foreach}
   </div>
{** トップに組織が1つしかなく、その組織が選択されている場合 **}
{elseif $organization.oid}
   <div class="child">
 {if $organization.children}
  {grn_structure_link page=$page_info.all caption=$organization.title class='organize20_co' setup=$organization.setup oid=$organization.oid}
   <div class="child">
  {foreach from=$organization.children item=child}
   {if $child.children}
  {grn_structure_link page=$page_info.all caption=$child.title class='organize20_co' setup=$child.setup oid=$child.oid}
   {else}
  {grn_structure_link page=$page_info.all caption=$child.title class='organize20' setup=$child.setup oid=$child.oid}
   {/if}
  {/foreach}
   </div>
 {else}
  {grn_structure_link page=$page_info.all caption=$organization.title class='organize20' setup=$organization.setup oid=$organization.oid}
 {/if}
   </div>
{/if}

{foreach from=$organization.ancestors item=ancestor}
   </div>
{/foreach}

  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
