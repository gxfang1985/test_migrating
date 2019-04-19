function clickDesignRadio ( clicked )
{
    if( typeof strSelected != 'undefined' )
    {
        document.getElementById( 'td_' + strSelected ).style.backgroundColor = '';
    }

    document.getElementById( 'td_' + clicked ).style.backgroundColor = '#CADBEC';
    strSelected = clicked;
}
function clickDesignImage ( clicked )
{
    document.getElementById( clicked ).checked = true;
    clickDesignRadio( clicked );
}
