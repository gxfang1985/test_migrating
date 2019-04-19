// delete fileselect
function grn_delete_fileselect( id )
{
    var p = document.getElementById( id );
    if( p ) {
        p.innerHTML = '';
        p.style.display = 'none';
    }
}

