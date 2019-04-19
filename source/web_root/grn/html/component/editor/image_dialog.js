var grn_component_editor_ImageDialog = {
    handleSubmitButton : function () {
        var file = document.getElementById('file_input');
        top.tinymce.DOM.bind(file, 'change', function(){
            document.getElementById('insert').disabled = (file.value ? 0 : 1);
        });
    },
    
    applyUploadedImage : function () {
        var choose_file_window = top.tinymce.activeEditor.windowManager.getWindows()[1];
        choose_file_window.params.oninsert(grn_component_editor_ImageDialog.image_url);
        choose_file_window.close();
    }
};

//////// Following parameter is set from template file
/**
 * @type {string} URL for uploaded image (ex. /g/re/command_get.csp?fileid=123&amp;hash=f741...)
 */
grn_component_editor_ImageDialog.image_url = '';