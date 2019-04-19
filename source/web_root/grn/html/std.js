var ua=navigator.userAgent;

function grn_onsubmit_common(form)
{
    var elements = form.elements;
    for( var i = 0 ; i < elements.length ; i ++ )
    {
        if ( elements[i].name && elements[i].name.indexOf("[]") > 0 )
        {
            var options = elements[i].options;
            if( options )
            {
                for( var j = 0 ; j < options.length ; j ++ )
                {
                    options[j].selected = options[j].value ? true : false;
                }
            }
        }
    }
}

function AddMember( fname, cname, sname )
{
    var form = document.forms[fname];
    var c = form.elements[cname].options;
    var u = form.elements[sname].options;
    var i, j;
    for( i = 0 ; i < c.length - 1 ; i ++ )
    {
        var co = c[i];
        if( ! co.selected || ! co.value ) continue;
        var f = false;
        var li = u.length - 1;
        for( j = 0 ; j < li ; j ++ )
        {
            if ( u[j].value == co.value )
            {
                f = true; break;
            }
        }
        if( f ) continue;
        u[u.length] = new Option( u[li].text, "" );
        u[li] = new Option( co.text, co.value, true, true );
    }
}

function RemoveMember( fname, sname )
{
    var u = document.forms[fname].elements[sname].options;
    var li = u.length - 1;
    var i;
    for( i = 0 ; i < li ; i ++ )
    {
        if ( u[i].selected )
        {
            u[i] = null;
            li -=1;
            i-=1;
        }
    }
}

function au(a, id, text) {
    var li = a.length - 1;
    a[a.length] = new Option(a[li].text, "");
    a[li] = new Option(text, id);
    a[li].selected = true;
}

function ag(a, id, text) {
    var li = a.length - 1;
    a[a.length] = new Option(a[li].text, "");
    a[li] = new Option(text, id);
}

function OrderTop( fname, sname )
{
    var i;
    if( grn.browser.msie )
    {
        cb_ui_order_top(fname, sname);
    }
    else
    {
        var form = document.forms[fname];
        var u = form.elements[sname].options;
        var j = 0;
        for( i = 0 ; i < u.length - 1 ; i ++ )
        {
            if( u[i].selected )
            {
                if( i <= 0 ) { break; }
                var nTop = j;
                var nCurrent =i;
                for ( ; nCurrent > nTop ; nCurrent -- )
                {
                    var n = new Option( u[nCurrent].text, u[nCurrent].value );
                    u[nCurrent] = new Option( u[nCurrent-1].text, u[nCurrent-1].value );
                    u[nCurrent].selected = u[nCurrent-1].selected;
                    u[nCurrent-1] = n;
                    u[nCurrent-1].selected = true;
                }
                j++;
            }
        }
    }
}

function OrderUp( fname, sname )
{
    var i;
    if( grn.browser.msie )
    {
        cb_ui_order_up(fname, sname);
    }
    else
    {
        var form = document.forms[fname];
        var selectedItems = form.elements[sname].options;
        for( i = 0 ; i < selectedItems.length - 1 ; i ++ )
        {
            if( selectedItems[i].selected )
            {
                if( i <= 0 ) { break; }
                var n = new Option( selectedItems[i].text, selectedItems[i].value );
                if( selectedItems[i].className == 'approval_facility_item' ){
                    n.className = "approval_facility_item";
                }
                selectedItems[i] = new Option( selectedItems[i-1].text, selectedItems[i-1].value );
                if( selectedItems[i-1].className == "approval_facility_item" ){
                    selectedItems[i].className = "approval_facility_item";
                }
                selectedItems[i].selected = selectedItems[i-1].selected;
                selectedItems[i-1] = n;
                selectedItems[i-1].selected = true;
            }
        }
    }
}

function OrderDown( fname, sname )
{
    var i;
    if( grn.browser.msie )
    {
        cb_ui_order_down(fname, sname);
    }
    else
    {
        var form = document.forms[fname];
        var selectedItems = form.elements[sname].options;
        for( i = selectedItems.length - 2 ; i >= 0 ; i -- )
        {
            if( selectedItems[i].selected )
            {
                if( i >= selectedItems.length - 2 ) { break; }
                var n = new Option( selectedItems[i].text, selectedItems[i].value );
                if( selectedItems[i].className == "approval_facility_item" ){
                    n.className = "approval_facility_item";
                }
                selectedItems[i] = new Option( selectedItems[i+1].text, selectedItems[i+1].value );
                if( selectedItems[i+1].className == "approval_facility_item" ){
                    selectedItems[i].className = "approval_facility_item";
                }
                selectedItems[i].selected = selectedItems[i+1].selected;
                selectedItems[i+1] = n;
                selectedItems[i+1].selected = true;
            }
        }
    }
}

