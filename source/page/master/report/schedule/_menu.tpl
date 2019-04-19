{strip}
<span class="menu_item">
   {grn_image inline=TRUE image='report20.gif'}
   {if !$isReportWritable || $schedule_event.type == 'share_temporary' || $schedule_event.type == 'temporary'}
   {cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-24' replace='true'}
   {else}
   <a href="javascript:;" onclick="showFormSelectWindow();">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-25' replace='true'}</a>
   {/if}
</span>
{/strip}
<span class="menu_item">
   {grn_image inline=TRUE image='reportrelation20.gif'}
   {if !$isReportWritable || $schedule_event.type == 'share_temporary' || $schedule_event.type == 'temporary'}
      {cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-26' replace='true'}
   {else}
      <a href="javascript:;" onclick="showReportRelationWindow(0);">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-27' replace='true'}</a>
   {/if}
</span>