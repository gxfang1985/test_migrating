// time selector DIV
var grn_time_selector_box;
// time selector iframe
var grn_time_selector_box_base;

var grn_start_box;
var grn_end_box;
var grn_start_time;
var grn_end_time;

function grn_show_hide(target, url, target_form_param, grn_start_box_param, grn_end_box_param, kintone_dialog_mode)
{
    grn_start_box = $(target_form_param).elements[grn_start_box_param];
    grn_end_box = $(target_form_param).elements[grn_end_box_param];
    var offset = $(target).cumulativeOffset();

    if (!grn_time_selector_box)
    {
        grn_time_selector_box = document.createElement("div");
        document.body.appendChild(grn_time_selector_box);
        Element.setStyle(grn_time_selector_box, {
            zIndex:100,
            position:"absolute",
            left:kintone_dialog_mode === "1" ? 125 + "px" : 110 + "px",
            top:kintone_dialog_mode === "1" ? (offset[1] + 65) + "px" : (offset[1] - 125) + "px",
            display:"block"
        });
        grn_send_req(url + 'dummy=' + Math.floor(Math.random() * 10000000));
    }
    else
    {
        Element.toggle(grn_time_selector_box);
        if (grn_time_selector_box_base) {
            Element.toggle(grn_time_selector_box_base);
        }
        Element.setStyle(grn_time_selector_box, {
            left:kintone_dialog_mode === "1" ? 125 + "px" : 110 + "px",
            top:kintone_dialog_mode === "1" ? (offset[1] + 65) + "px" : (offset[1] - 125) + "px"
        });
        if (grn_time_selector_box_base) {
            Position.clone(grn_time_selector_box, grn_time_selector_box_base);
        }
    }
}
function grn_send_req(url) {
    var oj = new Ajax.Request(
        url,
        {
            method     : 'GET',
            onComplete : grn_onloaded
        }
    );
}
function grn_onloaded(roj, json){
        grn_time_selector_box.innerHTML = roj.responseText;

        if (Prototype.Browser.IE) {
            grn_time_selector_box_base = document.createElement("iframe");
            if (json.is_https) {
                grn_time_selector_box_base.src = grn_space_url;
            }
            document.body.appendChild(grn_time_selector_box_base);
            Element.setStyle(grn_time_selector_box_base, {
                border:0,
                zIndex:1,
                backgroundColor:"#FFFFFF",
                position:"absolute",
                display:"none"
            });
            Position.clone(grn_time_selector_box, grn_time_selector_box_base);
            Element.toggle(grn_time_selector_box_base);
        }
}
function grn_clear_color()
{
    grn_start_time = null;
    grn_end_time = null;

    for (i = 0; i < 24; i++)
    {
        if (!$('time' + i))
        {
            continue;
        }
        grn_initial_display(i);
    }
}
function grn_close_time_tool()
{
    if (grn_start_time != null && grn_end_time != null)
    {
        for (i = grn_start_time; i < grn_end_time; i++)
        {
            Element.addClassName($('time' + i), 'timeSelectHour_select');
        }
    }
    grn_start_time = null;
    grn_end_time = null;
    Element.hide(grn_time_selector_box);
    if (grn_time_selector_box_base) {
        Element.hide(grn_time_selector_box_base);
    }
}
function grn_time_set(time)
{
    if (grn_start_time == null)
    {
        grn_start_time = time;
        grn_update_display();
    }
    else
    {
        grn_close_time_tool();
    }
}
function grn_end_set(time)
{
    if (grn_start_time != null && grn_start_time <= time)
    {
        grn_end_time = time + 1;
        grn_update_display();
    }
}
function grn_update_display()
{
    if (!grn_end_time)
    {
        grn_end_time = grn_start_time + 1;
    }
    for (i = 0; i < 24; i++)
    {
        if (!$('time' + i))
        {
            continue;
        }
        if (i >= grn_start_time && i < grn_end_time)
        {
            Element.addClassName($('time' + i),  'timeSelectHour_select' );
        }
        else
        {
            grn_initial_display(i);
        }
    }
    grn_change_pull_down();
}
function grn_initial_display(i)
{
    Element.removeClassName($('time' + i),  'timeSelectHour_select' );
    if (i < 12)
    {
        Element.addClassName($('time' + i), 'timeSelectHour_bg00' );
    }
    else if (i >= 12 && i < 18)
    {
        Element.addClassName($('time' + i),  'timeSelectHour_bg01' );
    }
    else if (i >= 18 && i < 24)
    {
        Element.addClassName($('time' + i),  'timeSelectHour_bg02' );
    }
}
function grn_change_pull_down()
{
    if (grn_start_time != null)
    {
        grn_start_box.value = grn_start_time;
    }
    else
    {
        grn_start_box.options[0].selected = true;
    }
    if (grn_end_time != null)
    {
        if (grn_end_time == 24)
        {
            grn_end_box.value = 23;
        }
        else
        {
            grn_end_box.value = grn_end_time;
        }
    }
    else
    {
        grn_end_box.options[0].selected = true;
    }
    
    GRN_Event.fireEvent(grn_start_box, 'change');
    GRN_Event.fireEvent(grn_end_box, 'change');
}
