{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-501' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-502' replace='true'}</div>
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-503' replace='true'}</div>
{if $mode == 'export' }
   <div><span class="bold">4.</span>&nbsp;...</div>
{else}
   <div><span class="bold">4.</span>&nbsp;...<span class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-504' replace='true'}</span></div>
{/if}
{/capture}
