{include file='rss/system/_csv_columns.tpl'}
{include file='grn/std_export.tpl' config_id='system' app_id='rss' post_page='rss/system/command_export' postfix='rss.csv' column_explanation=$smarty.capture.explanation}
