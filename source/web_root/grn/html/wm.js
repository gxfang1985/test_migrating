function changeDisplay(i,id,status,type)
{
    var my = i;
    if(type == 'sm' || type == null)
    {
    var d = document.getElementById(id);
        inValue = new Array();
        inValue = status.split(':');
        if(inValue[my.selectedIndex] == '1')
        {
            d.style.display = '';
        }
        if(inValue[my.selectedIndex] == '0')
        {
            d.style.display = 'none';
        }
    }
    return;
}
function changeDisplayRadio(nid,oid)
{
    inOn = new Array();
    inOff = new Array();
    if(nid.match(/:/))
    {
        inOn = nid.split(':');
    }
    else
    {
        inOn[0] = nid;
    }
    if(oid.match(/:/))
    {
        inOff = oid.split(':');
    }
    else
    {
        inOff[0] = oid;
    }
    if(inOn[0] != '')
    {
        for(i=0;i<inOn.length;i++)
        {
            var d = document.getElementById(inOn[i]);
            d.style.display = '';
        }
    }
    if(inOff[0] != '')
    {
        for(i=0;i<inOff.length;i++)
        {
            var d = document.getElementById(inOff[i]);
            d.style.display = 'none';
        }
    }
}
function changeValue(i,form,ename,status,type)
{
    if(type == 'sm' || type == null)
    {
        inValue = new Array();
        inValue = status.split(':');
        form.elements[ename].value = inValue[i.selectedIndex];
    }
    if(type == 'pt_ml')
    {
        var d = parent.document;
        d.forms[form].elements[ename].value = status;
    }
    return;
}
function setDisableById(form,ids,type)
{
    var inValue = new Array();
    if(ids.match(/:/))
    {
        inValue = ids.split(':');
    }
    else
    {
        inValue = new Array(ids);
    }
    jug =
        type == 'off' ? false
                      : true;
    for(i=0;i<inValue.length;i++)
    {
        var d = document.getElementById(inValue[i]);
        if(d)
        {
            d.disabled = jug;
        }
    }
    return;
}
function changeAccount(i,s_id,name)
{
    var my = i;
    var num = my.selectedIndex;
    if(name)
    {
        for(i=0;i<my.options.length;i++)
        {
            var id = s_id+(i+1);
            var d = document.getElementById(id);
            if(i == num)
            {
                d.style.display = '';
                if(d.childNodes[0].name)
                {
                    d.childNodes[0].name = name;
                }
            }
            else
            {
                d.style.display = 'none';
                if(d.childNodes[0].name)
                {
                    d.childNodes[0].name = name+(i+1);
                }
            }
        }
    }
    else
    {
        for(i=0;i<my.options.length;i++)
        {
            var id = s_id+(i+1);
            var d = document.getElementById(id);
            if(i == num)
            {
                d.style.display = '';
            }
            else
            {
                d.style.display = 'none';
            }
        }
    }
    return;
}
function changeDataWM(i,s_name,type)
{
    var f = document.forms[i.form.name];
    var d = f.elements[s_name];
    if(type == null)
    {
        d.value = i.value;
    }
    if(type == 'cbx')
    {
        if(i.checked) d.value = 1;
    }
    return;
}
function changeAccount2(i,s_id,name,hidden)
{
    var my = i;
    var num = my.selectedIndex;
    if(name)
    {
        for(i=0;i<my.options.length;i++)
        {
            var optionValue = my.options[i].value;
            var id = s_id+optionValue;
            var d = document.getElementById(id);
            if(optionValue == my.value)
            {
                d.style.display = '';
                if(d.childNodes[0].name)
                {
                    d.childNodes[0].name = name;
                }
            }
            else
            {
                d.style.display = 'none';
                if(d.childNodes[0].name)
                {
                    d.childNodes[0].name = name+optionValue;
                }
            }
        }
    }
    else
    {
        for(i=0;i<my.options.length;i++)
        {
            var optionValue = my.options[i].value;
            var id = s_id+optionValue;
            var d = document.getElementById(id);
            if(optionValue == my.value)
            {
                d.style.display = '';
            }
            else
            {
                d.style.display = 'none';
            }
        }
    }
    if(hidden)
    {
        changeDataWM(my,hidden);
    }
    return;
}
function changeFolderOff(i,aid,cid,status)
{
    var my = i;
    var said = new RegExp(aid,"i");
    var scid = new RegExp(cid,"i");
    var inCid = document.getElementsByTagName('select');
    for(i=0;i<inCid.length;i++)
    {
        if(inCid[i].getAttributeNode('name')){
            var s = inCid[i].getAttributeNode('name');
            if(s.value.match(said))
            {
                if(my.checked)
                {
                    inCid[i].disabled =
                        status == '1' ? false
                                      : true;
                }
                else
                {
                    inCid[i].disabled =
                        status == '1' ? true
                                      : false;
                }
            }
            if(s.value.match(scid))
            {
                if(my.checked)
                {
                    inCid[i].disabled =
                        status == '1' ? false
                                      : true;
                }
                else
                {
                    inCid[i].disabled =
                        status == '1' ? true
                                      : false;
                }
            }
        }
    }
    return;
}
function checkOn(i,id,type)
{
    var my = i;
    if(type == 'cbx' || type == null)
    {
    var d = document.getElementById(id);
        if(my.checked)
        {
            selectOffWM(d.form,id,'cbx');
        }
        else
        {
            selectOnWM(d.form,id,'cbx');
        }
    }
    return;
}
function selectOnWM(form,id,type)
{
    if(type == 'cbx')
    {
        var d =document.getElementById(id);
        d.disabled = false;
        var l = document.getElementsByTagName('label');
        for(i=0;i<l.length;i++)
        {
            var forName = l[i].getAttributeNode('for');
            if(forName.nodeValue == id)
            {
                l[i].className = '';
            }
        }
    }
    return;
}
function selectOffWM(form,id,type)
{
    if(type == 'cbx')
    {
        var d =document.getElementById(id);
        d.disabled = true;
        var l = document.getElementsByTagName('label');
        for(i=0;i<l.length;i++)
        {
            var forName = l[i].getAttributeNode('for');
            if(forName.nodeValue == id)
            {
                l[i].className = 'form_disable';
            }
        }
    }
    return;
}
function typeChangeWM(fname,e,status)
{
    var f = document.forms[fname];
    var d = f.elements[e];
    if(d.checked)
    {
        inData = new Array();
        if(status.match(/:/))
        {
            inData = status.split(':');
            changeFolderOff(d,inData[0],inData[1],'0');
            selectOffWM(f,inData[2],'cbx');
        }
    }
    return;
}
function display_onWM(id)
{
    document.getElementById(id).style.display = "";
    return;
}
function display_offWM(id)
{
    document.getElementById(id).style.display = "none";
    return;
}
function typeChangeSM(fname,e)
{
    eName = new Array();
    if(e.match(/:/))
    {
        eName = e.split(':');
    }
    else
    {
        eName[0] = e;
    }
    
    var f = document.forms[fname];
    
    if(eName.length < 2)
    {
        if(f.elements[eName[0]][1].checked)
        {
            setDisableById(f,'server:port:exception_address','on');
        }
    }
    else
    {
        if(f.elements[eName[0]][1].checked)
        {
            setDisableById(f,'ismtp_server:ismtp_port:imailaddress:ismtp_timeout:smtp_auth:ismtp_user:ismtp_pass:is_pop_before_smtp1:is_pop_before_smtp2:ipop_before_smpt_wait:ipop3_server:ipop3_port:pop3_auth1:pop3_auth2:ipop3_user:ipop3_pass:ipop3_timeout:use_builtin1','on');
        }
        
        if(f.elements[eName[1]].selectedIndex != 0)
        {
            display_offWM('display_is_pop_before_smtp');
            display_onWM('display_smtp_account_set');
        }
        else
        {
            display_onWM('display_is_pop_before_smtp');
            display_offWM('display_smtp_account_set');
        }

        if(eName[2] === "is_pop_before_smtp")
        {
            if(f.elements[eName[2]][1].checked)
            {
                display_offWM('display_pop3');
            }
            else
            {
                display_onWM('display_pop3');
            }
        }


        if(eName.length === 4)
        {
            if(f.elements[eName[3]].checked)
            {
                setDisableById(f,'ismtp_server:ismtp_port:ismtp_timeout:smtp_auth:ismtp_user:ismtp_pass:is_pop_before_smtp1:is_pop_before_smtp2:ipop_before_smpt_wait:ipop3_server:ipop3_port:pop3_auth1:pop3_auth2:ipop3_user:ipop3_pass:ipop3_timeout','on');
            }
        }
    }
    return;
}
function typeChangeWMC(fname,e)
{
    eName = new Array();
    if(e.match(/:/))
    {
        eName = e.split(':');
    }
    else
    {
        eName[0] = e;
    }
    
    var f = document.forms[fname];
    
    if(eName.length == 2)
    {
        if(f.elements[eName[0]][1].checked)
        {
            display_offWM(eName[1]);
        }
        else
        {
            display_onWM(eName[1]);
        }
    }
    return;
}
function setSystemMailAddress( type, value )
{
    var el = document.getElementById("imailaddress");
    el.style.display = type;
    el.value = value;
}

