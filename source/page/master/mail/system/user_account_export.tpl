{include file='mail/system/_user_account_csv_columns.tpl'}
{include file='grn/std_export.tpl' config_id='system' form_name=$page_info.all post_page='mail/system/command_user_account_export' postfix='user_account.csv' column_explanation=$smarty.capture.explanation}
