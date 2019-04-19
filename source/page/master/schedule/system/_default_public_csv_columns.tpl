{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-664' replace='true'}</div>
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-665' replace='true'}</div>
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-666' replace='true'}</div>
   <div><span class="bold">4.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-667' replace='true'}</div>
   {if $type == 'export' }
      <div><span class="bold">5.</span>&nbsp;...</div>
   {else}
      <div><span class="bold">5.</span>&nbsp;...<span class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-668' replace='true'}</span></div>
   {/if}
{/capture}
