{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_role_user_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_312'}{cb_msg module='grn.system.user' key='GRN_SY_US-312' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_313'}{cb_msg module='grn.system.user' key='GRN_SY_US-313' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_314'}{cb_msg module='grn.system.user' key='GRN_SY_US-314' replace='true'}{/capture}{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/role_user_import1' post_page='system/user/command_role_user_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_312|cat:"<p>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_313|cat:"<br>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_314 continue_column=9}
