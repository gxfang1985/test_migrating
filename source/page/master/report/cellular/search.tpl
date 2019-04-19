{include file="report/cellular/header.tpl"}
{strip}

{grn_report_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{grn_report_cellular_form name="form" method="get" page="$pagepath/search"}
{grn_select name="type" options=$target_list}<br>
<input type="text" name="text" value="{$text|escape}" istyle="1" mode="hiragana"><br>
{grn_report_cellular_submit name="GO" accesskey="1" caption_module='grn.report.cellular' caption_key="submit_search"}<br>
</form>
<br>

{if $reports}
    {foreach from=$reports key=rid item=report}
        {grn_report_cellular_pictogram key="memo"}
        {grn_report_cellular_link page="report/cellular/look" rid=$rid type=$type caption=$report.col_name|grn_report_cellular_truncate:$width}<br>
        {$report.col_form_name|grn_report_cellular_truncate:$width|escape}<br>
        {cb_date_format format='DateTimeCompact' date=$report.mtime}&nbsp;{$report.col_creator_name|escape}<br>
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/search" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="previous_list"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/search" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="next_list"}</a>
    {/if}
{/if}

<hr>
{grn_report_cellular_link page="$pagepath/list" accesskey=3 type=$type caption_module='grn.report.cellular' caption_key="list"}<br>

{/strip}
{include file="report/cellular/footer.tpl"}