function OrderBottom( fname, sname )
{
    var i;
    if( grn.browser.msie )
    {
        cb_ui_order_bottom(fname, sname);
    }
    else
    {
        var form = document.forms[fname];
        var u = form.elements[sname].options;
        var j = u.length - 2;
        for( i = u.length - 2 ; i >= 0 ; i -- )
        {
            if( u[i].selected )
            {
                if( i >= u.length - 2 ) { break; }
                var nBottom = j;
                var nCurrent =i;
                for ( ; nCurrent < nBottom ; nCurrent ++ )
                {
                    var n = new Option( u[nCurrent].text, u[nCurrent].value );
                    u[nCurrent] = new Option( u[nCurrent+1].text, u[nCurrent+1].value );
                    u[nCurrent].selected = u[nCurrent+1].selected;
                    u[nCurrent+1] = n;
                    u[nCurrent+1].selected = true;
                }
                j--;
            }
        }
    }
}

function popupWin(Aurl,Aname,Awidth,Aheight,Atoolbar,Alocation,Astatus,Ascroll,Amenu,Aresize)
{
  var Astr = "";
  var openwindow;
  if(Awidth != "")Astr+= "width=" + Awidth;
  if(Astr != "")Astr+=",";
  if(Aheight != "")Astr+= "height=" + Aheight;
  if(Astr != "")Astr+=",";
  if(Atoolbar)Astr+= "toolbar";
  if(Alocation)Astr+= ",location";
  if(Astatus)Astr+= ",status";
  if(Ascroll)Astr+= ",scrollbars";
  if(Amenu)Astr+= ",menubar";
  if(Aresize)Astr+= ",resizable";
  openwindow = window.open(Aurl,Aname,Astr);
  openwindow.focus();
}

function popupWin_returnWin(Aurl,Aname,Awidth,Aheight,Atoolbar,Alocation,Astatus,Ascroll,Amenu,Aresize)
{
  var Astr = "";
  var openwindow;
  if(Awidth != "")Astr+= "width=" + Awidth;
  if(Astr != "")Astr+=",";
  if(Aheight != "")Astr+= "height=" + Aheight;
  if(Astr != "")Astr+=",";
  if(Atoolbar)Astr+= "toolbar";
  if(Alocation)Astr+= ",location";
  if(Astatus)Astr+= ",status";
  if(Ascroll)Astr+= ",scrollbars";
  if(Amenu)Astr+= ",menubar";
  if(Aresize)Astr+= ",resizable";
  openwindow = window.open(Aurl,Aname,Astr);
  openwindow.focus();

  return openwindow;
}

/**
 * @return {boolean}
 */
function IsAliveWindow( winVar )
{
  var ua = navigator.userAgent;
  if( !! winVar )
  {
    if( ua.indexOf("Gecko")!=-1 && ua.indexOf("Win")!=-1 )
    {
      if ( winVar.closed )
      {
        return false;
      }
    }
    else
    {
      if( typeof( winVar.document ) != "object" )
      {
        return false;
      }
    }
  }
  else
  {
    return false;
  }

  return true;
}

function postdata(fname)
{
    var form = document.forms[fname];
    form.submit();
}

function interval(fname,time)
{
    setTimeout("postdata(\'"+fname+"\')",time);
}

/**
 * @name grn_is_checked
 * @description
 *  if one of checkboxes that have name 'target_name' is checked, return true.
 *  otherwise, return false.
 *  elements that have name 'target_name' should be checkbox.
 */
function grn_is_checked( form, target_name )
{
    var elements = form.elements;
    var is_checked = false;
    for( var i = 0; i < elements.length; i++ )
    {
        if ( elements[i].name == target_name )
        {
            if ( elements[i].checked )
            {
                is_checked = true;
                break;
            }
        }
    }
    return is_checked;
}

/**
 * @name grn_is_selected
 * @description
 *  if one of options of the specified select that have name 'target_name' is selected, 
 *  return true. otherwise, return false.
 *  elements that have name 'target_name' should be 'select'.
 */
function grn_is_selected( form, target_name )
{
    var elements = form.elements;
    var is_selected = false;
    var options;
    for( var i = 0; i < elements.length; i++ )
    {
        if ( elements[i].name == target_name )
        {
            options = elements[i].options;
            for( var j = 0; j < options.length; j++ )
            {
                if ( options[j].selected )
                {
                    is_selected = true;
                    break;
                }
            }
        }
    }
    return is_selected;
}

function grn_add_option( select_obj, value, text )
{
    var last = select_obj.length - 1;
    select_obj[select_obj.length] = new Option( select_obj[last].text, "" );
    select_obj[last] = new Option( text, value );
}

var dp_id;
function display_pulldown(id) {
    if ((dp_id) && (id != dp_id)) {
        document.getElementById(dp_id).style.display = "none";
    }
    var e = document.getElementById(id);
    if (e && e.style) {
        if (e.style.display == "none") e.style.display = "";
        else e.style.display = "none";
    }
    dp_id = id;
}

function button_pulldown(id) {
    if ((dp_id) && (id != dp_id)) {
        document.getElementById(dp_id).style.visibility = "hidden";
    }
    var e = document.getElementById(id);
    if (e && e.style) {
        if (e.style.visibility == "hidden") e.style.visibility = "visible";
        else e.style.visibility = "hidden";
    }
    dp_id = id;
}

