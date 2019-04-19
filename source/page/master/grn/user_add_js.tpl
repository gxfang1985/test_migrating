{grn_load_javascript file="grn/html/component/user_select/user_select.js"}
{grn_load_javascript file="grn/html/user_add.js"}
{include file="grn/rewrite_category_options_wording.tpl"}
{literal}
<style type="text/css">
#spinner-loading-{/literal}{$CGID}{literal} {
  background-image : url( {/literal}{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}{literal} );
}
</style>
<script language="JavaScript" type="text/javascript">


function RewriteCategoryOptions(form_name, sUID, rewrite_key)
{
    var select = document.forms[form_name].elements[sUID].options;
    if ( rewrite_key == 'popup_user_select' && select[0].value != 'popup_user_select' )
    {
        AddFirstOption(select, 'popup_user_select', rewriteCategoryOptionsWording.popup_user_select, true);
    }
    else if (select[0].value != 'search')
    {
        AddFirstOption(select, 'search', rewriteCategoryOptionsWording.search, true);
    }
}
function AddMember(fname, cname, sname)
{
    var form = document.forms[fname];
    var c = form.elements[cname].options;

    {/literal}{if ! $org_direct}{literal}
    var co;
    var c_len = c.length;
    for( i = 0 ; i < c_len ; ++ i )
    {
        co = c[i];
        if ( !co.selected || ! co.value ) continue;
        var co_value = co.value.split(':');
        var f = false;
        if( co_value.length > 0 && co_value[0].match(/g[0-9]+/) )
        {
            co.selected = false;
            f = true;
            var sel = document.getElementsByName( cname )[0];
            var cl = sel.cloneNode(true);
            var cl_len = cl.length;
            for( var j = 0 ; j < cl_len ; ++ j )
            {
                if( ( co.value == cl[j].value ) || ( !cl[j].value ) ) continue;
                cl[j].selected = true;
            }
            c = cl.options;
            break;
        }
    }
    {/literal}{/if}{literal}
    if(CheckOptions(fname, sname, '0'))
    {
        ClearOptions(fname, sname);
    }
    if(CheckSelectedOptions(fname, cname, '0'))
    {
        ClearOptions(fname, sname);
        AddOption(fname, sname, cname, '0');
    }
    else
    {
        AddOptions( fname, sname, c );
    }
    {/literal}{if ! $org_direct}{literal}
    if( f && co)
    {
        c = form.elements[cname].options;
        var len = c.length;
        for( i = 0; i < len; ++ i )
            c[i].selected = false;
        co.selected = true;
    }
    {/literal}{/if}{literal}
}

function PrepareSubmit( form_name, sUID )
{
    var form = document.forms[form_name];
    if( typeof form.elements[sUID] == "undefined" ) return;
    var src = form.elements[sUID].options;
    var selected_groups = form.elements['selected_groups_' + sUID];
    var selected_users = form.elements['selected_users_' + sUID];
    selected_groups.value = '';
    selected_users.value = '';
    var gdelim = '';
    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value ) continue;
        var co_value = co.value.split(':');
        if ( co_value.length > 0 && ( isFinite( co_value[0] ) || co_value[0].match(/g[0-9]+/) ) )
        {
            selected_users.value += udelim + co_value[0];
            udelim = ':';
        }
        if ( co_value.length > 0 && co_value[0].match(/g[0-9]+/) )
        {
            var temp = co_value[0].substr(1);
            selected_groups.value += gdelim + temp;
            gdelim = ':';
        }
        if ( co_value.length > 1 && isFinite( co_value[1] ) )
        {
            co.value = co_value[0];
            selected_groups.value += gdelim + co_value[1];
            gdelim = ':';
        }
    }
}
function OrderTop( fname, sname )
{
    var donwlist = new Array();
    var uplist = new Array();
    
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    var len = u.length -1;
    var lastOption = new Option( u[len].text, "" );
    var i;
    for(i = 0; i < len ; ++ i )
    {
        var obj = {"id":u[i].value, "text":u[i].text};
        if(u[i].selected)
            uplist.push(obj);
        else
            donwlist.push(obj);
    }
    for( i = len ; i > 0 ; i-- ) u[i] = null;

    var userSelect = grn.component.user_select.user_select.UserSelectParts.create(fname, sname);
    for( i = len ; i > 0 ; i-- ) u[i] = null;
    u[0] = lastOption;
    len = uplist.length;
    for( i = 0 ; i < len ; i++ )
    {
        userSelect.documentFragment.appendChild(createOption(uplist[i].id, uplist[i].text, true));
    }
    len = donwlist.length;
    for( i = 0 ; i < len ; i++ )
    {
        userSelect.documentFragment.appendChild(createOption(donwlist[i].id, donwlist[i].text, false));
    }
    userSelect.addToDOM();
}
function OrderBottom( fname, sname )
{
    var donwlist = new Array();
    var uplist = new Array();
    
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    var len = u.length -1;
    var lastOption = new Option( u[len].text, "" );
    var i;
    for(i = 0; i < len ; ++ i )
    {
        var obj = {"id":u[i].value, "text":u[i].text};
        if(u[i].selected)
            donwlist.push(obj);
        else
            uplist.push(obj);
    }
    for( i = len ; i > 0 ; i-- ) u[i] = null;

    var userSelect = grn.component.user_select.user_select.UserSelectParts.create(fname, sname);
    for( i = len ; i > 0 ; i-- ) u[i] = null;
    u[0] = lastOption;
    len = uplist.length;
    for( i = 0 ; i < len ; i++ )
    {
        userSelect.documentFragment.appendChild(createOption(uplist[i].id, uplist[i].text, false));
    }
    len = donwlist.length;
    for( i = 0 ; i < len ; i++ )
    {
        userSelect.documentFragment.appendChild(createOption(donwlist[i].id, donwlist[i].text, true));
    }
    userSelect.addToDOM();
}
function createOption(value, text, selected)
{
    var optionElement = document.createElement("option");
    optionElement.value = value;
    optionElement.appendChild(document.createTextNode(text));
    if(selected)
        optionElement.setAttribute("selected", "selected");
    return optionElement;
}
//-->
</script>
{/literal}

