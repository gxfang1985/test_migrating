<!DOCTYPE html>
<head>
    <title>{cb_msg module='grn.re' key='add_image-title' replace='true'}</title>
    {grn_load_javascript file="grn/html/component/editor/grn_color_palette.js"}
    {grn_load_css file="grn/html/component/editor/grn_color_palette.css"}
</head>

<body role="application" align="center" valign="center">

<div id="grn_color_palette_container" align="center" valign="center">
</div>

<table class="mce-grid mce-grid-border mce-colorbutton-grid ">
    <tbody>
    <tr>
        <td>
            <span>{cb_msg module='grn.re' key='color' replace='true'}: </span>
            <input type="text" name="color_value" style="width: 120px;" maxlength="25" id="grn_palette_color_value">
        </td>
        <td id="grn_palette_selected_color"></td>
        <td>
            <input type="button" class="grn_palette_apply_color"
                   value="{cb_msg module='grn.re' key='apply' replace='true'}"
                   onclick="grn_component_editor_Color_Palette_Dialog.applyColor()">
        </td>
    </tr>
    </tbody>
</table>

{literal}
    <script>
        grn_component_editor_Color_Palette_Dialog.init();
    </script>
{/literal}

</body>
</html>