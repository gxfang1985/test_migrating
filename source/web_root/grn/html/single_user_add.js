/**
 * Used:
 *  grn/single_user_add.tpl,
 *  schedule/portlet/set_personal_day.tpl
 *  schedule/portlet/set_personal_month.tpl
 *  schedule/portlet/set_personal_week.tpl
 * @param form_name
 * @param id
 * @param text
 */
function setItem( form_name, id, text )
{
    var form = document.forms[form_name];
    var u = form.elements['UID'];
    var n = form.elements['member'];
    u.value = id;
    n.value = text;
}
/**
 * Used:
 *  grn/single_user_add.tpl,
 *  schedule/portlet/set_personal_day.tpl
 *  schedule/portlet/set_personal_month.tpl
 *  schedule/portlet/set_personal_week.tpl
 * @param form
 * @param selected
 * @param from
 * @param item_flag
 */
function EnterMember( form, selected, from, item_flag )
{
    if ( typeof item_flag == 'undefined' )
    {
        item_flag = false;
    }
    var opt = form.elements[from].options;
    li = opt.length - 1;
    for( i = 0; i < li ; ++i )
    {
        if( opt[i].selected )
        {
            form.member.value = opt[i].text;
            if ( item_flag )
            {
                form.UID.value = 'f' + opt[i].value;
            }
            else
            {
                form.UID.value = opt[i].value;
            }
            return;
        }
    }
}
/**
 *  Used in:
 *  grn/single_user_add.tpl,
 *  schedule/portlet/set_personal_day.tpl
 *  schedule/portlet/set_personal_month.tpl
 *  schedule/portlet/set_personal_week.tpl
 * @param form_name
 * @param sUID
 */
function RewriteCategoryOptions(form_name, sUID)
{
    var select = document.forms[form_name].elements[sUID].options;
    if ( select[0].value != 'search' )
    {
        AddFirstOption(select, 'search', rewriteCategoryOptionsWording.search, true);
    }
}
