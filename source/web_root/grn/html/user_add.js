/**
 * @param form_name
 * @param sUID
 * @param c
 */
function RewriteItemOptions( form_name, sUID, c )
{
    var userSelect = grn.component.user_select.user_select.UserSelectParts.create(form_name, sUID);
    userSelect.rewriteOptions(c).applySelected();
}
/**
 *
 * @param form_name
 * @param sUID
 * @param c
 */
function RewriteItemOptionsWithoutSelectedAttribute( form_name, sUID, c ) {
    var userSelect = grn.component.user_select.user_select.UserSelectParts.create(form_name, sUID);
    userSelect.rewriteOptions(c);
}

/**
 * @param form_name
 * @param options_name
 * @param value
 * @param selected
 * @returns {boolean}
 */
function CheckOptions(form_name, options_name, value, selected)
{
    var form = document.forms[form_name];
    var options = form.elements[options_name].options;
    for(i = 0; i < options.length; i++)
    {
        if(value == options[i].value)
        {
            return true;
        }
    }
    return false;
}

/**
 * @param form_name
 * @param options_name
 * @param value
 * @returns {boolean}
 */
function CheckSelectedOptions(form_name, options_name, value)
{
    var form = document.forms[form_name];
    var options = form.elements[options_name].options;
    for(i = 0; i < options.length; i++)
    {
        if(value == options[i].value && options[i].selected)
        {
            return true;
        }
    }
    return false;
}
/**
 * @param form_name
 * @param options_name
 */
function ClearOptions(form_name, options_name)
{
    var form = document.forms[form_name];
    var options = form.elements[options_name].options;
    for(i = options.length - 2; i >= 0; i--)
    {
        options[i] = null;
    }
}
/**
 * @param form_name
 * @param selected_name
 * @param candidate_name
 * @param value
 */
function AddOption(form_name, selected_name, candidate_name, value)
{
    var form = document.forms[form_name];
    var selected_options = form.elements[selected_name].options;
    var candidate_options = form.elements[candidate_name].options;
    for(i = 0; i < candidate_options.length; i++)
    {
        candidate_option = candidate_options[i];
        if(value == candidate_option.value)
        {
            AddLastOption(selected_options, candidate_option.value, candidate_option.text, true);
        }
    }
}
/**
 * @param a
 * @param id
 * @param text
 * @param selected
 */
function AddFirstOption( a, id, text, selected )
{
    var li = a.length;
    a[li] = new Option();
    for ( i = 0 ; i < li; i ++ )
    {
        a[li-i].value = a[li-i-1].value;
        a[li-i].text = a[li-i-1].text;
        a[li-i].selected = a[li-i-1].selected;
    }
    a[0].text = text;
    a[0].value = id;
    a[0].selected = selected;
}

/**
 * @param a
 * @param id
 * @param text
 * @param selected
 */
function AddLastOption( a, id, text, selected )
{
    var li = a.length - 1;
    a[a.length] = new Option( a[li].text, "" );
    a[li] = new Option( text, id, false, selected );
}
/**
 * In grn/user_email_add.tpl, overwrite this function.
 * @param option
 * @returns {Array}
 */
function getOptionValue(option) {
    return option.value.split(':');
}
/**
 * In grn/user_email_add.tpl, overwrite this function.
 * @param valueA
 * @param valueB
 * @returns {boolean}
 */
function compareOptionsValue(valueA, valueB) {
    return valueA[0] == valueB[0];
}
function AddOptions( fname, sUID, c )
{
    var userSelect = grn.component.user_select.user_select.UserSelectParts.create(fname, sUID);
    var form = document.forms[fname];
    var u = form.elements[sUID].options;
    var li = u.length - 1;
    var u_values = [];
    var j;
    for( j = 0 ; j < li ; j ++ )
    {
        u_values[j] = getOptionValue(u[j]);
    }
    for( var i = 0 ; i < c.length ; i ++ )
    {
        var co = c[i];
        var co_value = co.value;
        var co_text = co.text;
        if( ! co.selected || ! co_value ) continue;
        var f = false;
        var c_value = getOptionValue(co);

        // check member already exists
        for( j = 0 ; j < li ; j ++ )
        {
            if ( compareOptionsValue(u_values[j], c_value) )
            {
                u[j].value = co_value;
                u[j].text = co_text;
                u[j].selected = true;
                f = true;
                break;
            }
        }

        if( ! f )
        {
            userSelect.addOption(co);
        }
    }
    userSelect.addToDOM().applySelected();
}

/**
 *
 * @param {string} target
 * @param {string} url
 * @param {Object} parameters
 */
function searchByKeyword(target, url, parameters)
{
    "use strict";

    // create new form
    var doc = document;
    var new_form = doc.createElement('form');
    new_form.target = target;
    new_form.method = 'post';
    new_form.action = url;

    jQuery.each(parameters, function(name, value)
    {
        var new_input = document.createElement("input");
        new_input.type = 'hidden';
        new_input.name = name;
        new_input.value = value;

        new_form.appendChild(new_input);
    });

    // submit new form and remove it
    var parent_node = doc.body;
    parent_node.appendChild(new_form);
    new_form.submit();
    parent_node.removeChild(new_form);
}
