{include file='mail/system/_mail_limit_csv_info.tpl'}
{include file='mail/system/_mail_limit_csv_columns.tpl'}
{include file='grn/std_import1.tpl' config_id='system' form_name=$page_info.all post_page='mail/system/command_mail_limit_import1' cancel_page='mail/system/import_index' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}