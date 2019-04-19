{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.workflow.system' key='w_select_category_for_setting_operations_management' replace='true'}
</div>

<p>
{capture name='grn_workflow_system_category_sub_title'}{if $is_root}{cb_msg module='grn.workflow.system' key='category_sub_title_1' replace='true'}{else}{cb_msg module='grn.workflow.system' key='category_sub_title_2' replace='true'}{/if}{/capture}
{capture name='grn_workflow_system_category_name'}{cb_msg module='grn.workflow.system' key='category_name' replace='true'}{/capture}{capture name='grn_workflow_system_category_csv_code'}{cb_msg module='grn.workflow.system' key='category_csv_code' replace='true'}{/capture}{capture name='grn_workflow_system_category_csv_name'}{cb_msg module='grn.workflow.system' key='category_csv_name' replace='true'}{/capture}{include file='grn/tree_privilege_index.tpl' node_name=$smarty.capture.grn_workflow_system_category_name node_image='category20.gif' prop_name=$smarty.capture.grn_workflow_system_category_csv_name prop_code=$smarty.capture.grn_workflow_system_category_csv_code page_prefix='workflow/system/' no_virtual_root=1 node_sub_title=$smarty.capture.grn_workflow_system_category_sub_title}

{include file="grn/system_footer.tpl"}