/**
 * Get index add option
 * @param value : add option value
 * @param dest  : target
 * @param sort  : sort list
 * @return int index
 **/
function GetInsertIndex( value, dest, sort )
{
    var is_index = false;
    for( var k = 0; k < sort.length; k++)
    {
        if( sort[k] == value )
        {
            is_index = true;
        }
    }
    if( ! is_index ) return -1;

    var index = 0;
    for( var i = 0; i < dest.length - 1; i++)
    {
        var is_found = false;
        for( var j = 0; j < sort.length; j++ )
        {
            if( sort[j] == value )
            {
                break;
            }
            if( sort[j] == dest[i].value )
            {
                index++;
                is_found = true;
                break;
            }
        }
        if( ! is_found ) break;
    }
    return index;
}
/**
 * move option(index)
 * @param form  : this form
 * @param sname : select name
 * @param cname : string candidate name
 * @param index : index list #delimiter(:)
 **/
function MoveOption( form, sname, cname, index )
{
    var s = form.elements[sname].options;
    var c = form.elements[cname].options;
    var sort, co, so;

    if( index != null )
    {
        sort = index.split(':');
    }

    // all unselected
    for( var k = 0; k < c.length; k++ )
    {
        co = c[k];
        if( ! co.selected ) continue;
        co.selected = false;
    }

    // add
    for( var j = 0; j < s.length - 1; j++ )
    {
        so = s[j];
        if( ! so.selected || ! so.value ) continue;
        var o = document.createElement('OPTION');
        o.value = so.value;
        o.text = so.text;
        o.selected = true;

        if( sort != null )
        {
            var order = GetInsertIndex( o.value, c, sort );
            if( order >= 0 )
            {
                c.add( o, order );
            }
        }
        else
        {
            var cl = c.length - 1;
            c.add( o, cl );
        }
    }

    // delete
    var sl = s.length - 1;
    for( var i = 0; i < sl; i++ )
    {
        if( s[i].selected )
        {
            s[i] = null;
            sl -= 1;
            i -= 1;
        }
    }
}

function insertText(fobj,target)
{
    var txt = target.value;
    var id = fobj.selectedIndex;
    if(fobj.options[id].value)
    {
        txt += inText[fobj.options[id].value];
        txt += "\n";
        target.value = txt;
    }
}

function changeDate(form,sobj,year,month,day)
{
    var y = sobj + "year";
    var m = sobj + "month";
    var d = sobj + "day";
    var i;
    for(i=0;i<form.elements[y].options.length;i++)
    {
        if(form.elements[y].options[i].value == year)
        {
            form.elements[y].options[i].selected = true;
            form.elements[y].onchange();
        }
    }
    for(i=0;i<form.elements[m].options.length;i++)
    {
        if(form.elements[m].options[i].value == month)
        {
            form.elements[m].options[i].selected = true;
            form.elements[m].onchange();
        }
    }
    for(i=0;i<form.elements[d].options.length;i++)
    {
        if(form.elements[d].options[i].value == day)
        {
            form.elements[d].options[i].selected = true;
            form.elements[d].onchange();
        }
    }
}

function selectOff(type,form,name)
{
    var i;
    if(type == "ymd")
    {
        var y = name + "year";
        var m = name + "month";
        var d = name + "day";
        form.elements[y].disabled = true;
        form.elements[m].disabled = true;
        form.elements[d].disabled = true;
    }
    if(type == "cbx")
    {
        form.elements[name].disabled = true;
        var l = document.getElementsByTagName("label");
        for(i=0;i<l.length;i++)
        {
            var forName = l[i].getAttributeNode("for");
            if(forName.nodeValue == "time_stump1")
            {
                l[i].className = "form_disable";
            }
        }
    }
}

function selectOn(type,form,name)
{
    var i;
    if(type == "ymd")
    {
        var y = name + "year";
        var m = name + "month";
        var d = name + "day";
        form.elements[y].disabled = false;
        form.elements[m].disabled = false;
        form.elements[d].disabled = false;
    }
    if(type == "cbx")
    {
        form.elements[name].disabled = false;
        var l = document.getElementsByTagName("label");
        for(i=0;i<l.length;i++)
        {
            var forName = l[i].getAttributeNode("for");
            if(forName.nodeValue == "time_stump1")
            {
                l[i].className = "";
            }
        }
    }
}

function typeChange(fname,e,v)
{
    var f = document.forms[fname];
    var d = f.elements[e];
    if(d[v].checked)
    {
        selectOn("ymd",f,"end_");
        selectOff("ymd",f,"start_");
    }
}

