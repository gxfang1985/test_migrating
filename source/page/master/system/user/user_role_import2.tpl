{assign var="form_name" value=$smarty.template|basename}
{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_user_role_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_112'}{cb_msg module='grn.system.user' key='GRN_SY_US-112' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_113'}{cb_msg module='grn.system.user' key='GRN_SY_US-113' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_114'}{cb_msg module='grn.system.user' key='GRN_SY_US-114' replace='true'}{/capture}{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/user_role_import1' post_page='system/user/command_user_role_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_112|cat:"<p>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_113|cat:"<br>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_114}
