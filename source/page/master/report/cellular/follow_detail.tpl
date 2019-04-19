{include file="cellular/header.tpl"}
{strip}

{grn_report_cellular_appname app_id="report"}<br>
{cb_msg module='grn.report.cellular' key='follow_detail'}<br>
<hr>

{if $report.enable_follow}
    {grn_report_cellular_link page="$pagepath/follow" rid="$rid" type="$type" accesskey="1" caption_module='grn.report.cellular' caption_key="link_follow"}<br>
{/if}
{grn_report_cellular_pictogram key="memo"}{$report.form_name|escape}({$report.name|escape})<br>
<hr>

{grn_report_cellular_pictogram key="clock"}
{cb_date_format format='DateTimeShort_YMD_HM' date=$follow.ctime}<br>
{$follow.follow_id}{cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-12' replace='true'}{grn_report_cellular_pictogram key="person"}
{$follow.creator_name|escape}<br>

{grn_report_cellular_pictogram key="follow"}
{grn_report_cellular_string_split string=$follow.data page_paraname="pg"}
<br>

{if count($follow.attach_files)}
    <br>
    [{grn_report_cellular_pictogram key="clip"}{cb_msg module='grn.report.cellular' key="txt_attach_file"}]<br>
{/if}

{if $prev || $next}
    <br>
    {if $prev}
        {grn_report_cellular_link page="$pagepath/follow_detail" follow_id=$prev rid=$rid type=$type caption_module='grn.cellular.common' caption_key="link_back"}
        &nbsp;
    {/if}
    {if $next}
        {grn_report_cellular_link page="$pagepath/follow_detail" follow_id=$next rid=$rid type=$type caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

<hr>

{grn_report_cellular_link page="$pagepath/look" rid=$rid type=$type caption_module='grn.report.cellular' caption_key="look"}<br>

{grn_report_cellular_link page="$pagepath/list" type=$type accesskey="3" caption_module='grn.report.cellular' caption_key="list"}<br>
{grn_report_cellular_link page="$pagepath/search" accesskey="4" caption_module='grn.report.cellular' caption_key="search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