var dp_of;
function display_on_off(id) {
    var inID, e, i;
    if (id.match(/:/)) {
        inID = id.split(':');
        if (inID.length > 0) {
            for (i = 0; i < inID.length; i++) {
                e = document.getElementById(inID[i]);
                if (e && e.style) {
                    if (e.style.display == "none") e.style.display = "";
                    else e.style.display = "none";
                }
            }
        }
    }
    else {
        if ((dp_of) && (id != dp_of)) {
            document.getElementById(dp_id).style.display = "none";
        }
        e = document.getElementById(id);
        if (e && e.style) {
            if (e.style.display == "none") e.style.display = "";
            else e.style.display = "none";
        }
        dp_of = id;
    }
}

function display_on(id)
{
    document.getElementById(id).style.display = "";
}

function display_off(id)
{
    document.getElementById(id).style.display = "none";
}

function display_on_off_check_by_name(form, name)
{
    var elements = document.getElementsByName(name);
    for(var i=0; i < elements.length; i++)
    {
        var e = elements[i];
        if (e && e.style)
        {
            if(form.checked) e.style.display = "";
            else e.style.display = "none";
        }
    }
}

function radio_select( fname, cname, sname )
{
    var form = document.forms[fname];
    var c = form.elements[cname];
    var i;
    for( i = 0 ; i < c.length ; i ++ )
    {
        if( c[i].value == sname )
        {
            c[i].checked = true;
        }
    }
}

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
    var i;
    for(i = 0 ; i < u.length - 1 ; i ++)
    {
        if(u[i].selected)
        {
            if(i == 0) { j++; continue; }
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

function grn_check_all(form, element_name)
{
    var e = form.elements;
    var l = e.length;
    var checked = false;
    var i;
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == element_name && ! e[i].checked  ) { checked = true; } }
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == element_name) { e[i].checked=checked; } }
}

var tpid = 0;
var tpleft = 0;
var tptop = 0;
var tpval = null;
function tpon(ev, val)
{
    if(tpid != 0) clearTimeout(tpid);
    tpleft = ev.clientX + document.body.scrollLeft + 5;
    tptop = ev.clientY + document.body.scrollTop + 15;
    tpval = val;
    tpid = setTimeout("tpvis()", 500);
}

function tpvis()
{
    var tp = document.getElementById("TTip");

    if(tp == null)
    {
        tp = document.createElement("div");
        tp.setAttribute("id", "TTip");
        document.body.appendChild(tp);

        with (tp.style) {
            position = "absolute";
            backgroundColor =  "#ffffdd";
            width = "auto";
            borderStyle = "solid";
            borderWidth = "1px";
            padding = "2px";
            fontSize = "12px";
            zIndex = 1000;
        }
    }

    if((tp) && tpval != "")
    {
        var winwidth = document.body.clientWidth + document.body.scrollLeft;
        if((tpleft + 100) > winwidth) tpleft -= ((tpleft + 100) - winwidth);
        var winheight = document.body.clientHeight + document.body.scrollTop;
        if((tptop + 70) > winheight) tptop -= ((tptop + 70) - winheight);
        tp.style.left = tpleft + "px";
        tp.style.top = tptop + "px";
        tp.innerHTML= tpval;
        tp.style.visibility = "visible";
    }
}

function tpoff()
{
    if(tpid != 0) clearTimeout(tpid);
    tpid = 0;
    tpleft = 0;
    tptop = 0;
    tpval = null;
    var tp = document.getElementById("TTip");
    if(tp) tp.style.visibility = "hidden";
}

/**
 * For User Group List
 */

function GRN_GroupItem( gid, name, callback, selected, extra_param ) {
    this.gid = gid;
    this.name = name;
    this.callback = callback;
    this.selected = selected;
    this.extra_param = extra_param;
}

GRN_GroupItem.prototype.getHtml = function(){
    var html = '<a id="grn_group_item_' + this.gid + '"' ;
    
    if ( this.selected ) {
        html += ' class="selected_item dropdown_item"';
    } else {
        html += ' class="dropdown_item"';
    }
    
    html += ' onClick="' + this.callback + "('" + this.gid + "', '" + escape( this.name ) + "'" + ", '"+ escape(this.extra_param ) + '\');"';
    html += "onMouseOver='javascript:YAHOO.util.Dom.addClass( this, \"user_group_hover\");' onMouseOut='javascript:YAHOO.util.Dom.removeClass( this, \"user_group_hover\");' ";
    html += ' ><nobr>' + this.name + '</nobr></a>';
    return html;
};

GRN_GroupItem.prototype.isSelected = function() {
    return this.selected;
};

GRN_GroupItem.prototype.setSelected = function( on_off ) {
    this.selected = on_off;
};

function GRN_GroupItemManager( el_group_item ){
    this.el_group_item = el_group_item;
    this.items = [];
}

GRN_GroupItemManager.prototype.appendItem = function( item ) {
    this.items.push( item );
};

GRN_GroupItemManager.prototype.draw = function(){
    var html = '';
    for( var i =0; i < this.items.length; i++ ) {
        html += this.items[i].getHtml();
    }
    this.getEl().innerHTML = html;
};

GRN_GroupItemManager.prototype.getEl = function(){
    return this.el_group_item ;
};

