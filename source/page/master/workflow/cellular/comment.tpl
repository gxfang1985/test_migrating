{include file="workflow/cellular/header.tpl"}
{strip}

{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-67' replace='true'}<br>
&nbsp;&nbsp;
{$path_step.col_role|escape}<br>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-68' replace='true'}<br>
&nbsp;&nbsp;
{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-69' replace='true'}
{else}
    {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
{/if}
<br>

<hr>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-70' replace='true'}<br>

{grn_workflow_cellular_pictogram key="person"}
{$path_step_user_name|escape}<br>
<!-- {$path_step_user.col_current_display_name|escape}<br> -->

{grn_workflow_cellular_string_split string=$comment page_paraname="bp"}<br>

<br>
{grn_workflow_cellular_link page="$pagepath/status" accesskey=2 fid=$fid pid=$pid psid=$psid caption_module='grn.workflow.cellular' caption_key="link_back"}<br>

<hr>
{grn_workflow_cellular_link page="$pagepath/list" accesskey=3 fid=$fid caption_module='grn.workflow.cellular' caption_key="list"}<br>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
