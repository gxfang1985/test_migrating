{include file="cellular/header.tpl"}
{strip}

{grn_report_cellular_appname app_id='report'}<br>
{$pagetitle|escape}<br>
<hr>

<br>
{cb_msg module='grn.report.cellular' key="txt_delete_follow"}<br>
{cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-1' replace='true'}{$follow.data|grn_report_cellular_truncate:100|escape}{cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-2' replace='true'}<br>

{grn_report_cellular_form name='command_delete' method=post page="$pagepath/command_delete" rid=$rid follow_id=$follow_id type=$type}

{grn_report_cellular_submit accesskey=1 caption_module='grn.report.cellular' caption_key="submit_delete"}
</form>

<hr>
{grn_report_cellular_link page="$pagepath/look" rid="$rid" follow_id="$follow_id" type=$type caption_module='grn.report.cellular' caption_key="look"}<br>
{grn_report_cellular_link page="$pagepath/list" accesskey=3 type=$type caption_module='grn.report.cellular' caption_key="list"}<br>
{grn_report_cellular_link page="$pagepath/search" accesskey=4 type=$type caption_module='grn.report.cellular' caption_key="search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
