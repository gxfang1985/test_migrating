<table class="select_parts">
 <tr>
  <td nowrap>
<div class="search_navi">{grn_text name='search' size='20' value=''}&nbsp;{capture name='grn_grn_GRN_GRN_1'}{cb_msg module='grn.grn' key='GRN_GRN-1' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_1}</div>
<div id="tree_structure">
 <div class="items">
  <div class="parent">
<hr>

{if $show_root}
 {if $parent_organization_id == 0}
 <div id="focus"><a name="#">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-2' replace='true'}</a>&nbsp;</div>
 {else}
  <div>{capture name='grn_grn_GRN_GRN_3'}{cb_msg module='grn.grn' key='GRN_GRN-3' replace='true'}{/capture}{grn_structure_link script="javascript:on_change_organization(0)" caption=$smarty.capture.grn_grn_GRN_GRN_3 class='organize20_co'}</div>
 {/if}
{/if}

{foreach from=$organization.ancestors item=ancestor}
 <div class="child">
 <div>{grn_structure_link script="javascript:on_change_organization(`$ancestor.oid`)" caption=$ancestor.title|escape class='organize20_co' focus=$focus}</div>
{/foreach}

{if $organization.siblings}
 <div class="child">
 {foreach from=$organization.siblings item=sibling}
  {if $sibling.oid == $organization.oid}
   {* 選択している組織 *}
 <div id="focus"><a name="#">{grn_image image='organize20_co.gif'}{$organization.title|escape}</a>&nbsp;</div>
   {* 選択している組織の子組織 *}
   {if $organization.children}
 <div class="child">
    {foreach from=$organization.children item=child}
     {if $child.oid != $organization_id}
   <div>{grn_structure_link script="javascript:on_change_organization(`$child.oid`)" caption=$child.title|escape class='organize20_co'}</div>
     {/if}
    {/foreach}
 </div>
   {/if}
  {else}
   {* 選択されていない兄弟組織 *}
   {if $sibling.oid != $organization_id}
 <div>{grn_structure_link script="javascript:on_change_organization(`$sibling.oid`)" caption=$sibling.title|escape class='organize20_co'}</div>
   {/if}
  {/if}
 {/foreach}
 </div>
{elseif $organization.oid}
 <div class="child">
 {if $organization.children}
 <div>{grn_structure_link script="javascript:on_change_organization(`$organization.oid`)" caption=organization.title|escape class='organize20_co'}</div>
 <div class="child">
  {foreach from=$organization.children item=child}
   {if $child.children}
 <div>{grn_structure_link script="javascript:on_change_organization(`$child.oid`)" caption=child.title|escape class='organize20_co'}</div>
   {else}
 <div>{grn_structure_link script="javascript:on_change_organization(`$child.oid`)" caption=child.title|escape class='organize20'}</div>
   {/if}
  {/foreach}
 </div>
 {else}
 <div>{grn_structure_link script="javascript:on_change_organization(`$organization.oid`)" caption=$organization.title|escape class='organize20' focus=true}</div>
 {/if}
{/if}

{foreach from=$organization.ancestors item=ancestor}
 </div>
{/foreach}

{****************************************************************
  <div><a href="#">{grn_image image='organize20_co.gif'}本社</a>&nbsp;</div>
   <div class="child">
   <div id="focus"><a name="#">{grn_image image='organize20_co.gif'}開発部</a>&nbsp;</div>
     <div class="child">
       <div><a href="#">{grn_image image='organize20.gif'}PG</a>&nbsp;</div>
     </div>
       <div><a href="#">{grn_image image='organize20.gif'}営業部</a>&nbsp;</div>
         <div><a href="#">{grn_image image='organize20_c.gif'}まーけ</a>&nbsp;</div>
      </div>
  </div>
 </div>
 ****************************************************************}
 <!-----><div class="br">&nbsp;</div>
</div>
  </td>
 </tr>
</table>
