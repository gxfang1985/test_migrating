{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/common_list" id='filemanager'}
{/capture}
{include file='system/filemanager/_mime_csv_columns.tpl'}
{include file='grn/std_import1.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button post_page='system/filemanager/command_mime_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
