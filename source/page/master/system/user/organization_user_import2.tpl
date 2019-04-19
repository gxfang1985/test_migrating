{assign var="form_name" value=$smarty.template|basename}
{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_organization_user_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_207'}{cb_msg module='grn.system.user' key='GRN_SY_US-207' replace='true'}{/capture}{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/organization_user_import1' post_page='system/user/command_organization_user_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_207 continue_column=9}
