{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/common_list" id='filemanager'}
{/capture}
{include file='system/filemanager/_mime_csv_columns.tpl'}
{include file='grn/std_import2.tpl' cancel_button=$smarty.capture.cancel_button prev_page='system/filemanager/mime_import1' post_page='system/filemanager/command_mime_import2' column_explanation=$smarty.capture.explanation}
