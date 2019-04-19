<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
{grn_load_javascript file="grn/html/component/editor/image_dialog.js"}
<script>
    grn_component_editor_ImageDialog.image_url = "{grn_pageurl page='re/command_get' fileid=$fileid hash=$filehash}";
</script>
</head>
<body style="margin:0; padding: 0" onload="grn_component_editor_ImageDialog.applyUploadedImage();">
</body>
</html>
