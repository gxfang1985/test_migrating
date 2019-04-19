<script language="javascript" type="text/javascript">
{literal}
<!--
var grn_schedule_navi_command_on;

var grn_schedule_navi_cal_url = "{/literal}{grn_pageurl page='schedule/command_navi_calendar_display'}{literal}";

var title_show_calendar = "{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-915' replace='true'}{literal}";
var title_hide_calendar = "{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-916' replace='true'}{literal}";

function grn_schedule_navi_cal()
{
    var icon_tag = window.document.getElementById( 'showIcon-grn' );
    if(YAHOO.util.Dom.hasClass('showIcon-grn', 'showIconOff-grn'))
    {
        Element.show('schedule_calendar');

        Element.show('wait_image');
        if(window.document.getElementById( 'subCalendar-grn-image' ))
        {
            Element.hide('subCalendar-grn-image');
        }
        
        grn_schedule_navi_command_on = true;
        grn_schedule_send_req('on');
        
        YAHOO.util.Dom.removeClass('showIcon-grn', 'showIconOff-grn');
        YAHOO.util.Dom.addClass('showIcon-grn', 'showIconOn-grn');
        
        icon_tag.setAttribute("title", title_hide_calendar);
    }
    else
    {
        if(YAHOO.util.Dom.hasClass('showIcon-grn', 'showIconOn-grn'))
        {
            Element.hide('schedule_calendar');

            grn_schedule_navi_command_on = false;
            grn_schedule_send_req('off');
            
            YAHOO.util.Dom.removeClass('showIcon-grn', 'showIconOn-grn');
            YAHOO.util.Dom.addClass('showIcon-grn', 'showIconOff-grn');
            
            icon_tag.setAttribute("title", title_show_calendar);
        }
    }
}

function grn_schedule_send_req(navi_cal_display_flag)
{
    var post_body = $H({navi_cal_display_flag:navi_cal_display_flag}).toQueryString();
    post_body += '&csrf_ticket={/literal}{$csrf_ticket}{literal}';
    var oj = new Ajax.Request(
        grn_schedule_navi_cal_url, 
        {
            method     : 'POST',
            postBody   : post_body,
            onComplete : grn_schedule_onloaded
        }
    );
}

function grn_schedule_onloaded(roj)
{
    var headers = roj.getAllResponseHeaders();
    var regex = /X-Cybozu-Error/i;
    if( headers.match( regex ) )
    {
        document.body.innerHTML = roj.responseText;
        return false;
    }

    Element.hide('wait_image');
    if(window.document.getElementById( 'subCalendar-grn-image' ))
    {
        Element.show('subCalendar-grn-image');
    }

    if (grn_schedule_navi_command_on)
    {
        Element.show('navi_cal_label_on');
        Element.hide('navi_cal_label_off');
    }
    else
    {
        Element.show('navi_cal_label_off');
        Element.hide('navi_cal_label_on');
    }
}

YAHOO.util.Event.addListener( window.document.getElementById( 'showIcon-grn' ), 'click', grn_schedule_navi_cal );
//-->
{/literal}
</script>