{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.workflow' key='category_code' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-90' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.workflow' key='category_name' replace='true'}</div> 
{/capture}

{capture assign='cancel_button'}{grn_button_cancel page='workflow/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='workflow/system/category_name_import1' column_explanation=$smarty.capture.explanation}
