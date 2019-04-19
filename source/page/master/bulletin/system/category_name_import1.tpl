{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-45' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-174' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-46' replace='true'}</div> 
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='bulletin/system/import_index'}
