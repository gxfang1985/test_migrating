msie = window.navigator.userAgent.indexOf( "MSIE" ) == -1 ? false : true;

delete_count = 1;

/**
// resources
// see 'page/grn/attach_file.tpl' to fit
var __wmc_box_prefix     = "fbox";
var __wmc_def_prefix     = "fbox0";
var __wmc_div_prefix     = "fdiv";
var __wmc_time_prefix     = "scheduled_time_";
var __wmc_time_replace    = "%id_number%";
var __wmc_delete_text    = "削除";
var __wmc_all_delete_text = "時間をすべて削除する";
**/

function add()
{
    ++idNum;
    var n = __wmc_div_prefix+idNum;
    var p = document.getElementById( __wmc_box_prefix );
    var c = document.createElement('DIV');
    var df = document.getElementById( __wmc_def_prefix );
    c.id = n;
    c.style.marginTop = "5px";
    p.appendChild(c);
    var in_obj = df.innerHTML;
    re = new RegExp(__wmc_time_replace, "g");
    out_obj = in_obj.replace(re, idNum);
    c.innerHTML = out_obj+"<input type='button' value='"+__wmc_delete_text+"' onClick='javascript:odf(\""+n+"\")' style='display:;'>";
    if((delete_count+1) == idNum)
    {
        var d = p.childNodes;
        for(i=0;i<d.length;i++){
            if(d[i].style){
                if(d[i].style.display != 'none'){
                    d[i].lastChild.style.display = '';
                }
            }
        }
    }
    if(!(document.getElementById('delete_all')))
    {
        var m = document.getElementById('fdel');
        var d = document.createElement('span');
        d.id = 'delete_all';
        m.appendChild(d);
        d.innerHTML = "<input type='button' value='"+__wmc_all_delete_text+"' onclick='return adf(this);' style='display:;'>";
    }
    return true;
}

function odf( id )
{
    var p = document.getElementById( id );
        p.parentNode.removeChild(p);
    if((delete_count+1) == idNum)
    {
        var a = document.getElementById( __wmc_box_prefix );
        var c = a.childNodes;
        for(i=0;i<c.length;i++){
            if(c[i].style){
                if(c[i].style.display != 'none'){
                    c[i].lastChild.style.display = 'none';
                }
            }
        }
        var m = document.getElementById('delete_all');
        m.parentNode.removeChild(m);
    }
    delete_count++;
    return true;
}

function adf()
{
    var p = document.getElementById( __wmc_box_prefix );
    var s = p.getElementsByTagName( 'DIV' );
    for(i=0;i<s.length;i++){
        if(s[i].id.match(/fdiv/))
        {
            delete_count++;
        }
    }
    p.innerHTML = '';
    var m = document.getElementById('delete_all');
    m.parentNode.removeChild(m);
    ++idNum;
    var n = 'fdiv'+idNum;
    var c = document.createElement('DIV');
    c.id = n;
    p.appendChild(c);
    var df = document.getElementById( __wmc_def_prefix );
    var in_obj = df.innerHTML;
    re = new RegExp(__wmc_time_replace, "g");
    out_obj = in_obj.replace(re, idNum);
    c.innerHTML = out_obj+"<input type='button' value='"+__wmc_delete_text+"' onClick='javascript:odf(\""+n+"\")' style='display:none;'>";
    return true;
}
