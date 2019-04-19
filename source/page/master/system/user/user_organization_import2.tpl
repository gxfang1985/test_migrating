{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_user_organization_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_54'}{cb_msg module='grn.system.user' key='GRN_SY_US-54' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_55'}{cb_msg module='grn.system.user' key='GRN_SY_US-55' replace='true'}{/capture}{capture name='grn_system_user_GRN_SY_US_56'}{cb_msg module='grn.system.user' key='GRN_SY_US-56' replace='true'}{/capture}{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/user_organization_import1' post_page='system/user/command_user_organization_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_54|cat:"<p>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_55|cat:"<br>"|cat:$smarty.capture.grn_system_user_GRN_SY_US_56 continue_column=9}
