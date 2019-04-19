function _changeButtonDisabled(elem, button)
{
    if( typeof button === "string" )
    {
        button = document.getElementById( button );
    }
    if(elem.selectedIndex == 0)
    {
        jQuery(button).prop("disabled", true);
        if (button.nodeName === "BUTTON")
        {
            jQuery(button).attr("aria-disabled", true);
            jQuery(button).parent().addClass("button_disable_filter_grn");
        }
    }
    else
    {
        jQuery(button).prop("disabled", false);
        if (button.nodeName === "BUTTON")
        {
            jQuery(button).removeAttr("aria-disabled");
            jQuery(button).parent().removeClass("button_disable_filter_grn");
        }
    }
}

function onChangeFolderSelect(elem, select, button)
{
    var i;
    if( button instanceof Array && button.length > 0 )
    {
        for(i=0; i<button.length; i++)
        {
            _changeButtonDisabled(elem, button[i]);
        }
    }
    else if( button )
    {
        _changeButtonDisabled(elem, button);
    }

    if( select )
    {
        if( typeof select === "string" )
        {
            select = document.getElementById( select );
        }
        select.selectedIndex = elem.selectedIndex;
    }
}
