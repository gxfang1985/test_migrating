{grn_load_javascript file="grn/html/page/schedule/adjust_link.js"}
{** -------------- upd VCBSCH0010 START ----------------- **}
{if $before_delete_adjust}
 {grn_delete title=$before_delete_adjust.title page=$before_delete_adjust.page no_confirm=$before_delete_adjust.no_confirm data=$before_delete_adjust.data handler=$before_delete_adjust.handler2 before_delete=$before_delete_adjust.before_delete}
<div class="adjust_link">{cb_msg module='grn.schedule' key='GRN_SCH-815' replace='true'}&nbsp;<span id="link2-adjust-schedule"><a id='schedule/unadjust_search' href="javascript:void(0)">{cb_msg module='grn.schedule' key='GRN_SCH-816' replace='true'}</a></span></div>
{else}
<div class="adjust_link">{cb_msg module='grn.schedule' key='GRN_SCH-815' replace='true'}<span class="nowrap-grn mLeft15">
<a class="icon-advance-grn" href="javascript:grn.page.schedule.adjust_link.adjust_submit('{$form_name}', '{grn_pageurl page='schedule/adjust_search'}' )">{cb_msg module='grn.schedule' key='GRN_SCH-816' replace='true'}</a>
</span>
{/if}
{** -------------- upd VCBSCH0010 END   ----------------- **}
