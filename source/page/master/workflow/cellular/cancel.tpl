{include file="workflow/cellular/header.tpl"}
{strip}

{capture name=validate_message_emoji}{cb_msg module='grn.workflow.cellular' key="validate_message_emoji"}<br>{/capture}
{capture name=validate_message_length}{cb_msg module='grn.workflow.cellular' key="validate_message_length"}<br>{/capture}


{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}{$cancel_button|escape}<br>
<hr>

{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-63' replace='true'}
{grn_workflow_cellular_pictogram key="memo"}
No.{$petition.petition_number|escape}
&nbsp;{$petition.form_name|escape}({$petition.name|escape})
{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-64' replace='true'}
{$cancel_message|escape}
{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-65' replace='true'}<br>
{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-66' replace='true'}<br>

{grn_workflow_cellular_form name=$form_name method="post" page="$pagepath/command_cancel" fid=$fid pid=$pid}

{validate form=$form_name field="comment" criteria="grn_workflow_cellular_notEmoji" message=$smarty.capture.validate_message_emoji}
{validate form=$form_name field="comment" criteria="grn_workflow_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_length}

{/strip}
<textarea name="comment" cols=16 rows=3 istyle="1" mode="hiragana">{$comment|escape}</textarea>
{strip}
<br>

{grn_workflow_cellular_submit caption=$cancel_button}
</form>
<br>
{grn_workflow_cellular_link page="$pagepath/look" accesskey=2 fid=$fid pid=$pid caption_module='grn.workflow.cellular' caption_key="link_back"}<br>

<hr>

{grn_workflow_cellular_link page="$pagepath/list" accesskey=3 fid=$fid caption_module='grn.workflow.cellular' caption_key="list"}<br>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
