{include file='cabinet/system/_notify_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='cabinet/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' column_explanation=$smarty.capture.explanation prev_page='cabinet/system/notify_import1'}
