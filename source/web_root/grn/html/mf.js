msie = window.navigator.userAgent.indexOf( "MSIE" ) == -1 ? false : true;

delete_count = 1;

var __op_sb      = "標題";
var __op_fr      = "差出人";
var __op_to      = "宛先";
var __op_co      = "が次を含む。";
var __op_nco     = "が次を含まない。";
var __op_sa      = "が次と同じ。";
var __op_nsa     = "が次と異なる。";
var __op_be      = "が次で始まる。";
var __op_ge      = "が次の値(KB)以上";
var __op_le      = "が次の値(KB)以下";
var __bt_del     = "削除";
var __bt_del_all = "条件を全て削除する";

function add()
{
    ++idNum;
    var n = 'fdiv'+idNum;
    var p = document.getElementById('fbox');
    var c = document.createElement('DIV');
    c.id = n;
    p.appendChild(c);
    c.innerHTML = "<select name='object_"+idNum+"'><option value='1'>"+ __op_sb +"<option value='2'>"+ __op_fr +"<option value='3'>"+ __op_to +"</select><select name='type_"+idNum+"'><option value='1'>"+ __op_co +"<option value='2'>"+ __op_nco +"<option value='3'>"+ __op_sa +"<option value='4'>"+ __op_nsa +"<option value='5'>"+ __op_be +"</select>&nbsp;<input type='text' name='text_"+idNum+"' size='40'>&nbsp;<input type='button' value='"+ __bt_del +"' onClick='javascript:odf(\""+n+"\")' style='display:;'>";
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
        d.innerHTML = "<input type='button' value='"+ __bt_del_all +"' onclick='return adf(this);' style='display:;'>";
    }
    return true;
}

function odf( id )
{
    var p = document.getElementById( id );
        p.parentNode.removeChild(p);
    if((delete_count+1) == idNum)
    {
        var a = document.getElementById('fbox');
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
    var p = document.getElementById( 'fbox' );
    var s = p.getElementsByTagName('div');
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
    var c = document.createElement('div');
    c.id = n;
    p.appendChild(c);
    c.innerHTML = "<select name='object_"+idNum+"'><option value='1'>"+ __op_sb +"<option value='2'>"+ __op_fr +"<option value='3'>"+ __op_to +"</select><select name='type_"+idNum+"'><option value='1'>"+ __op_co +"<option value='2'>"+ __op_nco +"<option value='3'>"+ __op_sa +"<option value='4'>"+ __op_nsa +"<option value='5'>"+ __op_be +"</select>&nbsp;<input type='text' name='text_"+idNum+"' size='40'>&nbsp;<input type='button' value='"+ __bt_del +"' onClick='javascript:odf(\""+n+"\")' style='display:;'>";
    return true;
}
