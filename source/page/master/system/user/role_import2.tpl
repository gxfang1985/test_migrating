{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_role_csv_columns.tpl'}
{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/role_import1' post_page='system/user/command_role_import2' column_explanation=$smarty.capture.explanation}

