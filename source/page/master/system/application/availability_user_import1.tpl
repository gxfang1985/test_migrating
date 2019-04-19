{assign var="form_name" value=$smarty.template|basename}
{include file='system/application/_availability_user_csv_columns.tpl'}
{include file='grn/std_import1.tpl' config_id='system' app_id='application' post_page='system/application/command_availability_user_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation cancel_page='system/common_list' id='application'}
