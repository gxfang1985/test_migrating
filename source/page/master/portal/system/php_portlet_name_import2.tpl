{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-529' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-520' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-530' replace='true'}</div> 
{/capture}
{capture assign='cancel_button'}{grn_button_cancel page='portal/system/portlet_import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='portal/system/html_portlet_name_import1' column_explanation=$smarty.capture.explanation}
