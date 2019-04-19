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
        type == 'on' ? true
                     : false;
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
function setDisabled(form,ids,type,base)
{

    var num = form.elements.length;
    
    var jug =
        type == 'off' ? false
                          : true;
    inValue = ids.split(':');
    
    var baseIdx = 0;
    if(base != null)
    {
        for(i=0;i<num;i++)
        {
            if(form.elements[i] == base)
            {
                baseIdx = i;
            }
        }
    }
    for(i=0;i<num;i++)
    {
        for(j=0;j<inValue.length;j++)
        {
            if(i == (parseInt(inValue[j]) + baseIdx))
            {
                form.elements[i].disabled=jug;
                break;
            }
        }
    }
}
