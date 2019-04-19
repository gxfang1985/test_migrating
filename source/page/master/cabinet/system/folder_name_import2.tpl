{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-82' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-94' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-83' replace='true'}</div> 
{/capture}
{capture assign='cancel_button'}{grn_button_cancel page='cabinet/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' column_explanation=$smarty.capture.explanation prev_page='cabinet/system/folder_name_import1'}
