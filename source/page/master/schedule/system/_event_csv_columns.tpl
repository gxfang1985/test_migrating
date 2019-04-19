{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-83' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-84' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-85' replace='true'}</div> 
   <div><span class="bold">4.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-86' replace='true'}</div> 
   <div><span class="bold">5.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-87' replace='true'}</div> 
   <div><span class="bold">6.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-88' replace='true'}</div> 
   <div><span class="bold">7.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-89' replace='true'}</div> 
   <div><span class="bold">8.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-90' replace='true'}</div> 
   <div><span class="bold">9.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-91' replace='true'}</div>
{counter name='item_number' start=9 print=false}
{foreach from=$items key=item_id item=item}
    {if $item.use}
   <div><span class="bold">{counter name='item_number'}.</span>&nbsp;{$item.display_name}</div> 
    {/if}
{/foreach}
{/capture}
