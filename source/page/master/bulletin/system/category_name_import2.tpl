{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-45' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-174' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-46' replace='true'}</div> 
{/capture}
{capture assign='cancel_button'}{grn_button_cancel page='bulletin/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='bulletin/system/category_name_import1' column_explanation=$smarty.capture.explanation}
