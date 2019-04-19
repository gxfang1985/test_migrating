<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>{cb_msg module='grn.re' key='add_image-title' replace='true'}</title>
    {grn_load_javascript file="grn/html/component/editor/image_dialog.js"}
</head>
<body role="application" onload="grn_component_editor_ImageDialog.handleSubmitButton();">
<form method="post"
      action="{grn_pageurl page='re/command_add_image'}" enctype="multipart/form-data">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {if $err_invalid_image_type || $err_file_size_over}
        <span style="color:red;font-weight:bold;">
            {if $err_invalid_image_type}
                {cb_msg module='grn.re' key='invalid-image-type' replace='true'}
            {else}
                {cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}{$err_file_size_over}{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}
            {/if}
        </span>
    {/if}

    <table role="presentation" border="0" cellpadding="4" cellspacing="0">
        <tr role="group" aria-labelledby="file_label">
            <td class="column1"><label id="file_label" for="file">{cb_msg module='grn.re' key='add_image-label' replace='true'}</label></td>
            <td colspan="2">
                <input type="file" name="file" id="file_input" style="width: 300px;">
            </td>
        </tr>
    </table>
    <div class="mceActionPanel" style="margin-top: 5px;">
        <input type="submit" id="insert" name="insert" onclick="" value="{cb_msg module='grn.re' key='add_image-submit' replace='true'}" disabled/>
        <input type="button" id="cancel" name="cancel" onclick="top.tinymce.activeEditor.windowManager.getWindows()[1].close();" value="{cb_msg module='grn.common' key='cancel' replace='true'}" />
    </div>
</form>
</body>
</html>
