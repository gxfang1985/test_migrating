<table class="select_parts">
 <tr>
  <td nowrap>
<div id="tree_structure">
{if ! $current}
{cb_msg module='grn.phonemessage' key='GRN_PHM-52' replace='true'}
{else}
{$current.title|escape:"html"}
{/if}
</div>
  </td>
 </tr>
 <tr>
  <td nowrap>
<div id="tree_structure">
 <div class="items">
  <div class="parent">
{if ! $organization.path && $set_organization_id}
 {if $organization.child_organizations}
  {grn_structure_link script="javascript:on_change_organization(`$organization.hid`)" caption=$organization.title class='organize20_co' focus=TRUE  setup=$organization.deny}
 {else}
  {grn_structure_link script="javascript:on_change_organization(`$organization.hid`)" caption=$organization.title class='organize20'   focus=TRUE  setup=$organization.deny}
 {/if}
 {if $organization.child_organizations}
  <div class="child">
  {foreach from=$organization.child_organizations item=child}
   {if $child.num_children}
    {grn_structure_link script="javascript:on_change_organization(`$child.hid`)" caption=$child.title class='organize20_c' setup=$child.deny}
   {else}
    {grn_structure_link script="javascript:on_change_organization(`$child.hid`)" caption=$child.title class='organize20' setup=$child.deny}
   {/if}
  {/foreach}
  </div>
 {/if}
 {if $organization.num_organizations > 1}
 <hr>
 {/if}
 {foreach from=$organization.organizations item=sibling}
  {if $sibling.hid != $set_organization_id}
   {if $sibling.num_children}
    {grn_structure_link script="javascript:on_change_organization(`$sibling.hid`)" caption=$sibling.title class='organize20_c' setup=$sibling.deny}
   {else}
    {grn_structure_link script="javascript:on_change_organization(`$sibling.hid`)" caption=$sibling.title class='organize20' setup=$sibling.deny}
   {/if}
  {/if}
 {/foreach}
{else}
 {assign var="first" value="1"}
 {foreach from=$organization.path item=node}
  {if $first}
   {assign var="first" value="0"}
  {else}
  <div class="child">
  {/if}
  {if $node.num_children}
   {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20_co' setup=$node.deny}
  {else}
   {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20' setup=$node.deny}
  {/if}
 {/foreach}
 {if $organization.path}
  <div class="child">
 {/if}
 {foreach from=$organization.organizations item=node}
  {if $node.num_children}
   {if $node.hid == $set_organization_id}
    {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20_co' focus=TRUE setup=$node.deny}
  <div class="child">
    {foreach from=$organization.child_organizations item=child}
     {if $child.num_children}
      {grn_structure_link script="javascript:on_change_organization(`$child.hid`)" caption=$child.title class='organize20_c' setup=$child.deny}
     {else}
      {grn_structure_link script="javascript:on_change_organization(`$child.hid`)" caption=$child.title class='organize20' setup=$child.deny}
     {/if}
    {/foreach}
  </div>
   {else}
    {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20_c' setup=$node.deny}
   {/if}
  {else}
   {if $node.hid == $set_organization_id}
    {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20_o' focus=TRUE setup=$node.deny}
   {else}
    {grn_structure_link script="javascript:on_change_organization(`$node.hid`)" caption=$node.title class='organize20' setup=$node.deny}
   {/if}
  {/if}
 {/foreach}
 {if $organization.path}
  </div>
 {/if}
 {assign var="first" value="1"}
 {foreach from=$organization.path item=node}
  {if $first}
   {assign var="first" value="0"}
  {else}
  </div>
  {/if}
 {/foreach}
{/if}
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
  </td>
 </tr>
</table>
