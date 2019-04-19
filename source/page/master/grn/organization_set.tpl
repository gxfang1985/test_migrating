<table class="select_parts">
 <tr>
  <td nowrap>
<div class="search_navi">{grn_text name='search' size='20' value=''}&nbsp;{capture name='grn_grn_GRN_GRN_432'}{cb_msg module='grn.grn' key='GRN_GRN-432' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_432}</div>
<div id="tree_structure">
 <div class="items">
  <div class="parent">
<hr>

{if $show_root}
 {if $organization.oid != 0}
  <div><a href="{cb_pageurl page=$page_info.all oid=0}">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-433' replace='true'}</a>&nbsp;</div>
 {else}
  <div id="focus"><a href="{cb_pageurl page=$page_info.all oid=0}">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-434' replace='true'}</a>&nbsp;</div>
 {/if}
{/if}

{foreach from=$organization.ancestors item=ancestor}
 <div class="child">
 <div><a href="{cb_pageurl page=$page_info.all oid=$ancestor.oid}">{grn_image image='organize20_co.gif'}{$ancestor.title}</a>&nbsp;</div>
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
   <div><a href="{cb_pageurl page=$page_info.all oid=$child.oid}">{grn_image image='organize20_co.gif'}{$child.title|escape}</a>&nbsp;</div>
    {/foreach}
 </div>
   {/if}
  {else}
   {* 選択されていない兄弟組織 *}
 <div><a href="{cb_pageurl page=$page_info.all oid=$sibling.oid}">{grn_image image='organize20_co.gif'}{$sibling.title|escape}</a>&nbsp;</div>
  {/if}
 {/foreach}
 </div>
{elseif $organization.oid}
 <div class="child">
 {if $organization.children}
 <div id='focus'><a href="{cb_pageurl page=$page_info.all oid=$organization.oid}">{grn_image image='organize20_co.gif'}{$organization.title|escape}</a>&nbsp;</div>
 <div class="child">
  {foreach from=$organization.children item=child}
   {if $child.children}
 <div><a href="{cb_pageurl page=$page_info.all oid=$child.oid}">{grn_image image='organize20_co'.gif}{$child.title|escape}</a>&nbsp;</div>
   {else}
 <div><a href="{cb_pageurl page=$page_info.all oid=$child.oid}">{grn_image image='organize20.gif'}{$child.title|escape}</a>&nbsp;</div>
   {/if}
  {/foreach}
 </div>
 {else}
 <div id='focus'><a href="{cb_pageurl page=$page_info.all oid=$organization.oid}">{grn_image image='organize20.gif'}{$organization.title|escape}</a>&nbsp;</div>
 {/if}
{/if}

{foreach from=$organization.ancestors item=ancestor}
 </div>
{/foreach}

{****************************************************************
  <div><a href="#">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-435' replace='true'}</a>&nbsp;</div>
   <div class="child">
   <div id="focus"><a name="#">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-436' replace='true'}</a>&nbsp;</div>
     <div class="child">
       <div><a href="#">{grn_image image='organize20.gif'}PG</a>&nbsp;</div>
     </div>
       <div><a href="#">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-437' replace='true'}</a>&nbsp;</div>
         <div><a href="#">{grn_image image='organize20_c.gif'}{cb_msg module='grn.grn' key='GRN_GRN-438' replace='true'}</a>&nbsp;</div>
      </div>
  </div>
 </div>
 ****************************************************************}
 <!-----><div class="br">&nbsp;</div>
</div>
  </td>
 </tr>
</table>
