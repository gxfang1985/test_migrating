{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_workflow_system_w_read_category'}{cb_msg module='grn.workflow.system' key='w_read_category' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/category_import1' caption=$smarty.capture.grn_workflow_system_w_read_category}
<li>{capture name='grn_workflow_system_category_name_import1'}{cb_msg module='grn.workflow.system' key='category_name_import1' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/category_name_import1' caption=$smarty.capture.grn_workflow_system_category_name_import1}
<li>{capture name='grn_workflow_system_access_import1'}{cb_msg module='grn.workflow.system' key='access_import1' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/access_import1' caption=$smarty.capture.grn_workflow_system_access_import1}
<li>{capture name='grn_workflow_system_agent_petition_import1'}{cb_msg module='grn.workflow.system' key='agent_petition_import1' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/agent_petition_import1' caption=$smarty.capture.grn_workflow_system_agent_petition_import1}
<li>{capture name='grn_workflow_system_w_import_substitute_approver_y'}{cb_msg module='grn.workflow.system' key='w_import_substitute_approver_y' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/agent_approval_import1' caption=$smarty.capture.grn_workflow_system_w_import_substitute_approver_y}
</ul>

{include file='grn/system_footer.tpl'}
