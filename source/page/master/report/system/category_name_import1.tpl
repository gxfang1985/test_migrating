{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-354' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-565' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-355' replace='true'}</div> 
{/capture}

{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='report/system/import_index'}
