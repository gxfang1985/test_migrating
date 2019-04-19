/**
 * @param form_name
 * @param sUID
 */
function ClearPopupUserSelect (form_name, sUID)
{
    var ops = document.forms[form_name].elements[sUID].options;
    for( i = 0 ; i < ops.length ; i ++ )
    {
        if( ops[i].value == 'popup_user_select' )
        {
            document.forms[form_name].elements[sUID].options[i] = null;
        }
    }
}
/**
 * @param form_name
 * @param sUID
 */
function ClearSearch (form_name, sUID)
{
    var ops = document.forms[form_name].elements[sUID].options;
    for( i = 0 ; i < ops.length ; i ++ )
    {
        if( ops[i].value == 'search' )
        {
            document.forms[form_name].elements[sUID].options[i] = null;
        }
    }
}
/**
 * @param form_name
 * @param sUID
 */
function PrepareSubmit( form_name, sUID )
{
    var form = document.forms[form_name];
    var src = form.elements[sUID].options;
    var selected_users = form.elements['all_' + sUID];
    selected_users.value = '';
    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value ) continue;
        var co_value = co.value.split(':');
        if ( co_value.length > 0 && isFinite( co_value[0] ) )
        {
            selected_users.value += udelim + co_value[0];
            udelim = ':';
        }
    }
}
/**
 * @param form_name
 * @param sUID
 * @param rewrite_key
 */
function RewriteCategoryOptions(form_name, sUID, rewrite_key)
{
    var select = document.forms[form_name].elements[sUID].options;
    if ( rewrite_key == 'popup_user_select' && select[0].value != 'popup_user_select' )
    {
        ClearPopupUserSelect (form_name, sUID);
        ClearSearch (form_name, sUID);
        AddFirstOption(select, 'popup_user_select', rewriteCategoryOptionsWording.popup_user_select, true);
    }
    else if ( rewrite_key != 'popup_user_select' && select[0].value != 'search' )
    {
        ClearSearch (form_name, sUID);
        ClearPopupUserSelect (form_name, sUID);
        AddFirstOption(select, 'search', rewriteCategoryOptionsWording.search, true);
    }
}