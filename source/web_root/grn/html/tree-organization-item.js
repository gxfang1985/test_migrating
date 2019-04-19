function GRN_OrganizationItem( gid, name, callback, selected, type )
{
    this.gid = gid;
    this.name = name;
    this.callback = callback;
    this.selected = selected;
    this.type = type;
}

GRN_OrganizationItem.prototype.createElement = function()
{
    var tr = jQuery("<tr class='dropdown_item'></tr>");

    if( this.seleced )
    {
        tr.addClass("selected_item");
    }

    tr.mouseover(function ()
    {
        tr.addClass("user_group_hover");
    });

    tr.mouseout(function ()
    {
        tr.removeClass("user_group_hover");
    });

    var callback_func = this.callback(this);
    tr.click(function ()
    {
        callback_func();
    });

    var td = jQuery("<td class='dropdown_user_item'></td>");
    td.css({"font-size": ""});
    td.html(this.name);
    //td.appendChild( document.createTextNode( this.name ) );
    tr.append(td);

    return tr.get(0);
};

GRN_OrganizationItem.prototype.isSelected = function()
{
    return this.selected;
};

GRN_OrganizationItem.prototype.setSelected = function( on_off )
{
    this.selected = on_off;
};
