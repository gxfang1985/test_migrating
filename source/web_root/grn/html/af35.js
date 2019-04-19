// check user agent
msie = window.navigator.userAgent.indexOf( "MSIE" ) == -1 ? false : true;

// delete fileselect
function grn_delete_fileselect( id )
{
    var p = document.getElementById( id );
    if( p ) {
        p.innerHTML = '';
        p.style.display = 'none';
    }
}

// clear upload table
function grn_clear_fileselect(id)
{
    var uploadTable = document.getElementById("upload_table_" + id);
    if(uploadTable != null)
    {
        while (uploadTable.childNodes.length > 0 )
        {
            uploadTable.removeChild(uploadTable.childNodes[0]);
        }
        var default_upload_table_html = "<table><tbody><tr><td></td></tr></tbody></table>";
        var divElem = document.createElement('div');
        divElem.innerHTML = default_upload_table_html;
        var tableElem = divElem.firstChild;
        uploadTable.appendChild( tableElem.firstChild );
    }
}
