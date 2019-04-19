{assign var="form_name" value=$smarty.template|basename}
{include file='system/user/_organization_user_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_540'}{cb_msg module='grn.system.user' key='GRN_SY_US-540' replace='true'}{/capture}
{capture name='grn_system_user_GRN_SY_US_541'}{cb_msg module='grn.system.user' key='GRN_SY_US-541' replace='true'}{/capture}
{capture name='grn_system_user_GRN_SY_US_542'}{cb_msg module='grn.system.user' key='GRN_SY_US-542' replace='true'}{/capture}
{include file='grn/std_import1.tpl' config_id='system' cancel_page='system/user/org_import_index' post_page='system/user/command_organization_user_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_540|cat:"<p>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_541|cat:"<br>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_542}
