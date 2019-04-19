{* 購読とか通知とかアクセス権とか設定中ならアスタリスクが表示される *}
<table class="select_parts">
 <tr>
  <td nowrap>
<div id="tree_structure">
{if ! $current}
{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-8' replace='true'}
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
{if ! $category.path && $set_category_id}
 {grn_bulletin_category_title script="javascript:on_change_category(`$category.cid`)" title=$category.title cid=$category.cid child=$category.num_children open=1 params=$params notified=$category.notified subscribed=$category.subscribed focus=1}
 {if $category.child_categories}
  <div class="child">
  {foreach from=$category.child_categories item=child}
   {grn_bulletin_category_title script="javascript:on_change_category(`$child.cid`)" title=$child.title cid=$child.cid child=$child.num_children params=$params notified=$child.notified subscribed=$child.subscribed}
  {/foreach}
  </div>
 {/if}
 {if $category.num_categories > 1}
 <hr>
 {/if}
 {foreach from=$category.categories item=sibling}
  {if $sibling.cid != $set_category_id}
   {grn_bulletin_category_title script="javascript:on_change_category(`$sibling.cid`)" title=$sibling.title cid=$sibling.cid child=$sibling.num_children params=$params notified=$sibling.notified subscribed=$sibling.subscribed}
  {/if}
 {/foreach}
{else}
 {foreach name=cloop from=$category.path item=node}
  {if ! $smarty.foreach.cloop.first}
  <div class="child">
  {/if}
  {grn_bulletin_category_title script="javascript:on_change_category(`$node.cid`)" title=$node.title cid=$node.cid child=$node.num_children params=$params notified=$node.notified subscribed=$node.subscribed open=1}
 {/foreach}
 {if $category.path}
  <div class="child">
 {/if}
 {foreach from=$category.categories item=node}
  {if $node.num_children}
   {if $node.cid == $set_category_id}
    {grn_bulletin_category_title script="javascript:on_change_category(`$node.cid`)" title=$node.title cid=$node.cid child=$node.num_children params=$params notified=$node.notified subscribed=$node.subscribed open=1 focus=1}
  <div class="child">
    {foreach from=$category.child_categories item=child}
     {grn_bulletin_category_title script="javascript:on_change_category(`$child.cid`)" title=$child.title cid=$child.cid child=$child.num_children params=$params notified=$child.notified subscribed=$child.subscribed}
    {/foreach}
  </div>
   {else}
    {grn_bulletin_category_title script="javascript:on_change_category(`$node.cid`)" title=$node.title cid=$node.cid child=$node.num_children params=$params notified=$node.notified subscribed=$node.subscribed}
   {/if}
  {else}
   {if $node.cid == $set_category_id}
    {grn_bulletin_category_title script="javascript:on_change_category(`$node.cid`)" title=$node.title cid=$node.cid child=$node.num_children params=$params notified=$node.notified subscribed=$node.subscribed open=1 focus=1}
   {else}
    {grn_bulletin_category_title script="javascript:on_change_category(`$node.cid`)" title=$node.title cid=$node.cid child=$node.num_children params=$params notified=$node.notified subscribed=$node.subscribed}
   {/if}
  {/if}
 {/foreach}
 {if $category.path}
  </div>
 {/if}
 {foreach name=nloop from=$category.path item=node}
  {if ! $smarty.foreach.nloop.first}
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
