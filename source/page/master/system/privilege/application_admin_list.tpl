{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-25' replace='true'}
</div>

{capture name='grn_system_privilege_GRN_SY_PR_26'}{cb_msg module='grn.system.privilege' key='GRN_SY_PR-26' replace='true'}{/capture}{include file='grn/admin_list.tpl' page_dir='system/privilege' page_prefix='system/privilege/' base_prefix='application_' add_explanation=$smarty.capture.grn_system_privilege_GRN_SY_PR_26}

{include file="grn/system_footer.tpl"}
