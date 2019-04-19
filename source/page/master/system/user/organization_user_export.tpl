{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last postfix='ounit_users.csv'}">
{include file='system/user/_export.tpl'}
</form>

<hr>
<p>
{assign var='mode' value='export'}
{include file='system/user/_organization_user_csv_columns.tpl' mode=$mode}
{capture name='grn_system_user_GRN_SY_US_224'}{cb_msg module='grn.system.user' key='GRN_SY_US-224' replace='true'}{/capture}{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export' sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_224}
{include file="grn/system_footer.tpl"}
