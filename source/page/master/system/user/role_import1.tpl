{assign var="form_name" value=$smarty.template|basename}
{include file='system/user/_role_csv_columns.tpl'}
{include file='grn/std_import1.tpl' config_id='system' cancel_page='system/user/org_import_index' post_page='system/user/command_role_import1' column_explanation=$smarty.capture.explanation}
