{include file='workflow/_agent_approval_csv_columns.tpl'}
{capture assign='cancel_button'}{grn_button_cancel page='workflow/system/import_index'}{/capture}
{include file='grn/std_import2.tpl' prev_page='workflow/system/agent_approval_import1' column_explanation=$smarty.capture.explanation}
