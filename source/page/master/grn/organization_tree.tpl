{* select organization : begin *}
<table class="select_parts">
 <tr>
  <td nowrap>
{if $show_root}
 {if $organization.oid != 0}
  <div><a href="{grn_pageurl page=$page_info.all s_oid=0 params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1246' replace='true'}</a>&nbsp;</div>
 {else}
  <div id="focus"><a href="{grn_pageurl page=$page_info.all s_oid=0 params=$rest_params}">{grn_image image='organize20_co.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1247' replace='true'}</a>&nbsp;</div>
 {/if}
{/if}
{* show ancestors *}
{foreach from=$organization.ancestors item=ancestor}
 <div class="child">
 <div><a href="{grn_pageurl page=$page_info.all s_oid=$ancestor.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{$ancestor.title|escape}</a>&nbsp;</div>
{/foreach}
{if $organization.siblings}
 <div class="child">
 {foreach from=$organization.siblings item=sibling}
  {if $sibling.oid == $organization.oid}
 <div id="focus"><a name="#">{grn_image image='organize20_co.gif'}{$organization.title|escape}</a>&nbsp;</div>
   {if $organization.children}
 <div class="child">
    {foreach from=$organization.children item=child}
   <div><a href="{grn_pageurl page=$page_info.all s_oid=$child.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{$child.title|escape}</a>&nbsp;</div>
    {/foreach}
 </div>
   {/if}
  {else}
 <div><a href="{grn_pageurl page=$page_info.all s_oid=$sibling.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{$sibling.title|escape}</a>&nbsp;</div>
  {/if}
 {/foreach}
 </div>
{elseif $organization.oid}
 <div class="child">
 {if $organization.children}
 <div id='focus'><a href="{grn_pageurl page=$page_info.all s_oid=$organization.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{$organization.title|escape}</a>&nbsp;</div>
 <div class="child">
  {foreach from=$organization.children item=child}
   {if $child.children}
 <div><a href="{grn_pageurl page=$page_info.all s_oid=$child.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{$child.title|escape}</a>&nbsp;</div>
   {else}
 <div><a href="{grn_pageurl page=$page_info.all s_oid=$child.oid params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20.gif'}{$child.title|escape}</a>&nbsp;</div>
   {/if}
  {/foreach}
 </div>
 {/if}
{/if}
 {if $show_clear}
 <div class="child">
 <div>&nbsp;</div>
 <div><a href="{grn_pageurl page=$page_info.all s_oid=0 params=$rest_params no_multiple=$no_multiple}">{grn_image image='organize20_co.gif'}{cb_msg module='grn.common' key='title_clear_search'}</a>&nbsp;</div>
 {/if}

{foreach from=$organization.ancestors item=ancestor}
 </div>
{/foreach}
 <!-----><div class="br">&nbsp;</div>
</div>
  </td>
 </tr>
</table>
{* select organization : end *}
