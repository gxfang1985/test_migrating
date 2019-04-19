{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-273' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-568' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-404' replace='true'}</div> 
{/capture}
{include file='grn/std_import2.tpl' prev_page='schedule/system/facilitygroup_name_import1' column_explanation=$smarty.capture.explanation}
