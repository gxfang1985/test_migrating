{include file='system/calendar/import/_base_name_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='system/calendar/import/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='system/calendar/import/import_base_name1' column_explanation=$smarty.capture.explanation}
