function toggleEditForm( show, hide ) {
    jQuery( "#" + show ).show();
    jQuery( "#" + hide ).hide();
}

function disableForm( formName, element ) {
    disabled = element.checked;
    var form = document.forms[ formName ];
    for( var i = 0; i < form.length; i++) {
        var f = form[ i ];
        if( f.type.toUpperCase() != 'SUBMIT' && f.type.toUpperCase() != 'BUTTON' && f.type.toUpperCase() != 'HIDDEN' ) {
            f.disabled = disabled;
        }
    }
}

