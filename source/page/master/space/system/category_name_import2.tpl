{include file='space/system/_category_name_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='space/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='space/system/category_name_import1' column_explanation=$smarty.capture.explanation}