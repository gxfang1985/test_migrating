{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_workflow_system_category_export'}{cb_msg module='grn.workflow.system' key='category_export' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/category_export' caption=$smarty.capture.grn_workflow_system_category_export}
<li>{capture name='grn_workflow_system_category_name_export'}{cb_msg module='grn.workflow.system' key='category_name_export' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/category_name_export' caption=$smarty.capture.grn_workflow_system_category_name_export}
<li>{capture name='grn_workflow_system_access_export'}{cb_msg module='grn.workflow.system' key='access_export' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/access_export' caption=$smarty.capture.grn_workflow_system_access_export}
<li>{capture name='grn_workflow_system_agent_petition_export'}{cb_msg module='grn.workflow.system' key='agent_petition_export' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/agent_petition_export' caption=$smarty.capture.grn_workflow_system_agent_petition_export}
<li>{capture name='grn_workflow_system_agent_approval_export'}{cb_msg module='grn.workflow.system' key='agent_approval_export' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/agent_approval_export' caption=$smarty.capture.grn_workflow_system_agent_approval_export}
</ul>

{include file="grn/system_footer.tpl"}
