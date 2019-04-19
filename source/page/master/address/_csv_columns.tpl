{capture name='explanation'}
 {if 'access' == $csv_type}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-188' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-189' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-190' replace='true'}</div> 
   <div><span class="bold">4.</span>&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-191' replace='true'}</div> 
 {else}
  {foreach name='builtin_item' from=$builtin_items item='builtin_item'}
   <div style="width:{$max_length}em;"><span class="bold">{$smarty.foreach.builtin_item.iteration}.</span>&nbsp;{$builtin_item.display_name|escape}</div> 
  {/foreach}
  {foreach name='extended_item' from=$extended_items item='extended_item'}
   <div style="width:{$max_length}em;"><span class="bold">{$smarty.foreach.builtin_item.iteration+$smarty.foreach.extended_item.iteration}.</span>&nbsp;{$extended_item.display_name|escape}</div> 
  {/foreach}
 {/if}
{/capture}