GRN_GroupItemManager.prototype.getSelectedItem = function(){
    for( var i = 0; i< this.items.length; i++ ) {
        if ( this.items[i].isSelected() ) {
            return this.items[i];
        }
    }
};

GRN_GroupItemManager.prototype.selectItem = function( gid ) {
    for( var i = 0; i< this.items.length; i++ ) {
        this.items[i].setSelected( this.items[i].gid == gid );
    }
};

GRN_GroupItemManager.prototype.getItem = function( gid ) {
    for( var i = 0; i< this.items.length; i++ ) {
        if ( this.items[i].gid == gid ) {
            return this.items[i];
        }
    }
    return false;
};

function isSafari() {
    var ua = navigator.userAgent;
    var m = ua.match(/AppleWebKit\/(\d+)/);
    if ( m&&m[1] ) {
        return true;
    }
    return false;
}

function grn_split_tags(data, length) {
    var max_len = 100;
    var str = "";
    var truncate_str = "";
    var escapeHTML_str = "";
    var ret = "";

    if (length == undefined) length = max_len;

    str = data.replace(/<\/?[^>]+>/gi, '')
        .replace(/&nbsp;/g, ' ')
        .replace(/\n/g, " ")
        .replace(/\s+/g, " ")
        .trim()
        .replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');

    truncate_str = truncate(str, length + 3, "...");
    var tmp_div = jQuery("<div id='tmpdiv'></div>");
    var tmp_div_text = tmp_div.text(truncate_str.replace(/(.{10})/g, "$1&lt;wbr&gt;"));
    escapeHTML_str = tmp_div_text.html();

    ret = escapeHTML_str.replace(/(&amp;lt;wbr&amp;gt;)/g, "<wbr>");

    return ret;
}

function truncate(str, length, suffix) {
    var slice_length = length;
    if (suffix.length > 0) {
        slice_length = length - suffix.length;
    }

    if (slice_length >= str.length) {
        return str;
    }
    else {

        return str.slice(0, slice_length) + suffix;
    }
}

/*
 * common function for delete follow.
 */
function on_before_delete_follow(form, params) {
    var follow_id = this.id.split("_").pop();

    //default prefix is follow_
    var follow_data_id = "follow_" + follow_id;
    if (params.follow_prefix) {
        follow_data_id = params.follow_prefix + follow_id;
    }
    var follow_data = grn_split_tags(document.getElementById(follow_data_id).innerHTML);

    //insert follow data to popup
    var msgbox_follow = jQuery(form).find("span").filter(function () {
        return jQuery(this).attr("id") == "msgbox_follow";
    }).eq(0);
    if (msgbox_follow.length >0) {
        jQuery(msgbox_follow).html(follow_data);
    }
    //add follow id to hidden field
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", params.follow_id);
    input.setAttribute("value", follow_id);

    form.appendChild(input);
}

var Cb_i18n = {
    cb_msg : function( text, keys, replaces ){
        var ret = text;
        for( var i = 0; i < keys.length; i++ ) {
            ret = ret.replace( '&&'+keys[i]+'&&', replaces[i], 'g' );
        }
        return ret;
    }
};

var GRN_Window = (function(){
    return {
        getWidth: function(){
            if(window.innerWidth) return window.innerWidth; // Mozilla, Opera, NN4
            if(document.documentElement && document.documentElement.clientWidth){ // 以下 IE
                return document.documentElement.clientWidth;
            }else if(document.body && document.body.clientWidth){
                return document.body.clientWidth;
            }
            return 0;
        },
        getHeight: function(){
            if(window.innerHeight){ // Mozilla, Opera, NN4
                return window.innerHeight;
            }
            if(document.documentElement && document.documentElement.clientHeight){ // 以下 IE
                return document.documentElement.clientHeight;
            }
            if(document.body && document.body.clientHeight){
                return document.body.clientHeight;
            }
            return 0;
        }
    };
}());

function displayTimeZone( check_id, display_member_tz_url, csrf_ticket, is_confirm )
{
    var checkbox = jQuery("#" + check_id);
    var scheduleWrapper = jQuery("table.scheduleWrapperTimezoneBar").eq(0);
    var bar_login_timezones = scheduleWrapper.find("tr.bar_login_timezone");
    var bar_user_timezones = scheduleWrapper.find("tr.bar_user_timezone");
    var member_tz = 0;
    if (checkbox.prop( "checked" )) {
        bar_user_timezones.each(function () {
            jQuery(this).css({display: ""});
        });
        bar_login_timezones.each(function () {
            jQuery(this).css({display: "none"});
        });
        member_tz = 1;
    }
    else {
        bar_user_timezones.each(function () {
            jQuery(this).css({display: "none"});
        });
        bar_login_timezones.each(function () {
            jQuery(this).css({display: ""});
        });
        member_tz = 0;
    }

    var ajaxRequest = new grn.component.ajax.request(
        {
            url: display_member_tz_url,
            method: "post",
            data: "member_tz=" + member_tz + "&csrf_ticket=" + csrf_ticket + "&confirm=" + is_confirm,
            grnRedirectOnLoginError: true
        });

    ajaxRequest.send()
}

