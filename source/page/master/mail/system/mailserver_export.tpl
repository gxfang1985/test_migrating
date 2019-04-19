{include file='mail/system/_mailserver_csv_columns.tpl'}
{include file='grn/std_export.tpl' config_id='system' form_name=$page_info.all post_page='mail/system/command_mailserver_export' postfix='mailserver.csv' column_explanation=$smarty.capture.explanation}
