<!--category_path-->
<div id="path_part">
 <table><tbody><tr>
  <td width="100%">
{if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
 {foreach name=path from=$category.ancestors item=item}
 {capture name="category_name"}{$item.name|grn_noescape}{/capture}
  {if $smarty.foreach.path.iteration == 1}
   {if $disable_link}
    {grn_link page=$category_page image='category20.gif' cid=$item.cid sf=1 caption=$smarty.capture.category_name disabled=true} &gt; 
   {else}
    {grn_link page=$category_page image='category20.gif' cid=$item.cid sf=1 caption=$smarty.capture.category_name} &gt; 
   {/if}
  {else}
   {if $disable_link}
    {grn_link page=$category_page cid=$item.cid caption=$smarty.capture.category_name disabled=true} &gt; 
   {else}
    {grn_link page=$category_page cid=$item.cid caption=$smarty.capture.category_name} &gt; 
   {/if}
  {/if}
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image='category20.gif'}{/if} {capture name="category_name"}{$category.name|grn_noescape}{/capture}{$smarty.capture.category_name|escape}
 {if $category.notified || $category.subscribed}{grn_image image='subscribe20.png'}{/if}
 </td>
{if ! $no_search}
 <td align="right" nowrap>
 {if ! $search_action}{assign var='search_action' value=$page_info.all}{/if}
 {if ! $search_page}{assign var='search_page' value=$search_action}{/if}
 {capture name='grn_bulletin_GRN_BLLT_201'}{cb_msg module='grn.bulletin' key='GRN_BLLT-201' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_201 name='text' action=$search_action page=$search_page cid=$category.cid scid=$category.cid}
 </td>
{/if}
 </tr></tbody></table>
</div>
<!--category_path_end-->
