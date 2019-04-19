{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-519' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-520' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-521' replace='true'}</div> 
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='portal/system/portlet_import_index'}
