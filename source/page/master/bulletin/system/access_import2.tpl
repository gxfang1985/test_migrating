{include file='bulletin/system/_access_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='bulletin/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='bulletin/system/access_import1' column_explanation=$smarty.capture.explanation}
