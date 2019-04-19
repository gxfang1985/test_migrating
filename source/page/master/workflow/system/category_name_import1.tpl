{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.workflow' key='category_code' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-90' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.workflow' key='category_name' replace='true'}</div> 
{/capture}

{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='workflow/system/import_index'}