var GRN_Event = {
    fireEvent: function(element, event){
        var eventObject;
        if( typeof document.createEvent !== 'undefined' ){
            eventObject = document.createEvent("HTMLEvents");
            eventObject.initEvent(event, true, true );
            return !element.dispatchEvent(eventObject);
        }else if ( typeof document.createEventObject !== 'undefined' ){
            //for on and before IE8
            eventObject = document.createEventObject();
            return element.fireEvent('on'+event,eventObject);
        }
        return false;
    },
    keyCode: function(event){
        if(document.all){
            return event.keyCode;
        }else if(document.getElementById){
            return (event.keyCode) ? event.keyCode : event.charCode;
        }else if(document.layers){
            return event.which;
        }
        return false;
    }
};

function fastGetElementsByClassName(id, tag_name, class_name)
{
    var parent_ele = $(id);
    var ret = [];
    if(parent_ele)
    {
        var child_eles = parent_ele.getElementsByTagName(tag_name);
        var tmp_ele = null;
        for ( var i=0;i<child_eles.length;i++ )
        {
            tmp_ele = child_eles[i];
            if( tmp_ele.className.indexOf(class_name) != -1 )
                ret.push($(tmp_ele));
        }
    }
    return ret;
}

function HideApplicationMenu() {
    var applicationMenu = jQuery("#applicationMenu");
    var appmenuToggler = jQuery("#appmenuToggler");
    appmenuToggler.attr("class", "appmenuCollapse");
    applicationMenu.css({display: "none"});
}

function ShowApplicationMenu() {
    var applicationMenu = jQuery("#applicationMenu");
    var appmenuToggler = jQuery("#appmenuToggler");
    appmenuToggler.attr("class", "appmenuExpand");
    applicationMenu.css({display: "block", height: ""});
}

function ToggleApplicationMenu() {
    var applicationMenu = jQuery("#applicationMenu");
    var appmenuToggler = jQuery("#appmenuToggler");
    var state = 1;
    var Dom = YAHOO.util.Dom;
    var myAnim, appHeight;
    if (appmenuToggler.hasClass("appmenuExpand")) {
        state = 0;
    }
    if (state == 0) {
        myAnim = new YAHOO.util.Anim(applicationMenu[0], {height: {to: 1}}, 0.3, YAHOO.util.Easing.easeOut);
        myAnim.onComplete.subscribe(HideApplicationMenu);
        myAnim.animate();
    } else {
        ShowApplicationMenu();
        appHeight = Dom.getRegion(applicationMenu).height;
        myAnim = new YAHOO.util.Anim(applicationMenu[0], {
            height: {
                from: 1,
                to: appHeight
            }
        }, 0.3, YAHOO.util.Easing.easeOut);
        myAnim.onComplete.subscribe(function () {
            applicationMenu.css({height: ""});
        });
    }

    var ajaxRequest = new grn.component.ajax.request(
        {
            url: command_show_hide_applicationMenu_url,
            method: "post",
            data: "stateApplication=" + state,
            grnRedirectOnLoginError: true
        });

    ajaxRequest.send()
}

function fastGetElementsByName(id, tag_name, name)
{
    var parent_ele = null;
    if( typeof(id) == 'object' )
        parent_ele = id;
    else
        parent_ele = document.getElementById(id);
    
    var ret = [];
    if(parent_ele)
    {
        var child_eles = parent_ele.getElementsByTagName(tag_name);
        var tmp_ele = null;
        for ( var i=0;i<child_eles.length;i++ )
        {
            tmp_ele = child_eles[i];
            if( tmp_ele.name == name )
                ret.push(tmp_ele);
        }
    }
    return ret;
}

/**
 * Add content to the iframe.
 * @param {!HTMLIFrameElement} iframe An iframe with no contents
 * @param {string} bodyContent Content to go into iframe's body
 * @return {Object} IFrame document
 */
function setIFrameContent(iframe, bodyContent, base_url) {
    if (!iframe) { return; }

    var fdocument = iframe.contentDocument || iframe.contentWindow.document;
    fdocument.head.innerHTML = '<meta http-equiv="X-UA-Compatible"><base href="' + base_url + '" target="_parent">';
    fdocument.body.style.margin = 0;
    fdocument.body.innerHTML = bodyContent;
    if(typeof(resize) === 'function')
    {
        resize();
    }

    return fdocument;
}

/**
 * Check touch device
 */
function isTouchDevice(){
    var retsts = ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch);
    if( (typeof browser_type != "undefined") && (browser_type == 'msie') && (browser_ver_major >= 10) )
    {
        retsts = ( window.navigator.msMaxTouchPoints > 0 );
    }
    return retsts;
}

function cumulativeOffset(element) {
    var valueT = 0, valueL = 0;
    do {
        valueT += element.offsetTop || 0;
        valueL += element.offsetLeft || 0;
        element = element.offsetParent;
    } while (element);

    return returnOffset(valueL, valueT);
}

