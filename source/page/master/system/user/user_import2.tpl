{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_user_csv_columns.tpl'}
{capture name='grn_system_user_GRN_SY_US_146'}{cb_msg module='grn.system.user' key='GRN_SY_US-146' replace='true'}{/capture}{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/user_import1' post_page='system/user/command_user_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.grn_system_user_GRN_SY_US_146}
