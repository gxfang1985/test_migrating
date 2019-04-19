{include file='address/_csv_columns.tpl'}
{include file='grn/std_export.tpl' post_page='address/operation/command_export' postfix=$form.hiddens.filename column_explanation=$smarty.capture.explanation}
