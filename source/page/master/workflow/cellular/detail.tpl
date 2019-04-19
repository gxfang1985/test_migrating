{include file="workflow/cellular/header.tpl"}
{strip}

{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>
{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}
{$item.display_name|escape}<br>
<hr>

{grn_workflow_cellular_string_split string=$view_str page_paraname="bp"}<br>

<br>
{grn_workflow_cellular_link page="$pagepath/look" accesskey=2 fid=$fid pid=$pid caption_module='grn.workflow.cellular' caption_key="link_back"}<br>

<hr>
{grn_workflow_cellular_link page="$pagepath/list" accesskey=3 fid=$fid caption_module='grn.workflow.cellular' caption_key="list"}<br>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
