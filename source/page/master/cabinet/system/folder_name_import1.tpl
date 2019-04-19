{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-82' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-94' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-83' replace='true'}</div> 
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation cancel_page='cabinet/system/import_index'}
