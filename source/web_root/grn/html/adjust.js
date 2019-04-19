var g_found_start_time = true;
var g_found_display = false;

var g_adjustcount = 0;
var g_view = new Array(4);
g_view[0] = 1;
g_view[1] = 2;
g_view[2] = 3;
g_view[3] = 4;
function add()
{
    if(g_view.length == 0)
    {
        document.getElementById("add_button").style.display = "none";
    }
    else
    {
        g_adjustcount = g_view[0];
        document.getElementById("adjust"+g_adjustcount).style.display = "";
                if (g_found_display) {
                    document.getElementById("adjust"+g_adjustcount+"_display").value = 1;
                }
        g_view.shift();
    }

    if(g_view.length == 0)
    {
        document.getElementById("add_button").style.display = "none";
    }
}
function odf(i)
{
    document.getElementById("adjust"+i).style.display = "none";
        if (g_found_start_time) {
            document.getElementById("start_"+i+"_hour").options[0].selected = true;
            document.getElementById("start_"+i+"_minute").options[0].selected = true;
        }
        if (g_found_display) {
            document.getElementById("adjust"+i+"_display").value = 0;
        }
        g_adjustcount = g_adjustcount-1;
    document.getElementById("add_button").style.display = "";
    g_view.push( i );
    g_view.sort();
}

function grn_set_found_start_time( found_start_time )
{
    g_found_start_time = found_start_time;
}
function grn_set_found_display( found_display )
{
    g_found_display = found_display;
}