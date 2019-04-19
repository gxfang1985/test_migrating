// depend on 'cb_ui_select.js'

function _cb_ui_order_swap_option(options, index1, index2)
{
    var text = options[index1].text;
    var value = options[index1].value;
    var selected = options[index1].selected;
    options[index1].text = options[index2].text;
    options[index1].value = options[index2].value;
    options[index1].selected = options[index2].selected;
    options[index2].text = text;
    options[index2].value = value;
    options[index2].selected = selected;
}

function cb_ui_order_top(fname, sname)
{
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    var j = 0;
    for(var i = 0 ; i < u.length - 1 ; i ++)
    {
        if(u[i].selected)
        {
            if(i == 0) { j++; continue; }
            var text = u[i].text;
            var value = u[i].value;
            for(var k = i ; k > j ; k --)
            {
                _cb_ui_order_swap_option(u, k, k-1);
                u[k-1].selected = true;
            }
            j++;
        }
    }
}
    
function cb_ui_order_up(fname, sname)
{
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    for(var i = 0 ; i < u.length - 1 ; i ++)
    {
        if(u[i].selected)
        {
            if(i == 0) { break; }
            _cb_ui_order_swap_option(u, i, i-1);
            u[i-1].selected = true;
        }
    }
}

function cb_ui_order_down(fname, sname)
{
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    for(var i = u.length - 2 ; i >= 0 ; i --)
    {
        if(u[i].selected)
        {
            if(i >= u.length - 2) { break; }
            _cb_ui_order_swap_option(u, i, i+1);
            u[i+1].selected = true;
        }
    }
}

function cb_ui_order_bottom(fname, sname)
{
    var form = document.forms[fname];
    var u = form.elements[sname].options;
    var j = u.length - 2;
    for(var i = u.length - 2 ; i >= 0 ; i --)
    {
        if(u[i].selected)
        {
            if(i >= u.length - 2) { j--; continue; }
            for(var k = i ; k < j ; k ++)
            {
                _cb_ui_order_swap_option(u, k, k+1);
                u[k+1].selected = true;
            }
            j--;
        }
    }
}
