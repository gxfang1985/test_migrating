{include file="report/cellular/header.tpl"}
{strip}

{grn_report_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>
{cb_msg module='grn.report.cellular' key="reverse_triangle"}
{$item.display_name|escape}<br>
<hr>

{grn_report_cellular_string_split string=$view_str page_paraname="bp"}<br>

<br>
{grn_report_cellular_link page="$pagepath/look" accesskey=2 type=$type rid=$rid caption_module='grn.report.cellular' caption_key="link_back"}<br>

<hr>
{grn_report_cellular_link page="$pagepath/list" accesskey=3 type=$type caption_module='grn.report.cellular' caption_key="list"}<br>
{grn_report_cellular_link page="$pagepath/search" accesskey=4 type=$type caption_module='grn.report.cellular' caption_key="search"}<br>

{/strip}
{include file="report/cellular/footer.tpl"}
