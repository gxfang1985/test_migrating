{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.portal.operation' key='GRN_POT_OP-215' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.portal.operation' key='GRN_POT_OP-216' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.portal.operation' key='GRN_POT_OP-217' replace='true'}</div> 
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='portal/operation/html_portlet_list'}
