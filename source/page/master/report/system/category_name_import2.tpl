{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-354' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-565' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-355' replace='true'}</div> 
{/capture}

{capture assign='cancel_button'}{grn_button_cancel page='report/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='report/system/category_name_import1' column_explanation=$smarty.capture.explanation}
