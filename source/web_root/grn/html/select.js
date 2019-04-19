function cb_ui_select_create_option(text, value, selected)
{
    if(document.createElement)
    {
        var new_option = document.createElement("OPTION");
        new_option.value = value;
        new_option.text = text;
        new_option.selected = selected;
        return new_option;
    }
    else
    {
        var new_option = new Option(text, value, false, selected);
        return new_option;
    }
}

function cb_ui_select_copy_option(src_option, selected)
{
    return cb_ui_select_create_option(src_option.text, src_option.value, selected);
}

function cb_ui_select_find_option(options, value)
{
    for(var i = 0 ; i < options.length ; i ++)
    {
        if(options[i].value == value) { return i; }
    }
    return -1;
}

function cb_ui_array_find(values, value)
{
    for(var i = 0 ; i < values.length ; i ++)
    {
        if(values[i] == value) { return i; }
    }
    return -1;
}

function cb_ui_select_add_option(options, index, text, value, selected)
{
    if(navigator.appName.charAt(0) == "N")
    {
        var length = options.length;
        if(length > index)
        {
            options[length] = new Option(options[length - 1].text, options[length - 1].value);
            options[length].selected = options[length - 1].selected;
            for(i = length - 1 ; i > index ; i --)
            {
                options[i].text = options[i - 1].text;
                options[i].value = options[i - 1].value;
                options[i].selected = options[i - 1].selected;
            }
            options[index].text = text;
            options[index].value = value;
            options[index].selected = selected;
        }
        else
        {
            options[legnth] = new Option(text, value);
            options[length].selected = selected;
        }
    }
    else if(options.add)
    {
        var new_option = cb_ui_select_create_option(text, value, selected);
        options.add(new_option, index);
    }
}

function cb_ui_select_remove_option(options, index)
{
    if(options.remove)
    {
        options.remove(index);
    }
    else
    {
        options[index] = null;
    }
}
