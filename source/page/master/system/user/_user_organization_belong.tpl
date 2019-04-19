{assign var='dir_name' value=$dir_name|default:'system/user'}
<script language="javascript" type="text/javascript">
{literal}
<!--
var popWin = null;
function add_user_org()
{
    window.focus();
    var url_org = "{/literal}{grn_pageurl page="$dir_name/select_org_belong_xml"}{literal}";

    var ajax_request = new grn.component.ajax.request({
        url: url_org,
        method: "post",
        data: 'session={/literal}{$session|escape}{literal}'
    });

    ajax_request.on(grn.component.ajax.request.EVENT.BEFORE_SHOW_ERROR, function(){
        popWin.close();
    });

    ajax_request.send().done(function (data, textStatus, jqXHR) {
        updateOrganization(jqXHR);
    });
    return true;
}

function updateOrganization( req )
{
    var headers = req.getAllResponseHeaders();
    var regex = /X-Cybozu-Error/i;

    // response error.
    if( req.status != 200 )
    {
        return false;
    }

    // receive not completed
    if( req.readyState != 4 )   { return false; }

    var regex_has_login = /X-CybozuLogin/i;
    if( headers.match( regex_has_login ) && ! popWin.closed)
    {
        popWin.close();
        location.reload(true);
        return;
    }

    var primary_org = document.forms['{/literal}{$form_name}{literal}'].elements['primary_org'];
    var selected_id = null;
    var select = primary_org.options;
    if ( primary_org.selectedIndex >= 0 )
    {
        selected_id = select[primary_org.selectedIndex].value;
    }
    
    for( i = select.length-1 ; i > 0 ; i-- ) select[i] = null;
    var html = '';
    var values = req.responseXML.getElementsByTagName( 'value' );
    if( values && values.length > 0 )
    {
        for( i = 0 ; i < values.length ; i ++ )
        {
            var value = values.item(i);
            var id = value.getAttribute( 'id' );
            var name = value.getElementsByTagName( 'name' ).item(0).firstChild.nodeValue ;
            var fullpath = value.getElementsByTagName( 'fullpath' ).item(0).firstChild.nodeValue;
            var option_label = name + ' {/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-3' replace='true'}{literal}' + fullpath + ' {/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-4' replace='true'}{literal}';

            var fullpath_escape_html = jQuery("<div></div").text(fullpath).html();
            html += '<div>'+ fullpath_escape_html + '</div>';
            html += '<input type="hidden" name="oid[]" value="' + id + '">';
            
            select[i] = new Option( option_label, id );
            if ( id == selected_id )
            {
                select[i].selected = true;
            }
        }
    }
    else
    {
        html = '<div>{/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-5' replace='true'}{literal}</div>'
        select[0] = new Option( '{/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-6' replace='true'}{literal}', '' );
    }
    if( ! popWin.closed )
    {
        setTimeout( 'popWin.close()', 100 ); 
    }
    
    document.getElementById( 'select_belong_org' ).innerHTML = html;
}

function popupSelectOrg( form )
{
    if( popWin && ! popWin.closed )
    {
        popWin.close();
    }
    popWin = popupWin_returnWin('{/literal}{grn_pageurl page="$dir_name/org_user_belong_add" session=$session}{literal}','popup','','',0,0,1,1,0,1);
    return false;
}

//-->
{/literal}
</script>
