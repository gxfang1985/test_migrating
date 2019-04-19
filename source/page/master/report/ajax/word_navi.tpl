{if $navi.previous_page_start_position != -1}
 <a href="javascript:;" onclick="{$callback_func}(0);">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-9' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-10' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="javascript:;" onclick="{$callback_func}({$navi.previous_page_start_position});">&lt;&lt;{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-11' replace='true'} {$navi.number_on_page} {cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-12' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-13' replace='true'} {$navi.number_on_page} {cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-14' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="javascript:;" onclick="{$callback_func}({$navi.next_page_start_position});">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-15' replace='true'} {$navi.number_on_page} {cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-16' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-17' replace='true'} {$navi.number_on_page} {cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-18' replace='true'}&gt;&gt;</span>
{/if}

