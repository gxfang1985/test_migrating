<!--category_path-->
<div id="path_part">
 <table><tbody><tr>
  <td width="100%">
{if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
{if $category_id == -1}
 {if $mid}
 {grn_image image='category_trush20.gif'}{capture name='grn_report_GRN_RPRT_325'}{cb_msg module='grn.report' key='GRN_RPRT-325' replace='true'}{/capture}{grn_link page=$category_page cid=1 mid=$mid caption=$smarty.capture.grn_report_GRN_RPRT_325} &gt; {cb_msg module='grn.report' key='GRN_RPRT-326' replace='true'}
 {else}
 {grn_image image='category_trush20.gif'}{capture name='grn_report_GRN_RPRT_327'}{cb_msg module='grn.report' key='GRN_RPRT-327' replace='true'}{/capture}{grn_link page=$category_page cid=1 caption=$smarty.capture.grn_report_GRN_RPRT_327} &gt; {cb_msg module='grn.report' key='GRN_RPRT-328' replace='true'}
 {/if}
{else}
 {foreach name=path from=$category.ancestors item=item}
 {if $smarty.foreach.path.iteration == 1}
  {if $disable_link}
  {if $mid}
   {grn_link page=$category_page image='category20.gif' cid=$item.cid mid=$mid caption=$item.name disabled=true} &gt;
  {else}
   {grn_link page=$category_page image='category20.gif' cid=$item.cid aption=$item.name disabled=true} &gt;
  {/if} 
  {else}
  {if $mid}
   {grn_link page=$category_page image='category20.gif' cid=$item.cid mid=$mid caption=$item.name} &gt;
  {else}
   {grn_link page=$category_page image='category20.gif' cid=$item.cid caption=$item.name} &gt;
  {/if}
  {/if}
 {else}
  {if $disable_link}
  {if $mid}
   {grn_link page=$category_page cid=$item.cid mid=$mid caption=$item.name disabled=true} &gt;
  {else}
   {grn_link page=$category_page cid=$item.cid caption=$item.name disabled=true} &gt;
  {/if} 
  {else}
  {if $mid}
   {grn_link page=$category_page cid=$item.cid mid=$mid caption=$item.name} &gt;
  {else}
   {grn_link page=$category_page cid=$item.cid caption=$item.name} &gt;
  {/if} 
  {/if}
 {/if}
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image='category20.gif'}{/if}{$category.name|escape}
{/if}
 </td>
{if ! $no_search}
 <td align="right" nowrap>
 {if ! $search_action}{assign var='search_action' value=$page_info.all}{/if}
 {if ! $search_page}{assign var='search_page' value=$search_action}{/if}
 {capture name='grn_report_GRN_RPRT_324'}{cb_msg module='grn.report' key='GRN_RPRT-324' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_report_GRN_RPRT_324 name='text' action=$search_action page=$search_page cid=$category_id|escape fid=$form_id|escape init=1 disabled=$search_disabled}
 </td>
{/if}
 </tr></tbody></table>
</div>
<!--category_path_end-->
