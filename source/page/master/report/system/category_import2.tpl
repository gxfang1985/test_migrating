{include file='report/_category_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='report/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='report/system/category_import1' column_explanation=$smarty.capture.explanation}
