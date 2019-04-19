<!--folder_path-->
<div id="path_part">
{if ! $folder_page}{assign var='folder_page' value=$page_info.all}{/if}

 {foreach name=path from=$folder.ancestors item=item}
{capture name="category_name"}{$item.name|grn_noescape}{/capture}
  {if $smarty.foreach.path.iteration == 1}
  {grn_link page=$folder_page image='folder20.gif' hid=$item.hid sf=1 caption=$smarty.capture.category_name} &gt; 
  {else}
  {grn_link page=$folder_page hid=$item.hid caption=$smarty.capture.category_name} &gt; 
  {/if}
 {/foreach}

 {if $smarty.foreach.path.total < 1}{grn_image image='folder20.gif'}{/if}
{capture name="category_name"}{$folder.name|grn_noescape}{/capture}
 {if $trashbox == ""}
  {$smarty.capture.category_name|escape}
 {else}
  {grn_link page=$folder_page hid=$folder.hid caption=$smarty.capture.category_name} &gt; {cb_msg module='grn.cabinet' key='GRN_CAB-275' replace='true'}
 {/if}
 {if $folder.notified || $folder.subscribed}{grn_image image='subscribe20.png'}{/if}
</div>
<!--folder_path_end-->