function cumulativeOffsetByOffsetParent(element, parent) {
    var valueT = 0, valueL = 0;
    do {
        valueT += element.offsetTop || 0;
        valueL += element.offsetLeft || 0;
        element = element.offsetParent;
    } while (element && element !== parent);

    return returnOffset(valueL, valueT);
}

function returnOffset(l, t) {
    var result = [l, t];
    result.left = l;
    result.top = t;
    return result;
}

function BuilderDropdownColorControl(dialogId)
{
    (function($){
        if(dialogId != undefined){
            selectionElement = $("div#" + dialogId + " select[name=menu]").addClass("hidden");
        }else{
            selectionElement = $("select[name=menu]");
        }
        if(selectionElement.length <= 0){
            return;
        }else{//in the case not set hidden for selection control
            selectionElement.addClass("hidden");
        }
        holderColorPicker = $("<dl/>",{'class':'pulldownbutton_standard_grn event_menu_grn'});
        //The logic align top tile control
        var inpel = selectionElement.parent().children("input");
        var ieformat ='';
        inpel.css("margin-top","0");
        //end

        //GTM-831
        var ua = navigator.userAgent.toLowerCase();
        var is_safari = ua.indexOf('safari') > -1 && ua.indexOf('version') > -1;
        var version = is_safari ? ua.match(/version\/([\d\.]+)/i)[1].substr(0,1) : null;

        if (is_safari && version == '5') {
            layout = $("<div />",{'class':'event_add_base_grn fleft'}).append($("<div />",{'class':'mRight3 fleft'}).css('padding-top',ieformat).append(holderColorPicker)).append($("<div />").addClass("fleft"));
        } else {
            layout = $("<div />",{'class':'event_add_base_grn fleft'}).append($("<div />",{'class':'mRight3 fleft'}).css('padding-top',ieformat).append(holderColorPicker)).append($("<div />").addClass("fleft").append(inpel));
        }
        //GTM-831 end
        layout.prependTo(selectionElement.parent());//dl

        var optionRows = selectionElement.children();
        var textDefault = optionRows.first().text();//------------
        var pattern = /(^.*);#(.*)/i;
        var span_color = $("<span/>");
        var data, ar, ev_me_tit, ev_me_class, curob;
        //standard data option rows; (remove delemiter)

        $.each(optionRows, function(index,obj){
            curob = $(this);
            data = curob.val();
            ar = pattern.exec(data);
            if(ar != null && ar.length > 0){
                ev_me_tit = ar[1];
                ev_me_class = ar[2];
                if(ev_me_class == ""){//edit section > option
                    curob.val(ev_me_tit);//remove delemiter ;#
                }
            }
        });
        var span_text = $("<span/>",{'class':'mRight3',text:textDefault});
        var span_up_down = $("<span/>",{'class':'pulldownbutton_arrow_down_grn'});
        var ael = $("<a/>",{href:"javascript:void(0)"}).append(span_color).append(span_text).append(span_up_down);//header
        holderColorPicker.append($("<dt/>",{style:'margin:0;padding:0'}).append(ael))
            .append($("<dd/>",{style:'margin:0;padding:0'}).append($("<ul/>",{'class':'dropdownContents_grn js_customization_appointment_type'})));
        //Sort appointment type

        var user_entry = new Array();
        var ad_entry = new Array();

        var i = 0, j = 0, k = 0;
        var ind = 0, data;

        for(var ii = 0; ii < optionRows.length; ii++){
            data = $(optionRows[ii]).val();
            if(data == ""){
                ind = ii;
                break;
            }
        }
        //separate data
        for(var u = ind + 1; u < optionRows.length; u++){
            data = $(optionRows[u]).val();
            ar = pattern.exec(data);
            if(ar != null && ar.length > 0){
                ev_me_tit = ar[1];
                ev_me_class = ar[2];

                if(ev_me_tit != ""){
                    if(ev_me_class == ""){//user entry
                        user_entry[i] = new Array(ev_me_tit,ev_me_class);
                        i++;
                    }else{
                        ad_entry[k] = new Array(ev_me_tit,ev_me_class);
                        k++;
                    }
                }
            }else if(data != null){
                user_entry[i] = new Array(data,'');
                i++;
            }
        }
        var ulel = holderColorPicker.find("ul");
        var leng_w = 0;
        var is_Japanese = 0;
        var have_Japanese = 0;
        ulel.css({'z-index':'986','max-height':'300px','overflow':'auto','overflow-x': 'hidden','-ms-overflow-x': 'hidden'});
        if(dialogId != undefined){
            ulel.css({'z-index':'1501'});// allway the top and infront "v" icon simple add form
        }
        //loop on the set of data
        //0 default option
        if(ind != 0){// edit or reuse
            var ite = optionRows.first();
            var data = ite.val();
            var a = pattern.exec(data);
            if(a != null && a.length > 0)
            {
                ev_me_tit = a[1];
                ev_me_cl = a[2] != 0 ? a[2] : "_none";
                ulel.append($('<li />',{ca:ev_me_cl,te:ev_me_tit}).append($("<a/>",{href:'javascript:void(0)'}).append($("<span/>",{'class':"event_menu_color" + ev_me_cl + "_grn mRight2"})).append($("<span/>",{text:ev_me_tit}))));
            }else if(data != ""){// in the case option not have css class
                ulel.append($('<li/>',{ca:'',te:data}).append($("<a/>",{href:'javascript:void(0)'}).append($("<span/>",{'class':"mRight2"})).append($("<span/>",{text:data}))));
            }
        }
        // separate row
        var separate_text = $(optionRows[ind]).text();
        ulel.append($('<li/>',{ca:'',te:separate_text}).append($("<a/>",{href:'javascript:void(0)'}).append($("<span/>",{'class':"mRight2"})).append($("<span/>",{text:separate_text}))));
        //1
        $.each(user_entry,function(index, obj){
            var ev_me_tit = obj[0];
            if(ev_me_tit != ""){
                ulel.append($('<li/>',{ca:'',te:ev_me_tit}).append($("<a/>",{href:'javascript:void(0)'}).append($("<span/>",{'class':"mRight2"})).append($("<span/>",{text:ev_me_tit}))));
            }
        });
        //3
        $.each(ad_entry,function(index, obj){
            if(obj[0] != ""){
                ev_me_cl = obj[1]!= 0 ? obj[1] : "_none";
                ulel.append($('<li/>',{ca:obj[1],te:obj[0]}).append($("<a/>",{href:'javascript:void(0)'}).append($("<span/>",{'class':"event_menu_color" + ev_me_cl + "_grn mRight2"})).append($("<span/>",{text:obj[0]}))));
            }
        });

        if(ulel.height() > 299){
            ulel.css({'width' : ulel.width() + 15 });
        }
        if(ulel.width() < 47){
            ulel.css({'width' : 45});
        }
        ael.click(function(e) {
            ulel.toggle();
            var clss = $(($(this).children())[2]).attr('class');

            if(clss == 'undefined' || clss == 'pulldownbutton_arrow_up_grn' || clss == '' ){
                $(this).children(".pulldownbutton_arrow_up_grn").removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            }
            else{
                $(this).children(".pulldownbutton_arrow_down_grn").removeClass("pulldownbutton_arrow_down_grn").addClass("pulldownbutton_arrow_up_grn");
            }
        });
        //User click item li
        ulel.children("li").click(function() {
            var sel = $(this).attr('ca');
            var text = $(this).attr('te');
            var class_mapping = "";
            if(text == ""){
                text = $(this).children("a").children("span:first").text();
                sel = "";
            }

            var changeMenu = function()
            {
                span_text.text(text);
                if(sel != "" && sel != "0"){
                    var class_mapping = "event_menu_color" + sel + "_grn";
                }else if(sel != "" && sel == "0"){
                    class_mapping = "event_menu_color_none_grn";
                }
                span_color.attr('class', '').addClass(class_mapping + " mRight2");
                span_up_down.removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
                //re selected
                selectionElement.find(":selected").prop("selected", false);
                optionRows.filter(function() {
                    if(text == separate_text)
                        text = "";
                    return $(this).val() == text + (sel != "" ? ";#" + sel : "");
                }).prop('selected', true).trigger('change',[true]);

                ulel.hide();
            };

            var needConfirmation = false;
            $("input[id^=app_item_]").each(function() {
                if (typeof grn.page.schedule.kintoneRelation.showMenuChangeDialog === "function")
                {
                    var itemId = $(this).attr("id").substr(4);
                    if (grn.page.schedule.kintoneRelation.isAllMenuItem(itemId))
                    {
                        return;
                    }
                }

                var val = $(this).val();
                if (typeof val !== "undefined" && val !== "")
                {
                    needConfirmation = true;
                }
            });
            if (needConfirmation && typeof grn.page.schedule.kintoneRelation.showMenuChangeDialog === "function")
            {
                grn.page.schedule.kintoneRelation.showMenuChangeDialog(changeMenu);
            }
            else
            {
                changeMenu();
            }
        });
        // bin event click docment range
        var holder = $(document);
        if(dialogId != undefined){
            holder= $("div#" + dialogId);
        }
        holder.bind('click', function(e) {
            var clicked = $(e.target);
            if (! $(clicked.parents()).hasClass("pulldownbutton_standard_grn"))
            {
                ulel.hide();
                ael.children("span.pulldownbutton_arrow_up_grn").removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            }
        });
        //the logic for reuse
        var ite = optionRows.first();
        data = ite.val();
        var a = pattern.exec(data);
        if(a != null && a.length > 0)
        {
            var ev_me_tit = a[1];
            var ev_me_cl = a[2] != 0 ? a [2] : "_none";// none color by administrator setting
            ite.val(data).text(ev_me_tit);
            span_text.text(ev_me_tit);
            span_color.attr('class', '').addClass("event_menu_color" + ev_me_cl + "_grn" + " mRight2");
        }

    })(jQuery);
}