msie = window.navigator.userAgent.indexOf("MSIE") == -1 ? false : true;

function __grn_workflow_create_search_common(id)
{
    htmlsrc = __wfmf_item_common;
    while ((htmlsrc.indexOf('%NUM%') != -1))
    {
        htmlsrc = htmlsrc.replace('%NUM%', id);
    }
    return htmlsrc;
}

function __grn_workflow_create_search_item(id, type)
{
    htmlsrc = __wfmf_item_templates[type];
    while ((htmlsrc.indexOf('%NUM%') != -1))
    {
        htmlsrc = htmlsrc.replace('%NUM%', id);
    }
    return htmlsrc;
}

function grn_workflow_add_search_item()
{
    ++idNum;
    
    var fbox = document.getElementById('fbox');
    var div = document.createElement('DIV');
    div.id = 'fdiv' + idNum;
    div.innerHTML = __grn_workflow_create_search_common(idNum);
    fbox.appendChild(div);
    delete_count++;
    
    if(!(document.getElementById('delete_all')))
    {
        var fdel = document.getElementById('fdel');
        var span = document.createElement('span');
        span.id = 'delete_all';
        span.innerHTML = __wfmf_item_delete_all;
        fdel.appendChild(span);
    }
    
    grn_workflow_check_search_delete(delete_count);
    
    return true;
}

function grn_workflow_delete_search_item(id)
{
    var fdiv = document.getElementById('fdiv' + id);
    var fbox = document.getElementById('fbox');
    fbox.removeChild(fdiv);
    delete_count--;
    
    grn_workflow_check_search_delete(delete_count);
    
    return true;
}

function grn_workflow_delete_search_item_all()
{
    var fbox = document.getElementById('fbox');
    fbox.innerHTML = '';
        
    idNum = 1;
    var div = document.createElement('div');
    div.id = 'fdiv' + idNum;
    div.innerHTML = __grn_workflow_create_search_common(idNum);
    fbox.appendChild(div);
    delete_count = 1;
    
    grn_workflow_check_search_delete(delete_count);
    
    return true;
}

function grn_workflow_change_search_item(id, select)
{
    var fspan = document.getElementById('fspan' + id);
    fspan.innerHTML = __grn_workflow_create_search_item(id, select.selectedIndex);
    return true;
}

function grn_workflow_check_search_delete(delete_count)
{
    var dspan = document.getElementById('dspan');
    if (delete_count == 1)
    {
        dspan.style.display = 'none';
        
        var delete_all = document.getElementById('delete_all');
        delete_all.parentNode.removeChild(delete_all);
    }
    else
    {
        dspan.style.display = '';
    }
    
    return;
}
