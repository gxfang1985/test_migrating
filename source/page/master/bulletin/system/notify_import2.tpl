{include file='bulletin/system/_notify_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='bulletin/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='bulletin/system/notify_import1' column_explanation=$smarty.capture.explanation}