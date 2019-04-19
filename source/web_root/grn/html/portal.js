function MoveMember_multiple(fname, sname1, sname2)
{
    AddMember_multiple(fname, sname1, sname2);
    RemoveMember_multiple(fname, sname1);
}
function AddMember_multiple( fname, cname, sname )
{
    var form = document.forms[fname];
    var c = form.elements[cname].options;
    var u = form.elements[sname].options;
    for( i = 0 ; i < c.length - 1 ; i ++ )
    {
        var co = c[i];
        if( ! co.selected || ! co.value ) continue;
        var f = false;
        var li = u.length - 1;
        if( f ) continue;
        var o = document.createElement( "OPTION" );
        o.value = co.value;
        o.text = co.text;
        o.selected = true;
        u.add( o, li );
    }
}
function RemoveMember_multiple( fname, sname )
{
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    for( i = 0 ; i < u.length - 1 ; i ++ )
    {
        if( u[i].selected )
        {
            u.remove( i );
            i -= 1;
        }
    }
}
