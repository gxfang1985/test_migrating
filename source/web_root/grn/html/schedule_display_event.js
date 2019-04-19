check_show_tooltip_schedule = true;
check_mouse_over_event_content = false;
resizing = false;
is_dragging = false;
during_dragdrop = false; // flag checking whether drag drop or not to reset position of schedule
var time_after_drag_drop;
var is_revert = false;
oneHourHeight = 40; // height of one hour is 40 pixel
halfHourHeight = 20; // height of half hour is 20 pixel
function display_personal_day_UI(params)
{
    jQuery(params.container_timesheet).GRN_Draw_Time_Sheet(params.begin_day,params.end_day);
    jQuery(params.container_normal).GRN_Schedule_ShowEvent(params.options);
    jQuery(params.container_allday).GRN_Schedule_ShowAllDayEvents(params.options_allday);
    if(jQuery(params.container_banner))
    {
        jQuery(params.container_banner).GRN_Schedule_ShowBannerDayEvents(params.options_banner);
    }
    
    setTimeout(function(){
        if(isTouchDevice())
        {
            return;
        }
        
        jQuery('div.event_content').GRN_Schedule_TooltipEvent();

        if(typeof params.do_not_have_using_privilege != 'undefined' && params.do_not_have_using_privilege == 1)
        {
            return;
        }

        var time_els = jQuery(params.container_timesheet).find('div.add_quick');
        time_els.prop('dblclick', false);
        time_els.dblclick(function(e){
            GRN_ScheduleSimpleAdd.doubleClickPersonalHandler(e);
        });
        if(params.ajax)
        {
            GRN_ScheduleSimpleAdd.Dialog.Highlight();
        }
        
        if(enable_dragdrop == 0)
        {
            // disable drag drop schedule when deactive D&D
            return;
        }
        
        if(typeof params.plid != 'undefined')
        {
            jQuery(params.container_list_event).GRN_DragDropSchedule_Personal(true,params.plid);
        }
        else
        {
            jQuery(params.container_list_event).GRN_DragDropSchedule_Personal(true);
        }
        jQuery('div.critical3').GRN_DragDropScheduleVertical_Personal();
    },0);
}

function display_personal_week_UI(params)
{
    jQuery(params.container_timesheet).GRN_Draw_Time_Sheet(params.begin_day,params.end_day);
    for(var i=0; i< params.data.length; i++)
    {
        var data_event = params.data[i];
        
        var plid = '',
            container_normal = '#'+data_event.date_type+'_'+data_event.date,
            container_allday = '#personal_week_event_notime_'+data_event.date_type+'_'+data_event.date;
        if(typeof params.plid != 'undefined')
        {
            plid = params.plid;
            container_normal += '_' + plid;
            container_allday += '_' + plid;
            list_data_event[plid][data_event.date] = [];
        }
        else
        {
            list_data_event[data_event.date] = [];
        }
        
        var options = {
                        data          : data_event.event,
                        bdate         : data_event.date,
                        uid           : params.uid,
                        gid           : params.gid,
                        referer_key   : params.referer_key,
                        page          : 'schedule/view',
                        week          : 1,
                        unit          : unit,
                        begin_day     : params.begin_day,
                        end_day       : params.end_day,
                        plid          : plid
                      };
        jQuery(container_normal).GRN_Schedule_ShowEvent(options);
        jQuery(container_allday).GRN_Schedule_ShowAllDayEvents(options);
    }
    setTimeout(function(){
        var options_banner = {
                data          : params.banner_events,
                uid           : params.uid,
                gid           : params.gid,
                referer_key   : params.referer_key
        };
        jQuery(params.container_banner).GRN_Schedule_ShowBannerWeekEvents(options_banner);
        
        if(isTouchDevice())
        {
            return;
        }
        
        jQuery('div.event_content').GRN_Schedule_TooltipEvent();

        if(typeof params.do_not_have_using_privilege != 'undefined' && params.do_not_have_using_privilege == 1)
        {
            return;
        }

        var time_els = jQuery(params.container_timesheet).find('div.add_quick');
        time_els.prop('dblclick', false);
        time_els.dblclick(function(e){
            GRN_ScheduleSimpleAdd.doubleClickPersonalHandler(e,this);
        });
        if(params.ajax)
        {
            GRN_ScheduleSimpleAdd.Dialog.Highlight();
        }
        
        if(enable_dragdrop == 0)
        {
            // disable drag drop schedule when deactive D&D
            return;
        }
        
        if(typeof params.plid != 'undefined')
        {
            jQuery(params.container_list_event).GRN_DragDropSchedule_Personal(false,params.plid);
        }
        else
        {
            jQuery(params.container_list_event).GRN_DragDropSchedule_Personal(false);
        }
        jQuery('div.critical3').GRN_DragDropScheduleVertical_Personal();
    },0);
}

(function ($){
    $.fn.GRN_Schedule_ShowEvent = function(options){
        var settings = $.extend( {
          'data'        : [],
          'bdate'       : "",
          'uid'         : "",
          'gid'         : "",
          'referer_key' : "",
          'page'        : "",
          'week'        : 0,
          'unit'        : 30,
          'plid'        : '',
          'begin_day'   : 0,
          'end_day'     : 24
        }, options);
        
        var element, data, manage_day, colspan_all, distance_between_event,distance_height;
        
        return this.each(function(){
            element = $(this);
            draw_time_row();
            init();
            draw_event_on_UI();
            
            if(element.hasClass('last_date'))
            {
                element.closest('div.personal_calendar_list').css({'height':element.height()+'px'});
                element.closest('div.showtime').css({'height':element.height()+'px'});
            }
        });
        
        function init(){
            element.find('div.critical3').remove();
            element.find('div.busytime_grn').remove();
            element.find('.dummy-container').remove();
            var hour_display = settings.end_day - settings.begin_day;
            element.css('z-index','3'); // this element above busytime_grn and personal_day_calendar_time_row
            data = settings.data;
            settings.unit = 5;
            var span_unit = 60 / settings.unit;
            colspan_all = Math.round(hour_display * span_unit);
            var begin_index = settings.begin_day * span_unit;
            var end_index = settings.end_day * span_unit;
            var bdate_parse = parse_datetime(settings.bdate);
            element.data('date',bdate_parse);
            distance_height = 0.8;
            
            sort_by_duration(data);
            manage_day = new GRN_Schedule_Manage_Personal_Day_Util(bdate_parse,colspan_all,settings.unit,begin_index,end_index);
            var setdatetime,enddatetime;
            for(var i =0; i < data.length; i++)
            {
                if( ! data[i].allday )
                {
                    data[i].begin_day = settings.begin_day;
                    data[i].end_day = settings.end_day;
                    
                    setdatetime = parse_datetime( data[i].start_date );
                    
                    if( 'end_date' in data[i] )
                    {
                        enddatetime = parse_datetime( data[i].end_date );
                        if(setdatetime.getTime() == enddatetime.getTime())
                        {
                            enddatetime.setMinutes(enddatetime.getMinutes() + 30);
                            data[i].same_time = true;
                        }
                    }
                    else
                    {
                        enddatetime = parse_datetime( data[i].start_date );
                        enddatetime.setMinutes(enddatetime.getMinutes() + 30);
                    }
                    
                    if(settings.plid != '')
                    {
                        if(data[i].end_datetime && ( data[i].type == "repeat" || data[i].type == "share_repeat"))
                        {
                            list_data_event[settings.plid][settings.bdate][data[i].id+data[i].end_datetime] = data[i];
                        }
                        else
                        {
                            list_data_event[settings.plid][settings.bdate][data[i].id] = data[i];
                        }
                    }
                    else
                    {
                        if(data[i].end_datetime && ( data[i].type == "repeat" || data[i].type == "share_repeat"))
                        {
                            list_data_event[settings.bdate][data[i].id+data[i].end_datetime] = data[i];
                        }
                        else
                        {
                            list_data_event[settings.bdate][data[i].id] = data[i];
                        }
                    }

                    manage_day.addScheduleToStack(setdatetime,enddatetime,i);
                }
            }
        }
        
        function calculate_event_duration(event_item){
            if(event_item.same_time)
            {
                return 60 * 30;
            }
            var setdatetime,enddatetime;
            if( ! event_item.allday )
            {
                setdatetime = parse_datetime( event_item.start_date );
                if( 'end_date' in event_item )
                {
                    enddatetime = parse_datetime( event_item.end_date );
                }
                else
                {
                    return 60 * 30;
                }
                interval = (enddatetime.getTime() - setdatetime.getTime())/ 1000;
                return interval;
            }
            else
            {
                return 24 * 60 * 60; // time all day
            }
        }
        
        function sort_by_duration(events){
            var count = events.length;
            var setdatetime_current, setdatetime_other;
            for(var i = 0; i < count - 1; i++)
            {
                if( ! events[i].allday )
                {
                    setdatetime_current = parse_datetime( events[i].start_date );
                    for(var j = i+1; j < count; j++)
                    {
                        if( ! events[j].allday )
                        {
                            setdatetime_other = parse_datetime( events[j].start_date );
                            if(setdatetime_current.getTime() == setdatetime_other.getTime())
                            {
                                duration_current = calculate_event_duration(events[i]);
                                duration_other = calculate_event_duration(events[j]);
                                if(duration_current < duration_other)
                                {
                                    temp = events[i];
                                    events[i] = events[j];
                                    events[j] = temp;
                                }
                            }
                        }
                    }
                }
            }
        }
        
        function createElement(event_data,style,start_at_mid_night,top_in_px,left_in_px){
            var div_class = "critical3 schedule" + settings.plid;
            if(!check_schedule_on_one_date(event_data))
            {
                if( event_data.type == "repeat" || event_data.type == "share_repeat")
                {
                    div_class += ' group' + event_data.id + event_data.start_date.substr(0,10) + settings.plid;
                }
                else
                {
                    div_class += ' group' + event_data.id + settings.plid;
                }
            }
            if(start_at_mid_night)
            {
                div_class = div_class + ' event_first_row';
            }
            var event_content = $('<div class="event_content"/>').css({'width':'90%','height':'90%'});
            var type = 'normal';
            var font_tag;
            var tag_a = '';
            if('private' in event_data )
            {
                font_tag = $('<font size="-1">' + event_data.showtime + ' </font>').appendTo(event_content);
                font_tag.append(event_data.data);
            }
            else
            {
                tag_a = document.createElement('a');
                var href_link = make_link(view_detail_url,settings.bdate,event_data.id,settings.uid,settings.gid,settings.referer_key);
                var _icons = '';
                tag_a.setAttribute('href',href_link);
                
                font_tag = $('<font size="-1"><span class="time_critical_grn"><a/></span></font>').appendTo(event_content);
                font_tag.find('a').attr('href',href_link).html(event_data.showtime);
                if('is_private' in event_data )
                {
                    _icons += private_icon;
                }
                
                if( event_data.type == "repeat" || event_data.type == "share_repeat")
                {
                    _icons += repeat_icon;
                    type = 'repeat';
                }
                
                if('report' in event_data)
                {
                    _icons += report_icon;

                }
                var _attendanceCheckNotAnswerIcon = attendanceCheckNotAnswerIcon;//Global variable created at _pripare_data.tpl
                if (typeof event_data.attendance_check_show === "undefined" || !event_data.attendance_check_show)
                {
                    _attendanceCheckNotAnswerIcon = "";
                }
                if(event_data.conflict)
                {
                    tag_a.innerHTML += span_confict;
                }
                tag_a.innerHTML += _attendanceCheckNotAnswerIcon;
                var tmp_facility_name = event_data.event_facility_name != null ? event_data.event_facility_name : '';
                if(event_data.event_menu_color != null && event_data.event_menu_color != '' && event_data.event_menu_color != '0'){

                    if(event_data.facility_name_after != null && event_data.facility_name_after){
                        tag_a.innerHTML += '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + tmp_facility_name + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") + (typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                    }else{
                        tag_a.innerHTML += tmp_facility_name + '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") + (typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                    }

                }
                else
                {
                    tag_a.innerHTML += event_data.data + _icons;
                }
                font_tag.append(tag_a);
                
                if(event_data.type == 'share_temporary' || event_data.type == 'temporary' )
                {
                    div_class = div_class + ' temporary';
                }
                
                if(aeid == event_data.id)
                {
                    div_class = div_class + ' newevent-grn';
                }
            }

            var div = $('<div/>').data('event_id',event_data.id)
                                 .data('bdate',settings.bdate)
                                 .data('title',tag_a)
                                 .data('uid',settings.uid)
                                 .data('gid',settings.gid)
                                 .data('referer_key',settings.referer_key)
                                 .data('style',style)
                                 .addClass(div_class)
                                 .css(style)
                                 .html(event_content);
            div.css({"top":top_in_px,"left":left_in_px});
            if(event_data.end_datetime && (event_data.type == "repeat" || event_data.type == "share_repeat"))
            {
                div.data('end_datetime',event_data.end_datetime);
            }
            if(settings.plid != '')
            {
                div.data('plid',settings.plid);
            }
            if(!check_schedule_on_one_date(event_data))
            {
                if( event_data.type == "repeat" || event_data.type == "share_repeat")
                {
                    div.data('group_drag','group' + event_data.id + event_data.start_date.substr(0,10) + settings.plid);
                }
                else
                {
                    div.data('group_drag','group' + event_data.id + settings.plid);
                }
            }
            div.appendTo(element);
            setTimeout(function()
            {
                var content = event_content.find('font');
                var content_width = content.width(),
                    content_height = content.height();
                if(content_width < div.width() * 90 / 100 - 3)
                {
                    event_content.css('width','');
                }
                if(content_height < div.height() * 90 / 100 - 3)
                {
                    event_content.css('height','');
                }
            },500);
        }
        
        function draw_event_on_UI(){
            var width_unit = 96;
            if(settings.week == 1)
            {
                width_unit = 93.5;
            }
            if(element.find('div.personal_day_calendar_time_row').width() < 120)
            {
                width_unit = 87;
            }
            var height_unit = 100/colspan_all;
            if(manage_day.stack.length != 0)
            {
                width_unit = width_unit / (manage_day.stack.length);
            }
            
            if(settings.week == 1)
            {
                switch(manage_day.stack.length)
                {
                    case 1:
                        distance_between_event = 0.0025;
                        break;
                    case 2:
                        distance_between_event = 0.018;
                        break;
                    case 3:
                        distance_between_event = 0.02;
                        break;
                    case 4:
                        distance_between_event = 0.029;
                        break;
                    default:
                        distance_between_event = 0.035;
                }
            }
            else
            {
                distance_between_event = 0.004;
                if(settings.plid != '')
                {
                    if(manage_day.stack.length > 4)
                    {
                        distance_between_event = distance_between_event + 0.01;
                    }
                }
            }
            
            for(var i=0; i < manage_day.stack.length; i++)
            {
                var slot,event_data,width,height,top,left,style,start_at_mid_night,top_in_px,left_in_px;
                for(var j=0; j < manage_day.stack[i].list_events.length; j++)
                {
                    slot = manage_day.stack[i].list_events[j];
                    manage_day.calculateWidthOfEvent(slot,i);
                    event_data = data[slot.event_data_index];
                    start_at_mid_night = (slot.start_index == 0);
                    width = (slot.width - distance_between_event) * width_unit ;
                    height = (slot.end_index - slot.start_index + distance_height) * height_unit;
                    top = (slot.start_index) * height_unit;
                    left = i * width_unit;
                    top_in_px = top * element.height() / 100;
                    left_in_px = left * element.width() / 100;
                    style = {'width':width+'%','max-width':width+'%','height':height+'%','top':top+'%','left':left+'%'};
                    createElement(event_data,style,start_at_mid_night,top_in_px,left_in_px);
                }
            }
            
            if(settings.week == 0)
            {
                element.parent().find('div.busy_time_span').remove();
                var width_unit_busy = 100;
                var div_busy = $('<div class="busy_time_span"/>');
                var busy_event,height_busy,top_busy,style_busy;
                for(var i=0; i < manage_day.busytime.list_events.length; i++)
                {
                    busy_event = manage_day.busytime.list_events[i];
                    height_busy = (busy_event.end_index - busy_event.start_index + distance_height) * height_unit;
                    top_busy = (busy_event.start_index) * height_unit;
                    style_busy = {'width':width_unit_busy+'%','max-width':width_unit_busy+'%','height':height_busy+'%','max-height':height_busy+'%','top':top_busy+'%','left':'0','position':'absolute'};
                    $('<div class="busytime_grn"/>').css(style_busy).appendTo(div_busy);
                }
                draw_for_busy_time(div_busy);
                div_busy.appendTo(element.parent());
            }
        }
        
        // this function only use for personal day and porlet personal day
        function draw_for_busy_time(div_busy)
        {
            var div_time_row,div_time_row_alt;
            for(var i = settings.begin_day; i < settings.end_day; i++)
            {
                div_time_row = $('<div class="personal_day_calendar_time_row"/>');
                if(i == settings.end_day - 1)
                {
                    div_time_row.addClass('lastRow');
                }
                div_time_row.attr('data-hour',i);
                div_time_row.attr('data-minute',30);
                div_time_row.attr('data-bdate',settings.bdate);
                
                div_time_row_alt = $('<div class="personal_day_calendar_time_row_alt"/>');
                div_time_row_alt.attr('data-hour',i);
                div_time_row_alt.attr('data-minute',0);
                div_time_row_alt.attr('data-bdate',settings.bdate);
                
                div_time_row_alt.appendTo(div_time_row);
                div_time_row.appendTo(div_busy);
            }
        }
        
        function draw_time_row()
        {
            element.find('div.personal_day_calendar_time_row').remove();
            var div_time_row,div_time_row_alt;
            for(var i = settings.begin_day; i < settings.end_day; i++)
            {
                div_time_row = $('<div/>').addClass('personal_day_calendar_time_row snapto'+settings.plid+' add_quick');
                if(i == settings.end_day - 1)
                {
                    div_time_row.addClass('lastRow');
                }
                div_time_row.attr('data-hour',i);
                div_time_row.attr('data-minute',30);
                div_time_row.attr('data-bdate',settings.bdate);
                div_time_row.attr('data-uid',settings.uid);
                div_time_row.attr('data-gid',settings.gid);
                div_time_row.attr('data-referer_key',settings.referer_key);
                if(settings.plid != '')
                {
                    div_time_row.attr('plid',settings.plid);
                }
                
                div_time_row_alt = $('<div class="personal_day_calendar_time_row_alt"/>');
                div_time_row_alt.attr('data-hour',i);
                div_time_row_alt.attr('data-minute',0);
                div_time_row_alt.attr('data-bdate',settings.bdate);
                div_time_row_alt.attr('data-uid',settings.uid);
                div_time_row_alt.attr('data-gid',settings.gid);
                div_time_row_alt.attr('data-referer_key',settings.referer_key);
                if(settings.plid != '')
                {
                    div_time_row_alt.attr('plid',settings.plid);
                }
                
                div_time_row_alt.appendTo(div_time_row);
                div_time_row.appendTo(element);
            }
        }
    };
})(jQuery);

(function ($){
    $.fn.GRN_Draw_Time_Sheet = function(begin_day,end_day){
        return this.each(function(){
            var element = $(this);
            element.find('div.personal_calendar_time_sheet').remove();
            var height_element = (end_day - begin_day) * oneHourHeight;
            element.css('height',height_element+'px');
            element.find('div.personal_calendar_list').css('height',height_element+'px');
            var div_time_sheet = $('<div class="personal_calendar_time_sheet"/>');
            var div_time_slot;
            for(var i = begin_day; i < end_day; i++)
            {
                div_time_slot = $('<div class="personal_day_calendar_time_cell"/>').html(i);
                if(i < 12)
                {
                    div_time_slot.addClass('m');
                }
                else
                {
                    if(i < 18)
                    {
                        div_time_slot.addClass('e');
                    }
                    else
                    {
                        div_time_slot.addClass('a');
                    }
                }
                div_time_slot.appendTo(div_time_sheet);
            }
            div_time_sheet.appendTo(element);
        });
    };
})(jQuery);

(function ($){
    $.fn.GRN_Schedule_TooltipEvent = function(){
        var popup, ev_content;
        return this.each(function(){
            $(this).mouseover(function(e){
                var divToolTip = $("div.cotainerTooltip");
                var fontToolTipEvent = $('font.tooltipEvent');
                if(resizing)
                {
                    return;
                }
                if(divToolTip.length > 0 || fontToolTipEvent.length > 0){
                    return;
                }
                divToolTip.remove();
                fontToolTipEvent.remove();
                check_mouse_over_event_content = true;
                var x = e.pageX + 2;// ready drag and drop when hover event title
                var y = e.pageY - 10;
                div_tooltip = $(this).find('font').clone();
                div_tooltip.addClass('tooltipEvent');
                popup = $('<div/>',{'class':'cotainerTooltip'}).append(div_tooltip).css({'top' : y + 12});
                $('body').append(popup);
                var window_with = $(document).width();
                var popup_width = popup.width();
                if(popup_width >= 300)
                {
                    popup.css('width','300px');
                    popup_width = 300;
                }
                else
                {
                    popup.css('width',popup_width);
                }
                //Revert popup orient
                if(x + popup_width > window_with){
                    is_revert = true;
                    /*max-width:300px+10padding + 1 border and move 10px*/
                    popup.css({"left": x - popup_width - 12 - 10, 'top' : y + 10});
                }else{
                    popup.css({"left": x + 1});
                }
                ev_content = $(this);
                $(popup).mouseout(function(e){
                    var cond1, cond2, cond3, cond4;
                    cond1 = e.pageX < $(this).offset().left;
                    cond2 = e.pageX > $(this).offset().left + $(this).width() + 10;
                    cond3 = e.pageY < $(this).offset().top;
                    cond4 = e.pageY > Math.round(($(this).offset().top + $(this).height() + 19));// clone from title have offset20px
                    if(cond1|| cond2 || cond3 || cond4)
                    {
                    //navigation goto content tooltip naviation out off range and move to left and move to top and exit 
                        var cond11, cond21, cond31, cond41;
                        cond11 = e.pageX < ev_content.offset().left;
                        cond21 = e.pageX > ev_content.offset().left + ev_content.width();
                        cond31 = e.pageY < ev_content.offset().top;
                        cond41 = e.pageY > Math.round(ev_content.offset().top + ev_content.height());// clone from title have offset20px
                        if(cond11 || cond21 || cond31 || cond41){
                            check_mouse_over_event_content = false;
                        }
                        ev_content.parent().css({'background-color':'','z-index':''});
                        ev_content.parent().removeClass('personal_over_schedule').find('div.dragdrop_handle').remove();
                        var group_id = '.' + ev_content.parent().data('group_drag');
                        $(group_id).each(function() {
                            $(this).removeClass('personal_over_schedule');
                        });
                    }
                });
                return e.preventDefault();
            });
            $(this).mouseleave(function(e){
                if(popup)
                {
                    var a,b,c;
                    a = e.pageX + 1 < popup.offset().left;//1 cong sai chong giat
                    b = e.pageY < popup.offset().top - 10;
                    c = e.pageY > popup.offset().top + popup.height() + 20;// padding top 10, bottom 10=>20
                    if(a || b || c){
                        check_mouse_over_event_content = false;
                    }
                    if(is_revert == false && e.pageX > popup.offset().left + popup.width()){//tooltip orient right
                        check_mouse_over_event_content = false;
                    }else if(e.pageX > popup.offset().left + popup.width() + 20){// tooltip orient left
                        check_mouse_over_event_content = false;
                    }
                }
            });
        });
    };
})(jQuery);

(function($){
    $(document).mousemove(function(e){
        if(!check_mouse_over_event_content)
        {
            var popup_normal_title = $('div.cotainerTooltip');
            if(popup_normal_title.length > 0)
            {
                if( e.pageX < popup_normal_title.offset().left || e.pageX > popup_normal_title.offset().left + popup_normal_title.width() ||
                    e.pageY < popup_normal_title.offset().top || e.pageY > popup_normal_title.offset().top + popup_normal_title.height())
                {
                    popup_normal_title.remove();
                    is_revert = false;
                }
            }
        }
    });

    var body_height;
    $(window).on( "load", function(){
        body_height = $('body').height();
    });
    
    $(window).resize(function(){
        $('div.showtime').each(function(){
            $(this).find('div.last_date').each(function(){
                $(this).closest('div.personal_calendar_list').css({'height':$(this).height()+'px'});
                $(this).closest('div.showtime').css({'height':$(this).height()+'px'});
            });
            $(this).find('div.dummy-container').each(function(){
                var container = $(this).parent().find('div.personal_calendar_list');
                $(this).css({'width':container.width()+'px','height':container.height()+'px'});
            });
        });

        var $body = $('body');
        if(body_height != $body.height() && !during_dragdrop)
        {
            $('div.critical3').each(function(){
                $(this).css($(this).data('style'));
            });
            body_height = $body.height();
        }

        $('div.event_content').each(function(){
            var parent = $(this).parent();
            if($(this).width() > (parent.width() * 90 / 100 - 3))
            {
                $(this).css({'width':'90%'});
            }
            if($(this).height() > (parent.height() * 90 / 100 - 3))
            {
                $(this).css({'height':'90%'});
            }
        });
        $('div.dragdrop-container').each(function(){
            $(this).height($(this).parent('div').height());
            $(this).width($(this).parent('div').width() - 24); // margin left 24px
        });
    });
})(jQuery);

(function($){
    $.fn.GRN_Schedule_ShowAllDayEvents = function(options){
        var settings = $.extend( {
          'data'        : [],
          'bdate'       : "",
          'uid'         : "",
          'gid'         : "",
          'referer_key' : ""
        }, options);
        
        var element;
        
        return this.each(function(){
            element = $(this);
            element.find('div.event_content_allday').remove();
            var data = settings.data;
            var event_data,div_class,event_content,font_tag,tag_a,href_link,_icons,_event_menu;
            for(var i =0; i < data.length; i++)
            {
                event_data = data[i];
                if( event_data.allday)
                {
                    if(!('private' in event_data))
                    {
                        div_class = "";
                        event_content = $('<div class="event_content_allday"/>');
                        font_tag = $('<font size="-1"></font>').appendTo(event_content);
                        font_tag.append(allday_icon);
                        
                        tag_a = document.createElement('a');
                        href_link = make_link(view_detail_url,settings.bdate,event_data.id,settings.uid,settings.gid,settings.referer_key);
                        _icons = '';
                        _event_menu = '';
                        tag_a.setAttribute('href',href_link);
                        if('is_private' in event_data )
                        {
                            _icons += private_icon;
                        }
                        
                        if( event_data.type == "repeat" || event_data.type == "share_repeat")
                        {
                            _icons += repeat_icon;
                        }
                            
                        if('report' in event_data)
                        {
                            _icons += report_icon;
                        }
                        var _attendanceCheckNotAnswer = attendanceCheckNotAnswerIcon;
                        if (typeof event_data.attendance_check_show === "undefined" || !event_data.attendance_check_show)
                        {
                            _attendanceCheckNotAnswer = "";
                        }
                        if(event_data.event_menu_color != null && event_data.event_menu_color != '' && event_data.event_menu_color != '0'){

                            tag_a.innerHTML += _attendanceCheckNotAnswer + '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") + (typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                        }
                        else {
                            tag_a.innerHTML += _attendanceCheckNotAnswer + event_data.data + _icons;
                        }
                        font_tag.append(tag_a);
                        
                        if(aeid == event_data.id)
                        {
                            event_content.addClass('newevent-grn');
                        }
                        event_content.appendTo(element);
                    }
                }
            }
        });
    };
})(jQuery);

(function($){
    $.fn.GRN_Schedule_ShowBannerDayEvents = function(options){
        var settings = $.extend( {
          'data'        : [],
          'bdate'       : '',
          'is_porlet'   : 0,
          'uid'         : "",
          'gid'         : "",
          'referer_key' : ""
        }, options);
        return this.each(function(){
            $(this).find('tr').remove();
            var events = settings.data;
            var tr,td_head,td_item,event_content,div_event,href,tag_a,_icons,_event_menu,event_element;
            for(var i = 0; i < events.length; i++)
            {
            
                tr = $('<tr>');
                if(settings.is_porlet == 0)
                {
                    td_head = $('<td class="personal_day_calendar_event_head">');
                    tr.append(td_head);
                }
                td_item = $('<td class="personal_day_calendar_event_item banner_color">');
                event_content = $('<div class="event_content_banner">');
                div_event = $('<div class="personal_day_calendar_banner_text">');
                
                var event_data = events[i];
                href = make_link(view_detail_url,settings.bdate,event_data.id,settings.uid,settings.gid,settings.referer_key);
                tag_a = document.createElement('a');

                _icons = '';
                _event_menu = '';

                tag_a.setAttribute('href',href);

                if('report' in event_data)
                {
                    _icons += report_icon;
                }
                //personal day portlet
                if(event_data.event_menu_color != null && event_data.event_menu_color != '' && event_data.event_menu_color != '0'){
                        tag_a.innerHTML = banner_icon + '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") +(typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                }else{
                    tag_a.innerHTML = banner_icon + event_data.data + _icons;
                }
                event_element = $('<div class="normalEventElement">');
                tr.append(td_item.append(event_content.append(event_element.append(div_event.append(tag_a)))));
                tr.appendTo($(this));
            }
        });
    };
})(jQuery);

(function($){
    $.fn.GRN_Schedule_ShowBannerWeekEvents = function(options){
        var settings = $.extend( {
          'data'        : [],
          'uid'         : "",
          'gid'         : "",
          'referer_key' : ""
        }, options);
        return this.each(function(){
            $(this).find('tr.list_banner').remove();
            var events,tr,index,event_data,start_index,end_index,colspan,colspan_event,td,event_content,banner_day,href,tag_a,_icons,_event_menu,tmp_facility_name,event_element;
            for(var i = 0; i < settings.data.length; i++)
            {
                events = settings.data[i];
                tr = $('<tr class="list_banner">');
                index = 0;
                for(var j = 0; j < events.length; j++)
                {
                    event_data = events[j];
                    start_index = parseInt(event_data.term.substr(0,1));
                    end_index = parseInt(event_data.term.substr(2,1));
                    if(start_index > index)
                    {
                        colspan = start_index - index;
                        $('<td class="br_banner3" colspan="' + colspan + '">').html(' ').appendTo(tr);
                    }
                    colspan_event = end_index - start_index + 1;
                    td = $('<td class="s_banner3 normalEvent" colspan="' + colspan_event + '">');
                    event_content = $('<div class="event_content_banner">');
                    
                    banner_day = event_data.date.substr(0,10);
                    href = make_link(view_detail_url,banner_day,event_data.id,settings.uid,settings.gid,settings.referer_key);
                    tag_a = document.createElement('a');
                    _icons = '';
                    _event_menu = '';
                    tag_a.setAttribute('href',href);
                    if('report' in event_data)
                    {
                        _icons += report_icon;
                    }
                    //GTM-103
                    if(event_data.event_menu_color != null && event_data.event_menu_color != '' && event_data.event_menu_color != '0'){
                            tmp_facility_name = event_data.event_facility_name != null ? event_data.event_facility_name : '';
                            if(event_data.facility_name_after != null && event_data.facility_name_after){
                                tag_a.innerHTML = banner_icon + '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + tmp_facility_name + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") + (typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                            }else{
                                tag_a.innerHTML = banner_icon + tmp_facility_name + '<span class="event_color' + event_data.event_menu_color + '_grn">' + event_data.event_menu + '</span>' + event_data.event_detail + (typeof event_data.creator_name != 'undefined' ? event_data.creator_name : "") + (typeof event_data.faci_items != 'undefined' ? event_data.faci_items : "") + _icons;
                            }
                    //End GTM-103
                    }else{
                        tag_a.innerHTML = banner_icon + event_data.data + _icons;
                    }
                    event_element = $('<div class="normalEventElement">');
                    tr.append(td.append(event_content.append(event_element.append(tag_a))));
                    
                    index = end_index + 1;
                }
                if(index <= 6)
                {
                    colspan = 6 - index + 1;
                    $('<td class="br_banner3" colspan="' + colspan + '">').html(' ').appendTo(tr);
                }
                tr.appendTo($(this));
            }
        });
    };
})(jQuery);

(function($){
    $.fn.GRN_DragDropSchedule_Personal = function(is_day,plid){
        var element;
        return this.each(function(){
            element = $(this);
            init();
        });
        
        function afterDragDrop(element,oldParent,ev)
        {
            var callback = function(oldParent,element){
                if(typeof oldParent != 'undefined')
                {
                    element.appendTo(oldParent);
                    returnOriginalUI();
                }
                element.css(element.data('style'));
                during_dragdrop = false;
            };
            
            if(schedule_is_drag_to_another_time(element))
            {
                executeAfterDragDrop(element,ev,callback,oldParent,element);
            }
            else
            {
                $('div.ui-draggable-dragging').remove();
                element.css(element.data('style'));
                element.appendTo(oldParent);
                returnOriginalUI();
                during_dragdrop = false;
            }
        }
        
        function init()
        {
            var class_dragdrop,class_drop;
            if(typeof plid != 'undefined')
            {
                class_dragdrop = 'div.schedule' + plid;
                class_drop = 'div.snapto' + plid;
            }
            else
            {
                class_dragdrop = 'div.schedule';
                class_drop = 'div.snapto';
            }

            var check_first,check_top,check_bottom,data_event,start_time,end_time,string_time,originalCursor,currentCursor,distance,originalPosition,isTopResize,lastedPosition,bottom_position;
            var documentWidth,documentHeight;
            
            function resize_schedule(ev, ui)
            {
                // hide tooltip event
                $("div.cotainerTooltip").remove();//htvs
                // show time when resizing
                var div_tooltip_timespan = $('div.showTimeSpanTitle');
                // prevent drag pointer out of document width
                setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
                
                // prevent drag pointer out of document height
                setTopTooltip(div_tooltip_timespan,ev.pageY,documentHeight);

                // do not allow to resize schedule less than 17px
                if(isTopResize && (bottom_position - ui.position.top < 17))
                {
                    ui.position.top = lastedPosition;
                    ui.element.css({"top":lastedPosition});
                }
                else
                {
                    lastedPosition = ui.position.top;
                }

                string_time = calculateSpanTime(ui,ui.element,start_time,end_time,isTopResize);
                div_tooltip_timespan.html(string_time);
                ev.preventDefault();
                ev.stopPropagation();
            }
            function resize_start(ev, ui)
            {
                time_after_drag_drop = null;
                during_dragdrop = true;
                // hide tooltip event
                $("div.cotainerTooltip").remove();

                // determine resize top or bottom
                isTopResize = Math.abs(ev.pageY - ui.element.offset().top) < 5;

                var old_element = ui.element.clone();
                old_element.removeClass()
                           .addClass('critical3 original_schedule')
                           .appendTo(ui.element.parent())
                           .find('div.dragdrop_handle').remove();
                ui.element.addClass('resizing_schedule').css('z-index',90); // make element resizing on top

                // show time when beginning resize schedule
                string_time = stringSpanTime(ui.element);
                var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(string_time);
                div_tooltip_timespan.css({'position':'absolute','top':ev.pageY+10+'px','z-index':'99'});
                $('body').append(div_tooltip_timespan);
                documentWidth = $(document).width();
                documentHeight = $(document).height();
                setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
                
                // check begin resizing
                resizing = true;
                // hidden tooltip of schedule
                check_show_tooltip_schedule = false;

                data_event = get_event_data(ui.element);
                start_time = parse_datetime(data_event.start_date);
                if('end_date' in data_event)
                {
                    end_time = parse_datetime(data_event.end_date);
                    if(data_event.same_time)
                    {
                        end_time.setMinutes(end_time.getMinutes() + 30);
                    }
                }
                else
                {
                    end_time = parse_datetime(data_event.start_date);
                    end_time.setMinutes(end_time.getMinutes() + 30);
                }
                originalPosition = ev.pageY;

                check_top = (start_time.getMinutes() != 0 && start_time.getMinutes() != 30);
                check_bottom = (end_time.getMinutes() != 0 && end_time.getMinutes() != 30);

                // change schedule over day to blue
                $('.' + ui.element.data('group_drag')).each(function() {
                    $(this).addClass('resizing_schedule');
                });

                // round minute to 0 or 30
                var start_hour,start_minute,end_hour,end_minute,time_change,tempTopStartResizing;
                if(isTopResize && check_top )
                {
                    time_change = changeTimeBeforeResizing(ui.position.top,ui.originalPosition.top,start_time,data_event);

                    start_hour = time_change.start_hour;
                    start_minute = time_change.start_minute;

                    tempTopStartResizing = start_hour - data_event.begin_day;
                    if(start_minute > 0)
                    {
                        tempTopStartResizing = tempTopStartResizing + (start_minute/60);
                    }

                    tempTopStartResizing = tempTopStartResizing * oneHourHeight;
                    distance = tempTopStartResizing - ui.originalPosition.top;

                    ui.size.height = ui.size.height - distance;
                    ui.originalSize.height = ui.originalSize.height - distance;

                    ui.position.top = tempTopStartResizing;
                    ui.originalPosition.top = tempTopStartResizing;

                    ui.element.css({"top":ui.originalPosition.top,"height":ui.originalSize.height});

                    start_time.setHours(start_hour);
                    start_time.setMinutes(start_minute);
                    end_hour = end_time.getHours();
                    end_minute = end_time.getMinutes();

                    string_time = formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_hour,end_minute);
                }
                else
                {
                    if(!isTopResize && check_bottom)
                    {
                        time_change = changeTimeBeforeResizing(ui.size.height,ui.originalSize.height,end_time,data_event);
                        end_hour = time_change.start_hour;
                        end_minute = time_change.start_minute;

                        tempTopStartResizing = end_hour - data_event.begin_day;
                        if(end_minute > 0)
                        {
                            tempTopStartResizing = tempTopStartResizing + (end_minute/60);
                        }
                        tempTopStartResizing = tempTopStartResizing * oneHourHeight;
                        ui.size.height = tempTopStartResizing - ui.position.top;
                        ui.originalSize.height = tempTopStartResizing - ui.position.top;

                        ui.element.css({"top":ui.originalPosition.top,"height":ui.originalSize.height});

                        start_hour = start_time.getHours();
                        start_minute = start_time.getMinutes();
                        end_time.setHours(end_hour);
                        end_time.setMinutes(end_minute);

                        string_time = formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_hour,end_minute);
                    }
                }
                div_tooltip_timespan.html(string_time);
                lastedPosition = ui.position.top;
                bottom_position = ui.position.top + ui.size.height;

                ev.preventDefault();
                ev.stopPropagation();
            }
            function resize_stop(ev, ui)
            {
                // stop resizing
                resizing = false;
                // show tooltip of schedule
                check_show_tooltip_schedule = true;
                
                // remove resizing handle if mouse out of schedule
                removeResizingHandle(ev,ui.element);
                // remove time span
                $('div.showTimeSpanTitle').remove();
                
                var parent = ui.element.parent();
                parent.find('div.original_schedule').remove();
                
                afterDragDrop(ui.element,parent,ev);
                ev.preventDefault();
                ev.stopPropagation();
            }
            $(class_dragdrop).each(function(){
                var div = $(this);
                if(check_event_can_drag_drop(div))
                {
                    var string_handle = '';
                    if(check_event_have_handle(div,'top'))
                    {
                        string_handle = 'n';
                    }
                    if(check_event_have_handle(div,'bottom'))
                    {
                        string_handle = string_handle + ',s';
                    }
                    if(string_handle != '')
                    {
                        $(this).resizable({
                            containment: $(this).parent(),
                            handles: string_handle,
                            grid: [0,halfHourHeight],
                            minHeight: 17,
                            distance:1,
                            create:function( ev, ui ) {

                            },
                            resize: function( ev, ui ) {
                                resize_schedule(ev, ui);
                            },
                            start: function( ev, ui ) {
                                resize_start(ev, ui);
                                resize_schedule(ev, ui);
                            },
                            stop: function( ev, ui ) {
                                resize_stop(ev, ui);
                            }
                        });
                    }
                }
            });
            
            var check_need_resize_before_drag = false;
            function dragging_create(thisObj)
            {
                if(!check_event_can_drag_drop(thisObj))
                {
                    thisObj.draggable( "destroy" );
                }
            }
            
            function dragging_drag(ev,ui,thisObj,element)
            {
                // hide tooltip event
                $("div.cotainerTooltip").remove();//htvs
                // show time when dragging
                var div_tooltip_timespan = $('div.showTimeSpanTitle');
                // prevent drag pointer out of document width
                setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
                
                // prevent drag pointer out of document height
                setTopTooltip(div_tooltip_timespan,ev.pageY,documentHeight);
                
                currentCursor = ev.pageY;

                if(check_first && currentCursor != originalCursor)
                {
                    var start_hour,start_minute,end_hour,end_minute;
                    var time_change;
                    if(!end_time)
                    {
                        var end_time_temp = new Date(start_time.getTime());
                        end_time_temp.setMinutes(end_time_temp.getMinutes() + 30);
                        time_change = changeTimeBeforeDragging(currentCursor,originalCursor,start_time,end_time_temp,data_event);
                    }
                    else
                    {
                        time_change = changeTimeBeforeDragging(currentCursor,originalCursor,start_time,end_time,data_event);
                    }
                    start_hour = time_change.start_hour;
                    start_minute = time_change.start_minute;
                    end_hour = time_change.end_hour;
                    end_minute = time_change.end_minute;
                    var tempTopStartTime = start_hour - data_event.begin_day;
                    if(start_minute > 0)
                    {
                        tempTopStartTime = tempTopStartTime + (start_minute/60);
                    }
                    tempTopStartTime = tempTopStartTime * oneHourHeight;
                    distance = tempTopStartTime - ui.position.top;
                    ui.position.top = tempTopStartTime;
                    originalPosition.top = originalPosition.top + distance;
                    
                    start_time.setHours(start_hour);
                    start_time.setMinutes(start_minute);
                    if(end_time)
                    {
                        end_time.setHours(end_hour);
                        end_time.setMinutes(end_minute);
                    }
                    
                    string_time = formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_hour,end_minute);
                    check_first = false;
                }
                else
                {
                    // distance to be dragged horizontally
                    var distance_date = 0;
                    if(element.find('td.personal_week_calendar_date.firstColumn').length > 0)
                    {
                        distance_date = element.find('td.personal_week_calendar_date.firstColumn').width() + 1;
                    }

                    if(distance != 0)
                    {
                        ui.position.top = ui.position.top + distance;
                    }
                    if(ui.position.top < 0)
                    {
                        ui.position.top = 0;
                    }
                    
                    // measurement uncertainty for zoom is 5 pixel
                    while(ui.position.top + thisObj.height() - element.height() > 5)
                    {
                        ui.position.top = ui.position.top - halfHourHeight;
                    }

                    string_time = calculateDragTime(ui.helper.offset(),originalPosition,thisObj,distance_date,start_time,end_time);
                }
                div_tooltip_timespan.html(string_time);
            }
            
            function dragging_start(ev,ui,thisObj,element)
            {
                during_dragdrop = true;
                // check dragging
                is_dragging = true;
                // check show tooltip of schedule
                check_show_tooltip_schedule = false;
                if(check_need_resize_before_drag)
                {
                    thisObj.css('left','0%');
                }
                thisObj.addClass('original_schedule');
                
                data_event = get_event_data(thisObj);
                start_time = parse_datetime(data_event.start_date);
                if('end_date' in data_event)
                {
                    end_time = parse_datetime(data_event.end_date);
                }
                else
                {
                    end_time = false;
                }
                
                check_first = false;
                distance = 0;
                if(start_time.getMinutes() != 0 && start_time.getMinutes() != 30)
                {
                    check_first = true;
                }
                originalCursor = ev.pageY;
                originalPosition = {top: thisObj.offset().top, left: thisObj.offset().left};
                
                // distance to be dragged horizontally
                var gridX = 0;
                if(!is_day)
                {
                    if(element.find('td.personal_week_calendar_date.firstColumn').length > 0)
                    {
                        gridX = element.find('td.personal_week_calendar_date.firstColumn').width();
                        if(browser_type == 'msie' && browser_ver_major == 8)
                        {
                            gridX = gridX + 2;
                        }
                    }
                }
                thisObj.draggable({
                    grid:[gridX,halfHourHeight]
                });
                
                // init for show time when dragging
                string_time = stringDragTime(thisObj);
                var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(string_time);
                div_tooltip_timespan.css({'position':'absolute','top':ev.pageY+10+'px','z-index':'99'});
                $('body').append(div_tooltip_timespan);
                documentWidth = $(document).width();
                documentHeight = $(document).height();
                setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
            }
            
            function dragging_stop(ev,ui,thisObj)
            {
                is_dragging = false;
                check_show_tooltip_schedule = true;
                check_need_resize_before_drag = false;
                thisObj.removeClass('original_schedule');
                $('div.showTimeSpanTitle').remove();
                
                // remove resizing handle if mouse out of schedule
                removeResizingHandle(ev,thisObj);
            }
            
            element.parent().find('.dummy-container').remove();
            element.parent().find('.dragdrop-container').remove();
            var container_temp = $('<div class="dragdrop-container"/>');
            container_temp.offset({ top: element.position().top - 1, left: element.position().left});
            container_temp.css({
                'right' : 0,
                'bottom' : 0,
                'position': 'absolute',
                'margin-left': '24px',
                'z-index': '-1'
            });
            container_temp.appendTo(element.parent());
            $(class_dragdrop).each(function(){
                data_event = get_event_data($(this));

                if(check_schedule_on_one_date(data_event))
                {
                    $(this).draggable({
                        addClasses: false,
                        containment: container_temp,
                        zIndex: '99',
                        distance: 5,
                        revert: true,
                        revertDuration: 0,
                        appendTo: element.find('div.last_date'),
                        helper: function(){
                            // init helper
                            var thisObj = $(this);
                            if(thisObj.css('left').indexOf('0') == '0')
                            {
                                check_need_resize_before_drag = true;
                                if(is_day)
                                {
                                    thisObj.css('left','0.1%');
                                }
                                else
                                {
                                    thisObj.css('left','3%');
                                }
                            }
                            
                            var div_helper = thisObj.clone();
                            div_helper.removeClass();
                            div_helper.addClass('dragging_schedule');
                            if(!is_day)
                            {
                                if(typeof plid != 'undefined' && plid != '')
                                {
                                    div_helper.css({'width':'80%'});
                                }
                                if(browser_type == 'msie' && browser_ver_major == 8)
                                {
                                    if(thisObj.parent().width() / thisObj.width() * 100 > 90)
                                    {
                                        div_helper.css('width','90%');
                                    }
                                }
                                else
                                {
                                    if(div_helper.width() > 90)
                                    {
                                        div_helper.css('width','90%');
                                    }
                                }
                            }
                            div_helper.find('div.event_content').css({'width':'90%','height':'90%'});
                            return div_helper;
                        },
                        create:function( ev, ui ) {
                            dragging_create($(this));
                        },
                        drag:function( ev, ui ) {
                            dragging_drag(ev,ui,$(this),element);
                        },
                        start: function( ev, ui ) {
                            dragging_start(ev,ui,$(this),element);
                        },
                        stop: function( ev, ui ) {
                            dragging_stop(ev,ui,$(this));
                        }
                    });
                }
                else
                {
                    if(is_day || !check_event_can_drag_drop($(this)))
                    {
                        return;
                    }
                    $(this).multiDraggable({
                        addClasses: false,
                        zIndex: '99',
                        distance: 5,
                        group: $('.' + $(this).data('group_drag')),// D&D schedule over day
                        container:element,
                        create:function( ev, ui ) {
                        },
                        dragNative:function( ev, ui ) {
                        },
                        startNative: function( ev, ui ) {
                        },
                        stopNative : function( ev, ui ) {
                        }
                    });
                }
            });
            
            var dropped,first;
            $(class_drop).each(function(){
                $(this).droppable({
                    addClasses: false,
                    tolerance: 'touch',
                    activate: function( ev, ui ) {
                        dropped = false;
                        first = true;
                    },
                    over: function( ev, ui ) {
                    },
                    out: function( event, ui ) {
                        first = true;
                    },
                    drop: function( ev, ui ) {
                        if(ui.draggable.hasClass(ui.draggable.data('group_drag')))
                        {
                            return;
                        }
                        // determine drop area
                        var thisObj = $(this);
                        if(Math.ceil(Math.abs(ui.helper.offset().top - thisObj.offset().top)) >=40)
                        {
                            return;
                        }
                        if(dropped)
                        {
                            return;
                        }
                        dropped = true;
                        var oldParent = ui.draggable.parent();
                        var half = false;
                        if(Math.abs(ui.helper.offset().top - thisObj.offset().top) > 15)
                        {
                            half = true;
                        }
                        
                        var top = thisObj.position().top;
                        var left = thisObj.position().left;
                        if(half)
                        {
                            top = top + 20;
                        }
                        
                        ui.draggable.css({
                            left: left + "px",
                            top: top + "px",
                            zIndex:1
                        });
                        
                        ui.draggable.appendTo(thisObj.parent());
                        ui.draggable.addClass('dragging_schedule');
                        afterDragDrop(ui.draggable,oldParent,ev);
                    }
                });
            });
        }
    };
})(jQuery);

(function ($, undefined) {
    $.fn.multiDraggable = function (opts) {
        var originalPosition,currentPosition;
        var container = $(opts.container),
            container_parent = container.parent(),
            dummy_container = container_parent.find('div.dummy-container');
        if(dummy_container.length == 0)
        {
            dummy_container = $('<div class="dummy-container"/>').css({'width':container.width()+'px','height':container.height()+'px','position':'absolute','z-index':'1001'});
            dummy_container.offset({top:0,left:24});
            dummy_container.appendTo(container_parent);
            
            var date_columns = container.find('.personal_day_event_list');
            date_columns.each(function(){
                var div = $('<div class="critical3 tempEvent"/>').css({'width':'90%','max-width':'90%','height':'100%','top':'0%','left':'0%','overflow':'hidden','cursor':'move'}).hide();
                div.appendTo($(this));
            });
            var one_day = 1000*60*60*24;
            container.data('check_save_original_position',false);
            dummy_container.mousemove( function(ev) {
                var width_column = container.width() / 7;
                var height_column = container.height() / oneHourHeight;
                var xpos = ev.pageX - $(this).offset().left;
                var ypos = ev.pageY - $(this).offset().top;
                
                if(!container.data('check_save_original_position'))
                {
                    originalPosition = ypos;
                    container.data('check_save_original_position',true);
                }
                
                // current date mouse over
                var date_mouse_over = $(date_columns[Math.ceil(xpos / width_column) - 1]).data('date');
                // event dragging
                var event_dragging = container.data('event_dragging');
                var event_data = get_event_data(event_dragging);
                // date when start dragging
                var date_start_dragging = parse_datetime(event_dragging.data('bdate'));
                // begin date event
                var date_start_event = parse_datetime(event_data.start_date.substr(0,10));
                // end date event
                var date_end_event = parse_datetime(event_data.end_date.substr(0,10));
                // distance from date start dragging to begin date event
                var diff = (date_start_dragging - date_start_event)/one_day;
                // duration of event dragging
                var duration = (date_end_event - date_start_event)/one_day;
                // new begin date after dragging
                var new_date_start_event = new Date(date_mouse_over.getTime());
                new_date_start_event.setDate(new_date_start_event.getDate() - diff);
                // new end date after dragging
                var new_date_end_event = new Date(date_mouse_over.getTime());
                new_date_end_event.setMonth(new_date_start_event.getMonth());
                new_date_end_event.setDate(new_date_start_event.getDate() + duration);
                
                currentPosition = ypos;
                var distance,string_time;
                var start_time = container.data('start_time'),
                    end_time = container.data('end_time');
                var start_hour,start_minute,end_hour,end_minute;
                var time_begin_event = parse_datetime(event_data.start_date);
                
                // show time when dragging
                var div_tooltip_timespan = $('div.showTimeSpanTitle');
                
                if(date_start_dragging.getTime() == date_start_event.getTime() || date_start_dragging.getTime() == date_end_event.getTime())
                {
                    if(time_begin_event.getMinutes() != 0 && time_begin_event.getMinutes() != 30 && container.data('check_first') && currentPosition != originalPosition)
                    {
                        var time_change = changeTimeBeforeDragging(currentPosition,originalPosition,start_time,end_time,event_data);
                        start_hour = time_change.start_hour;
                        start_minute = time_change.start_minute;
                        end_hour = time_change.end_hour;
                        end_minute = time_change.end_minute;
                        start_time.setHours(start_hour);
                        start_time.setMinutes(start_minute);
                        end_time.setHours(end_hour);
                        end_time.setMinutes(end_minute);
                        container.data('start_time',start_time);
                        container.data('end_time',end_time);
                        container.data('check_first',false);
                    }
                    else
                    {
                        var min_distance_to_begin,min_distance_to_end;
                        var distance_to_begin_hour,distance_to_begin_minute,distance_to_end_hour,distance_to_end_minute;
                        
                        if(!container.data('calculate_distance') && !container.data('check_first'))
                        {
                            var min_distance = calculateMinTimeDistanceToBeginEndDay(event_data,start_time,end_time);
                            min_distance_to_begin = min_distance.min_distance_to_begin;
                            min_distance_to_end = min_distance.min_distance_to_end;
                            
                            container.data('min_distance_to_begin',min_distance_to_begin);
                            container.data('min_distance_to_end',min_distance_to_end);
                            container.data('calculate_distance',true);
                        }
                        else
                        {
                            min_distance_to_begin = container.data('min_distance_to_begin');
                            min_distance_to_end = container.data('min_distance_to_end');
                        }
                        
                        distance = calculateTimeDistance(currentPosition,originalPosition);
                        start_hour = start_time.getHours() + (distance.sign * distance.distance_hour);
                        start_minute = start_time.getMinutes() + (distance.sign * distance.distance_minute);
                        
                        if(end_time.getHours() == 23 && end_time.getMinutes() == 59)
                        {
                            end_hour = 24 + (distance.sign * distance.distance_hour);
                            end_minute = distance.sign * distance.distance_minute;
                        }
                        else
                        {
                            end_hour = end_time.getHours() + (distance.sign * distance.distance_hour);
                            end_minute = end_time.getMinutes() + (distance.sign * distance.distance_minute);
                        }
                        
                        if(start_minute < 0)
                        {
                            start_minute = start_minute + 60;
                            start_hour--;
                        }
                        if(start_minute >= 60)
                        {
                            start_minute = start_minute - 60;
                            start_hour++;
                        }
                        
                        if(end_minute < 0)
                        {
                            end_minute = end_minute + 60;
                            end_hour--;
                        }
                        if(end_minute >= 60)
                        {
                            end_minute = end_minute - 60;
                            end_hour++;
                        }
                        
                        if(container.data('calculate_distance'))
                        {
                            distance_to_begin_hour = min_distance_to_begin.hour_to_begin;
                            distance_to_begin_minute = min_distance_to_begin.minute_to_begin;
                            distance_to_end_hour = min_distance_to_end.hour_to_end;
                            distance_to_end_minute = min_distance_to_end.minute_to_end;
                            
                            if(start_hour < event_data.begin_day)
                            {
                                start_hour = start_time.getHours() - distance_to_begin_hour;
                                start_minute = start_time.getMinutes() - distance_to_begin_minute;
                                
                                end_hour = end_time.getHours() - distance_to_begin_hour;
                                end_minute = end_time.getMinutes() - distance_to_begin_minute;
                            }
                            if(start_hour > (event_data.end_day - 1) && start_minute >= 0)
                            {
                                start_hour = start_time.getHours() + distance_to_end_hour;
                                start_minute = start_time.getMinutes() + distance_to_end_minute;
                                
                                end_hour = end_time.getHours() + distance_to_end_hour;
                                end_minute = end_time.getMinutes() + distance_to_end_minute;
                            }
                            
                            if(end_hour < event_data.begin_day || (end_hour == event_data.begin_day && end_minute <= 30))
                            {
                                end_hour = end_time.getHours() - distance_to_begin_hour;
                                end_minute = end_time.getMinutes() - distance_to_begin_minute;
                                
                                start_hour = start_time.getHours() - distance_to_begin_hour;
                                start_minute = start_time.getMinutes() - distance_to_begin_minute;
                            }
                            if(end_hour > event_data.end_day || (end_hour == event_data.end_day && end_minute > 0))
                            {
                                end_hour = end_time.getHours() + distance_to_end_hour;
                                end_minute = end_time.getMinutes() + distance_to_end_minute;
                                
                                start_hour = start_time.getHours() + distance_to_end_hour;
                                start_minute = start_time.getMinutes() + distance_to_end_minute;
                            }
                            
                            if(start_minute < 0)
                            {
                                start_minute += 60;
                                start_hour--;
                            }
                            if(start_minute >= 60)
                            {
                                start_minute -= 60;
                                start_hour++;
                            }
                            if(end_minute < 0)
                            {
                                end_minute += 60;
                                end_hour--;
                            }
                            if(end_minute >= 60)
                            {
                                end_minute -= 60;
                                end_hour++;
                            }
                            if(end_hour >= 24)
                            {
                                end_hour = 23;
                                end_minute = 59;
                            }
                        }
                    }
                    if(date_start_dragging.getTime() == date_start_event.getTime())
                    {
                        string_time = formatTimeString(start_hour,start_minute) + '-' + parseday(end_time,short_date_format,locale);
                    }
                    if(date_start_dragging.getTime() == date_end_event.getTime())
                    {
                        string_time = parseday(start_time,short_date_format,locale) + '-' + formatTimeString(end_hour,end_minute);
                    }
                }
                else
                {
                    start_hour = start_time.getHours();
                    start_minute = start_time.getMinutes();
                    end_hour = end_time.getHours();
                    end_minute = end_time.getMinutes();
                    string_time = parseday(start_time,short_date_format,locale) + '-' + parseday(end_time,short_date_format,locale);
                }
                div_tooltip_timespan.html(string_time);
                
                start_time.setDate(new_date_start_event.getDate());
                start_time.setMonth(new_date_start_event.getMonth());
                start_time.setYear(new_date_start_event.getFullYear());
                end_time.setDate(new_date_end_event.getDate());
                end_time.setMonth(new_date_end_event.getMonth());
                end_time.setYear(new_date_end_event.getFullYear());
                time_after_drag_drop = {'start_hour':start_hour,'start_minute':start_minute,'end_hour':end_hour,'end_minute':end_minute,'bdate':start_time,'edate':end_time,'event_id':event_dragging.data('event_id')};
                
                var key = 1;
                date_columns.each(function(){
                    var current_day = $(this).data('date');
                    var tempEvent = $(this).find('div.tempEvent');
                    var tempTopStartTime,tempHeightStartTime,tempTopEndTime,tempHeightEndTime;

                    if(current_day.getTime()  == new_date_start_event.getTime())
                    {
                        tempTopStartTime = start_hour - event_data.begin_day;
                        if(start_minute > 0)
                        {
                            tempTopStartTime = tempTopStartTime + (start_minute/60);
                        }
                        tempTopStartTime = tempTopStartTime/height_column*100;
                        tempHeightStartTime = 100 - tempTopStartTime;
                        tempEvent.html(container.data('title').clone());
                        tempEvent.css({'height':tempHeightStartTime+'%','top':tempTopStartTime+'%'});
                        tempEvent.show();
                    }
                    else
                    {
                        if(current_day.getTime() == new_date_end_event.getTime())
                        {
                            tempHeightEndTime = end_hour - event_data.begin_day;
                            if(end_minute > 0)
                            {
                                tempHeightEndTime = tempHeightEndTime + (end_minute/60);
                            }
                            tempHeightEndTime = tempHeightEndTime/height_column*100;
                            tempEvent.html(container.data('title').clone());
                            tempEvent.css({'height':tempHeightEndTime+'%','top':'0%'});
                            tempEvent.show();
                        }
                        else
                        {
                            if(current_day.getTime() > new_date_start_event.getTime() && current_day.getTime() < new_date_end_event.getTime())
                            {
                                tempEvent.html(container.data('title').clone());
                                tempEvent.css({'height':'100%','top':'0%'});
                                tempEvent.show();
                            }
                            else
                            {
                                tempEvent.hide();
                            }
                        }
                    }
                });
            });
            dummy_container.hide();
        }
        return this.each (function (){
            $(this).on("mouseover", function() {
                $.each(opts.group || {}, function(key,value) {
                    if(!is_dragging)
                    {
                        $(value).css('background-color','').addClass('personal_over_schedule');
                    }
                });
                var documentWidth,documentHeight;
                if (!$(this).data("init")) {
                    $(this).data("init", true).draggable(opts,{
                        helper: function(){
                            return $('<div/>');
                        },
                        start: function (ev,ui) {
                            during_dragdrop = true;
                            is_dragging = true;
                            dummy_container.css({'width':container.width()+'px','height':container.height()+'px','position':'absolute','z-index':'1001','cursor':'move'}).show();
                            
                            container.data('check_first',false);
                            container.data('calculate_distance',false);
                            var thisObj = $(this);
                            var event_data = get_event_data(thisObj);
                            var start_time = parse_datetime(event_data.start_date),
                                end_time = parse_datetime(event_data.end_date);
                            if(start_time.getMinutes() != 0 && start_time.getMinutes() != 30)
                            {
                                container.data('check_first',true);
                            }
                            container.data('start_time',start_time);
                            container.data('end_time',end_time);
                            container.find('div.tempEvent').addClass('dragging_schedule');
                            
                            var title;
                            $.each(opts.group || {}, function(key,value) {
                                $(value).addClass('original_schedule');
                                title = $($(value).data('title'));
                                container.data('title',title);
                            });
                            
                            // init for show time when dragging
                            var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(stringSpanTime(thisObj));
                            div_tooltip_timespan.css({'position':'absolute','top':ev.pageY+10+'px','z-index':'99'});
                            $('body').append(div_tooltip_timespan);
                            documentWidth = $(document).width();
                            documentHeight = $(document).height();
                            setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
                
                            opts.startNative ? opts.startNative() : {};
                        },
                        drag: function(ev,ui) {
                            // hide tooltip event
                            $("div.cotainerTooltip").remove();//htvs
                            container.data('event_dragging',$(this));
                            $.each(opts.group || {}, function(key,value) {
                            });

                            // show time when dragging
                            var div_tooltip_timespan = $('div.showTimeSpanTitle');
                            // prevent drag pointer out of document width
                            setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);
                            
                            // prevent drag pointer out of document height
                            setTopTooltip(div_tooltip_timespan,ev.pageY,documentHeight);
                            
                            opts.dragNative ? opts.dragNative() : {};
                        },
                        stop: function(ev,ui) {
                            is_dragging = false;
                            container.data('check_save_original_position',false);
                            container.find('div.tempEvent');
                            dummy_container.hide();
                            
                            $.each(opts.group || {}, function(key,value) {
                                $(value).removeClass('original_schedule').hide();
                            });
                            
                            $('div.showTimeSpanTitle').remove();
                            
                            var element = $(this);
                            var callback = function(opts,container){
                                $.each(opts.group || {}, function(key,value) {
                                    $(value).show();
                                });
                                container.find('div.tempEvent').hide();
                            };
                            
                            if(schedule_is_drag_to_another_time(element))
                            {
                                executeAfterDragDrop(element,ev,callback,opts,container);
                            }
                            else
                            {
                                $.each(opts.group || {}, function(key,value) {
                                    $(value).show();
                                });
                                container.find('div.tempEvent').hide();
                            }
                            
                            opts.stopNative ? opts.stopNative() : {};
                        }
                    });
                }
            });
            $(this).on("mouseout", function() {
                $.each(opts.group || {}, function(key,value) {
                    $(value).removeClass('personal_over_schedule');
                });
            });
        });
    };
 }(jQuery));

(function($){
    $.fn.GRN_DragDropScheduleVertical_Personal = function(){
        var element;
        return this.each(function(){
            element = $(this);
            if(element.hasClass("tempEvent"))
            {
                return;
            }
            init();
        });
        
        function init()
        {
            element.mouseenter(function(e){
                thisObj = $(this);
                if(resizing || is_dragging || !check_event_can_drag_drop(thisObj))
                {
                    return;
                }
                thisObj.css({'background-color':'','z-index':'2'}).addClass('personal_over_schedule');
                if(check_event_have_handle(thisObj,'top'))
                {
                    var div = $('<div class="dragdrop_handle" style="text-align:center;margin-top:-2px;"/>');
                    div.append($('<div class="resizer_top"/>'));
                    div.appendTo(thisObj);
                }
                if(check_event_have_handle(thisObj,'bottom'))
                {
                    var div_bottom = $('<div class="dragdrop_handle" style="text-align:center;margin-bottom:-2px;"/>');
                    div_bottom.append($('<div class="resizer_bottom"/>'));
                    div_bottom.appendTo(thisObj);
                }
            });
            element.mouseleave(function(e){
                if(!resizing)
                {
                    $(this).css({'background-color':'','z-index':''}).removeClass('personal_over_schedule').find('div.dragdrop_handle').remove();
                }
            });
        }
    };
})(jQuery);

function setLeftTooltip(element,position,documentSize)
{
    var div_tooltip_timespan_width = element.width();
    var paramsLeft = {
        position : position,
        size : div_tooltip_timespan_width,
        documentSize : documentSize,
        distanceTotal : 40, // total distance: distance from pointer + margin of element
        distanceTooltip : 30, // 30px is distance from tooltip timespan to document width
        distanceMargin : 20, // 20px is default value of distance horizontal from pointer to tooltip timespan
        type : 'left'
    };
    setPositionTooltipTimeSpan(element,paramsLeft);
}

function setTopTooltip(element,position,documentSize)
{
    var div_tooltip_timespan_height = element.height();
    var paramsTop = {
        position : position,
        size : div_tooltip_timespan_height,
        documentSize : documentSize,
        distanceTotal : 25, // total distance: distance from pointer + margin of element
        distanceTooltip : 15, // 30px is distance from tooltip timespan to document height
        distanceMargin : 10, // 20px is default value of distance vertical from pointer to tooltip timespan
        type : 'top'
    };
    setPositionTooltipTimeSpan(element,paramsTop);
}

function setPositionTooltipTimeSpan(element,params)
{
    if(params.position + params.distanceTotal + params.size > params.documentSize)
    {
        element.css(params.type,(params.documentSize - params.distanceTooltip - params.size) + 'px');
    }
    else
    {
        element.css(params.type,params.position + params.distanceMargin +'px');
    }
}

function returnOriginalUI()
{
    jQuery('.dragging_schedule').each(function(){
        jQuery(this).removeClass('dragging_schedule');
    });
    jQuery('.resizing_schedule').each(function(){
        jQuery(this).removeClass('resizing_schedule');
    });
}

function executeAfterDragDrop(element,ev,callback,opts,container)
{
    //show dialog waiting
    var request;
    var dialog_waiting = new GRN_Dlg(element,ev);
    dialog_waiting.callback = function (result) {
        if(result == 'cancel')
        {
            request.abort();
            callback(opts,container);
        }
    };
    dialog_waiting.show();
    var bdate = element.data('bdate');
    var start_date = jQuery.datepicker.formatDate('yy-mm-dd', time_after_drag_drop.bdate);
    var end_date = '';
    if(time_after_drag_drop.edate)
    {
        end_date = jQuery.datepicker.formatDate('yy-mm-dd', time_after_drag_drop.edate);
    }
    var event_data = get_event_data(element);
    if(!check_schedule_on_one_date(event_data) && (event_data.type == "repeat" || event_data.type == "share_repeat") && !event_data.end_datetime)
    {
        bdate = event_data.start_date.substr(0,10);
    }
    request = jQuery.ajax({
        url: _url_ajax_checking,
        data: {
            csrf_ticket: csrf_ticket,
            event_id: element.data('event_id'),
            uid: element.data('uid'),
            gid: element.data('gid'),
            referer_key: element.data('referer_key'),
            bdate: bdate,
            start_date: start_date,
            end_date: end_date,
            start_hour: time_after_drag_drop.start_hour,
            start_minute: time_after_drag_drop.start_minute,
            end_hour: time_after_drag_drop.end_hour,
            end_minute: time_after_drag_drop.end_minute,
            is_personal: true
        },
        type: "POST",
        success: function(response,textStatus,jqXHR ){
            if (grn.component.error_handler.hasCybozuError(jqXHR))
            {
                GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                return;
            }
            if (grn.component.error_handler.hasCybozuLogin(jqXHR))
            {
                location.href = location.href;
                return;
            }
            dialog_waiting.hide();
            var dialog_checking = new GRN_Dlg(element,ev,response);
            dialog_checking.show();
            dialog_checking.callback = function (result) {
                if(result == 'cancel')
                {
                    callback(opts,container);
                }
            };
        },
        error: function(jqXHR,textStatus,errorThrown){
            if(textStatus != 'abort')
            {
                GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
            }
        },
        complete: function(xhr, status){

        }
    });
}

function get_event_data(ev)
{
    var event_id = ev.data('event_id');
    var bdate = ev.data('bdate');
    var plid = ev.data('plid');
    if(typeof plid != 'undefined' && plid != '')
    {
        if(ev.data('end_datetime'))
        {
            return list_data_event[plid][bdate][event_id+ev.data('end_datetime')];
        }
        else
        {
            return list_data_event[plid][bdate][event_id];
        }
    }
    else
    {
        if(ev.data('end_datetime'))
        {
            return list_data_event[bdate][event_id+ev.data('end_datetime')];
        }
        else
        {
            return list_data_event[bdate][event_id];
        }
    }
}

function check_schedule_on_one_date(data_event)
{
    if(data_event.same_time)
    {
        return true;
    }
    if('end_date' in data_event)
    {
        var start_time = parse_datetime(data_event.start_date);
        var end_time = parse_datetime(data_event.end_date);
        if((start_time.getDate() == end_time.getDate() && start_time.getMonth() == end_time.getMonth() && start_time.getYear() == end_time.getYear()) || (end_time.getHours() == 0 && end_time.getMinutes() == 0 && start_time.getDate() == end_time.getDate() - 1 && start_time.getMonth() == end_time.getMonth() && start_time.getYear() == end_time.getYear()))
        {
            return true;
        }
        return false;
    }
    else
    {
        return true;
    }
}

function schedule_is_drag_to_another_time(ev)
{
    if(typeof time_after_drag_drop == 'undefined' || !time_after_drag_drop)
    {
        return false;
    }
    var data_event = get_event_data(ev);
    var old_start_time = parse_datetime(data_event.start_date);
    var old_end_time;
    if('end_date' in data_event)
    {
        old_end_time = parse_datetime(data_event.end_date);
    }
    
    if(time_after_drag_drop.end_hour == 24 && time_after_drag_drop.end_minute == 0)
    {
        time_after_drag_drop.end_hour = 0;
        time_after_drag_drop.edate.setDate(time_after_drag_drop.edate.getDate() + 1);
    }
    
    if('end_date' in data_event)
    {
        if(old_start_time.getHours() == time_after_drag_drop.start_hour &&
           old_start_time.getMinutes() == time_after_drag_drop.start_minute &&
           old_end_time.getHours() == time_after_drag_drop.end_hour &&
           old_end_time.getMinutes() == time_after_drag_drop.end_minute &&
           old_start_time.getDate() == time_after_drag_drop.bdate.getDate())
        {
            return false;
        }
        return true;
    }
    else
    {
        if(old_start_time.getHours() == time_after_drag_drop.start_hour &&
           old_start_time.getMinutes() == time_after_drag_drop.start_minute &&
           old_start_time.getDate() == time_after_drag_drop.bdate.getDate() &&
           !time_after_drag_drop.end_hour && !time_after_drag_drop.end_minute)
        {
            return false;
        }
        return true;
    }
}

function check_event_can_drag_drop(ev)
{
    var data_event = get_event_data(ev);
    if(data_event.type == 'share_temporary' || data_event.type == 'temporary' || 'private' in data_event)
    {
        return false;
    }
    return true;
}

function check_event_have_handle(ev,direction)
{
    var data_event = get_event_data(ev);
    var datetime;
    if(direction == 'top')
    {
        if('end_date' in data_event)
        {
            datetime = parse_datetime(data_event.start_date);
        }
        else
        {
            return false;
        }
    }
    if(direction == 'bottom')
    {
        if('end_date' in data_event)
        {
            datetime = parse_datetime(data_event.end_date);
        }
        else
        {
            return true;
        }
    }
    var bdate = parse_datetime(ev.data('bdate'));
    if(datetime.getDate() != bdate.getDate())
    {
        return false;
    }
    return true;
}

(function($,win){
    var dlgTemplate =
    '<div class="dialog_base_grn">'+
        '<div class="daialog_mainarea_grn">'+
            '<form method="post" action="">'+
                '<div class="mBottom15 tAlignCenter-grn">' +
                    '<div class="bold"></div>' +
                    '<div class="spinnerBoxBase-grn mTop15">' +
                        '<div class="spinnerBox-grn"></div>' +
                    '</div>' +
                '</div>'+
                '<div class="daialog_indent_grn">'+
                    '<div class="mTop20 nowrap-grn buttonArea-grn">'+
                        '<span id="schedule_submit_button_loading"></span>'+
                        '<span class="mRight15 aButtonStandardDisable-grn"><span class="btn_yes buttonSpacePlus-grn"></span></span>'+
                        '<span class="aButtonStandard-grn mRight15"><a class="btn_cancel" href="javascript:void(0);"><span ></span></a></span>'+
                        '<span class="nowrap-grn mLeft15"><a class="btn_edit_detail icon-advance-grn"></a></span>'+
                    '</div>'+
                '</div>'+
            '</form>'+
        '</div>'+
    '</div>';

    win.GRN_Dlg = function(el,ev,response_data) {
        var self = this;
        var dialog;
        this.el = el;
        this.ev = ev;
        this.enable_btn_yes = true;
        this.enable_link_facilities = true;
        var bdate = el.data('bdate');
        var btn_yes;

        if(typeof response_data != 'undefined')
        {
            this.dialog = $($.parseHTML(response_data)).filter("*");
            dialog = this.dialog;
            btn_yes = dialog.find('a.btn_yes');
            btn_yes.prop("onclick", null);
            var disable_btn = dialog.find('#span_update.aButtonStandardDisable-grn');
            if(disable_btn.length > 0)
            {
                this.enable_btn_yes = false;
                var usingPurposeElement = dialog.find('div.using_purpose_element');
                var defaultUsingPurpose = dialog.find('#using_purpose').val();
                dialog.click(function(e){
                    if(dialog.find('input[type=checkbox][class*=alter_fid]:checked').length > 0 ||
                        dialog.find('input[type=checkbox][id=chk_not]:checked').length > 0)
                    {
                        self.enable_btn_yes = true;
                        disable_btn.removeClass('aButtonStandardDisable-grn').addClass('aButtonStandard-grn');
                    }
                    else
                    {
                        self.enable_btn_yes = false;
                        disable_btn.addClass('aButtonStandardDisable-grn').removeClass('aButtonStandard-grn');
                    }

                    if(dialog.find('input[type=checkbox][class*=approval_facility_item]:checked').length > 0)
                    {
                        usingPurposeElement.show();
                    }
                    else
                    {
                        dialog.find('#using_purpose').val(defaultUsingPurpose);
                        usingPurposeElement.hide();
                    }
                });
                dialog.find('input[type=checkbox][id=chk_not]').click(function(){
                    var candidacy_grn = dialog.find('.candidacy_grn');
                    if($(this).is(':checked'))
                    {
                        dialog.find('input[type=checkbox][class*=alter_fid]:checked').prop('checked', false);
                        candidacy_grn.addClass('candidacy_disable_grn');
                        self.enable_link_facilities = false;
                    }
                    else
                    {
                        candidacy_grn.removeClass('candidacy_disable_grn');
                        self.enable_link_facilities = true;
                    }
                });
                dialog.find('input[type=checkbox][class*=alter_fid]').click(function(){
                    if($(this).is(':checked'))
                    {
                        dialog.find('input[type=checkbox][id=chk_not]:checked').prop('checked', false);
                        dialog.find('.candidacy_grn').removeClass('candidacy_disable_grn');
                        self.enable_link_facilities = true;
                    }
                });
                dialog.find('.vAlignMiddle-grn > a').each(function(){
                    $(this).click(function(){
                        if(self.enable_link_facilities)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    });
                });
                
                dialog.find('.more_grn > a').click(function(){
                    var flag = 0;
                    var div_content_more_link = $(this).parent().parent();
                    div_content_more_link.find('div.hidden_facility').each(function(){
                        if(flag == 5) // every time click show 5 facilities
                        {
                            return;
                        }
                        flag++;
                        $(this).removeClass('hidden_facility');
                        if(div_content_more_link.find('div.hidden_facility').length < 1)
                        {
                            div_content_more_link.find('div.more_grn').remove();
                            return;
                        }
                    });
                    return false;
                });
            }

            btn_yes.click(function(){
                if(!self.enable_btn_yes)
                {
                    return;
                }
                var usingPurposeElement = dialog.find('div.using_purpose_element');
                if(usingPurposeElement.length > 0 && usingPurposeElement.is(":visible"))
                {
                    var usingPurpose = usingPurposeElement.find('#using_purpose');
                    if( usingPurpose.val().trim().length == 0 )
                    {
                        usingPurposeElement.find('div.using_purpose_error').show();
                        return;
                    }
                    else
                    {
                        usingPurposeElement.find('div.using_purpose_error').hide();
                    }
                }
                self.enable_btn_yes = false;
                var form = dialog.find('form');
                var data = form.serialize();
                var alter_fids = '';
                dialog.find('input[type=checkbox][class*=alter_fid]:checked').each(function(){
                    alter_fids += $(this).val() + ",";
                });
                if(alter_fids.length > 0)
                {
                    data += '&alter_fids=' + alter_fids;
                }

                $.post($(form).attr('action'), data, function(response, textStatus, jqXHR){
                    if (grn.component.error_handler.hasCybozuError(jqXHR))
                    {
                        GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                        return;
                    }
                    if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                    {
                        location.href = location.href;
                        return;
                    }
                    if (typeof syncEventList == "function")
                    {
                        var aeid = JSON.parse(response || "null");
                        syncEventList(self.el.data('plid'), aeid.event_id);
                        setTimeout(function() {
                            $('div.ddoverlay').remove();
                            dialog.remove();
                        }, 500);
                    }
                    else
                    {
                        setTimeout(function() { location.href = location.href; }, 1000);
                    }
                })
                .fail(function(jqXHR, textStatus, response) {
                    GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                });
            });
        }
        else
        {
            this.dialog = $(dlgTemplate);
            this.enable_btn_yes = false;
            dialog = this.dialog;
            dialog.find('div.bold').html(loading_stt);
            btn_yes = dialog.find('span.btn_yes');
            btn_yes.html(btn_yes_stt);
            
            var btn_edit_detail = dialog.find('a.btn_edit_detail');
            btn_edit_detail.html(detail_modify_stt);
            var url = detail_modify_url;
            if(el.data('type') == 'repeat')
            {
                url = detail_repeat_modify_url;
            }
            var href_link_to_detail = make_link_for_detail_modify(url,
                                                                  bdate,
                                                                  $.datepicker.formatDate('yy-mm-dd', time_after_drag_drop.bdate),
                                                                  $.datepicker.formatDate('yy-mm-dd', time_after_drag_drop.edate),
                                                                  el.data('uid'),
                                                                  el.data('gid'),
                                                                  el.data('referer_key'));
            btn_edit_detail.attr('href',href_link_to_detail);
        }
        
        var btn_cancel = dialog.find('a.btn_cancel');
        btn_cancel.find('span').html(btn_cancel_stt);
        btn_cancel.prop("onclick", null);
        btn_cancel.click(function(){
            $('div.ddoverlay').remove();
            dialog.remove();
            invokeCallback('cancel');
        });
        
        setTimeout(function(){
            if(self.enable_btn_yes)
            {
                btn_yes.focus();
            }
            else
            {
                btn_cancel.focus();
            }
        },0);
        
        function invokeCallback(result) {
            if( typeof self.callback == 'function' ) {
                self.callback(result);
            }
        }
    };
    
    win.GRN_Dlg.prototype.show = function() {
        var div_overlay = $('<div class="ddoverlay" id="ddoverlay"/>').css({'width':$(document).width()+'px','height':$(document).height()+'px','z-index':'1000'});
        $('body').append(div_overlay);
        
        var dialog = this.dialog;
        $('body').append(dialog);
        var viewportW = $(window).width() + $(window).scrollLeft();
            viewportH = $(window).height() + $(window).scrollTop();
            scrollTop = $(window).scrollTop();
        var maxLeft = (this.ev.pageX > viewportW) ? viewportW : this.ev.pageX,
            maxTop = (this.ev.pageY > viewportH) ? viewportH : this.ev.pageY;
            
        var dialog_width = dialog.width();
        var left = maxLeft - dialog_width/2,
            top = maxTop - dialog.height();
        
        if (left + dialog_width >= viewportW) {
            left = viewportW - dialog_width - 2;
        }
        if (left < 0){
            left = 0;
        }
        if (top < scrollTop + 30)
        {
            top = scrollTop + 30;
        }
        if(top > viewportH)
        {
            top = viewportH - dialog.height() - 10;
        }

        dialog.css({'position':'absolute','z-index':'1001',"left":left+"px","top":top+"px"});
    };
    
    win.GRN_Dlg.prototype.hide = function() {
        $('div.ddoverlay').remove();
        this.dialog.remove();
    };
    
    $(window).resize(function() {
        if($('div.ddoverlay').length > 0)
        {
            $('div.ddoverlay').css({'width':$(document).width()+'px','height':$(document).height()+'px','z-index':'1000'});
        }
    });
})(jQuery, window);

function removeResizingHandle(ev,element)
{
    if( ev.pageX < element.offset().left || ev.pageX > element.offset().left + element.width() ||
    ev.pageY < element.offset().top || ev.pageY > element.offset().top + element.height())
    {
        element.removeClass('personal_over_schedule').find('div.dragdrop_handle').remove();
    }
}

function calculateMinTimeDistanceToBeginEndDay(event_data,start_time,end_time)
{
    if(start_time.getHours() > end_time.getHours() || (start_time.getHours() == end_time.getHours() && start_time.getMinutes() > end_time.getMinutes()))
    {
        hour_to_begin = end_time.getHours() - event_data.begin_day;
        minute_to_begin = end_time.getMinutes() - 30;
        
        hour_to_end = event_data.end_day - 1 - start_time.getHours();
        minute_to_end = 30 - start_time.getMinutes();
    }
    else
    {
        if(start_time.getHours() == end_time.getHours() && start_time.getMinutes() == end_time.getMinutes())
        {
            hour_to_begin = end_time.getHours() - event_data.begin_day;
            minute_to_begin = end_time.getMinutes() - 30;
    
            hour_to_end = event_data.end_day - 1 - start_time.getHours();
            minute_to_end = 30 - start_time.getMinutes();

        }
        else
        {
            hour_to_begin = start_time.getHours() - event_data.begin_day;
            minute_to_begin = start_time.getMinutes();
            
            hour_to_end = event_data.end_day - 1 - end_time.getHours();
            minute_to_end = 60 - end_time.getMinutes();
        }
    }

    if(minute_to_begin < 0)
    {
        minute_to_begin += 60;
        hour_to_begin--;
    }
    min_distance_to_begin = {
        hour_to_begin : hour_to_begin,
        minute_to_begin : minute_to_begin
    };

    if(minute_to_end == 60)
    {
        minute_to_end = 0;
        hour_to_end++;
    }
    
    min_distance_to_end = {
        hour_to_end : hour_to_end,
        minute_to_end : minute_to_end
    };
    
    return {min_distance_to_begin:min_distance_to_begin,min_distance_to_end:min_distance_to_end};
}

function calculateTimeDistance(currentPosition,originalPosition)
{
    var span = currentPosition - originalPosition;
    var sign = 1;
    if(span < 0)
    {
        sign = -1;
        span = Math.abs(span);
    }
    var distance = Math.round(span / halfHourHeight);
    var distance_hour = parseInt(distance / 2);
    var distance_minute = (distance % 2) * 30;
    return {'sign':sign,'distance_hour':distance_hour,'distance_minute':distance_minute};
}

function calculateDateDistance(currentPosition,originalPosition,distance_date)
{
    if(distance_date == 0)
    {
        return 0;
    }
    return Math.round((currentPosition - originalPosition) / distance_date);
}

function calculateDragTime(currentPosition,originalPosition,ev,distance_date,start_time,end_time)
{
    var distance,start_hour,start_minute,end_hour,end_minute;
    distance = calculateTimeDistance(currentPosition.top,originalPosition.top);
    var change_date = calculateDateDistance(currentPosition.left,originalPosition.left,distance_date);
    var start = new Date(start_time.getTime());
    start_hour = start.getHours() + (distance.sign * distance.distance_hour);
    start_minute = start.getMinutes() + (distance.sign * distance.distance_minute);
    if(start_minute < 0)
    {
        start_minute = start_minute + 60;
        start_hour--;
    }
    if(start_minute >= 60)
    {
        start_minute = start_minute - 60;
        start_hour++;
    }
    start.setDate(start.getDate() + change_date);
    
    if(end_time)
    {
        var end = new Date(end_time.getTime());
        if(end.getHours() == 23 && end.getMinutes() == 59)
        {
            end_hour = 24 + (distance.sign * distance.distance_hour);
            end_minute = distance.sign * distance.distance_minute;
        }
        else
        {
            end_hour = end.getHours() + (distance.sign * distance.distance_hour);
            end_minute = end.getMinutes() + (distance.sign * distance.distance_minute);
        }
        if(end_minute < 0)
        {
            end_minute = end_minute + 60;
            end_hour--;
        }
        if(end_minute >= 60)
        {
            end_minute = end_minute - 60;
            end_hour++;
        }
        end.setDate(end.getDate() + change_date);
        if(end_hour >= 24)
        {
            end_hour = 23;
            end_minute = 59;
        }
        if(end_hour < 0)
        {
            end_hour += 24;
            end.setDate(end.getDate() - 1);
        }
        time_after_drag_drop = {'start_hour':start_hour,'start_minute':start_minute,'end_hour':end_hour,'end_minute':end_minute,'bdate':start,'edate':end,'event_id':ev.data('event_id')};
        return formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_hour,end_minute);
    }
    else
    {
        time_after_drag_drop = {'start_hour':start_hour,'start_minute':start_minute,'end_hour':'','end_minute':'','bdate':start,'edate':false,'event_id':ev.data('event_id')};
        return formatTimeString(start_hour,start_minute);
    }
}

function calculateSpanTime(ui,ev,start_time,end_time,isTopResize)
{
    var distance,start_hour,start_minute,end_hour,end_minute;
    if(ui.originalPosition.top == ui.position.top)
    {
        distance = calculateTimeDistance(ui.size.height,ui.originalSize.height);
    }
    else
    {
        distance = calculateTimeDistance(ui.position.top,ui.originalPosition.top);
    }
    
    var data_event = get_event_data(ev);

    var string = '';
    if(ui.originalPosition.top == ui.position.top && !isTopResize)
    {
        if(end_time.getHours() == 23 && end_time.getMinutes() == 59)
        {
            end_hour = 24 + (distance.sign * distance.distance_hour);
            end_minute = distance.sign * distance.distance_minute;
        }
        else
        {
            end_hour = end_time.getHours() + (distance.sign * distance.distance_hour);
            end_minute = end_time.getMinutes() + (distance.sign * distance.distance_minute);
        }
        if(end_minute < 0)
        {
            end_minute = end_minute + 60;
            end_hour--;
        }
        if(end_minute >= 60)
        {
            end_minute = end_minute - 60;
            end_hour++;
        }
        if(end_hour >= 24)
        {
            end_hour = 23;
            end_minute = 59;
        }
        if(end_hour < 0)
        {
            end_hour += 24;
            end_time.setDate(end_time.getDate() - 1);
        }
        if(end_hour > data_event.end_day || (end_hour == data_event.end_day && end_minute > 0))
        {
            end_hour = data_event.end_day;
            end_minute = 0;
        }
        time_after_drag_drop = {'start_hour':start_time.getHours(),'start_minute':start_time.getMinutes(),'end_hour':end_hour,'end_minute':end_minute,'bdate':start_time,'edate':end_time,'event_id':ev.data('event_id')};
        if(start_time.getDate() == end_time.getDate())
        {
            return data_event.start_date.substr(11,5) + '-' + formatTimeString(end_hour,end_minute);
        }
        else
        {
            return parseday(start_time,short_date_format,locale) + '-' + formatTimeString(end_hour,end_minute);
        }
    }
    else
    {
        start_hour = start_time.getHours() + (distance.sign * distance.distance_hour);
        start_minute = start_time.getMinutes() + (distance.sign * distance.distance_minute);
        if(start_minute < 0)
        {
            start_minute = start_minute + 60;
            start_hour--;
        }
        if(start_minute >= 60)
        {
            start_minute = start_minute - 60;
            start_hour++;
        }
        if(start_hour < data_event.begin_day)
        {
            start_hour = data_event.begin_day;
            start_minute = 0;
        }
        if (start_time.getDate() === end_time.getDate()) {
            if(start_hour > end_time.getHours())
                start_hour = end_time.getHours();
            if(start_hour == end_time.getHours() && start_minute > end_time.getMinutes())
                start_minute = 0;
        }
        time_after_drag_drop = {'start_hour':start_hour,'start_minute':start_minute,'end_hour':end_time.getHours(),'end_minute':end_time.getMinutes(),'bdate':start_time,'edate':end_time,'event_id':ev.data('event_id')};
        if(start_time.getDate() == end_time.getDate())
        {
            if('end_date' in data_event)
            {
                if(data_event.same_time)
                {
                    return formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_time.getHours(),end_time.getMinutes());
                }
                else
                {
                    return formatTimeString(start_hour,start_minute) + '-' + data_event.end_date.substr(11,5);
                }
            }
            else
            {
                return formatTimeString(start_hour,start_minute) + '-' + formatTimeString(end_time.getHours(),end_time.getMinutes());
            }
        }
        else
        {
            return formatTimeString(start_hour,start_minute) + '-' + parseday(end_time,short_date_format,locale);
        }
    }
}

function changeTimeBeforeResizing(currentCursor,originalCursor,resize_begin_time,data_event)
{
    var start_hour,start_minute;
    if(currentCursor - originalCursor > 0)
    {
        if(resize_begin_time.getMinutes() > 0 && resize_begin_time.getMinutes() < 30)
        {
            start_hour = resize_begin_time.getHours();
            start_minute = 30;
        }
        
        if(resize_begin_time.getMinutes() > 30)
        {
            start_hour = resize_begin_time.getHours() + 1;
            start_minute = 0;
        }
        
        if(start_hour == data_event.end_day)
        {
            start_hour = data_event.end_day - 1;
            start_minute = 30;
        }
    }
    else
    {
        if(resize_begin_time.getMinutes() > 0 && resize_begin_time.getMinutes() < 30)
        {
            start_hour = resize_begin_time.getHours();
            start_minute = 0;
        }
        
        if(resize_begin_time.getMinutes() > 30)
        {
            start_hour = resize_begin_time.getHours();
            start_minute = 30;
        }
    }
    return {start_hour:start_hour,start_minute:start_minute};
}

function changeTimeBeforeDragging(currentCursor,originalCursor,start_time,end_time,data_event)
{
    var start_hour,start_minute,end_hour,end_minute;
    if(currentCursor - originalCursor > 0)
    {
        if(start_time.getMinutes() > 0 && start_time.getMinutes() < 30)
        {
            start_hour = start_time.getHours();
            start_minute = 30;
            end_minute = end_time.getMinutes() + (30 - start_time.getMinutes());
        }
        
        if(start_time.getMinutes() > 30)
        {
            start_hour = start_time.getHours() + 1;
            start_minute = 0;
            end_minute = end_time.getMinutes() + (60 - start_time.getMinutes());
        }
        
        if(end_minute >= 60)
        {
            end_hour = end_time.getHours() + 1;
            end_minute = end_minute - 60;
        }
        else
        {
            end_hour = end_time.getHours();
        }
        
        if(start_hour == data_event.end_day)
        {
            start_hour = data_event.end_day - 1;
            start_minute = 30;
        }
        
        if(end_hour >= data_event.end_day)
        {
            end_hour = end_time.getHours() - 1;
            end_minute = end_minute - 30;
            if(end_minute < 0)
            {
                end_hour = end_hour - 1;
                end_minute = end_minute + 60;
            }
        }
    }
    else
    {
        if(start_time.getMinutes() > 0 && start_time.getMinutes() < 30)
        {
            start_hour = start_time.getHours();
            start_minute = 0;
            end_minute = end_time.getMinutes() - start_time.getMinutes();
        }
        
        if(start_time.getMinutes() > 30)
        {
            start_hour = start_time.getHours();
            start_minute = 30;
            end_minute = end_time.getMinutes() - (start_time.getMinutes() - 30);
        }
        
        if(end_minute < 0)
        {
            end_hour = end_time.getHours() - 1;
            end_minute = end_minute + 60;
        }
        else
        {
            end_hour = end_time.getHours();
        }
    }
    return {start_hour:start_hour,start_minute:start_minute,end_hour:end_hour,end_minute:end_minute};
}

function formatTimeString(hour,minute)
{
    var string = '';
    if(hour >= 10)
    {
        string += hour + ':';
    }
    else
    {
        string += '0' + hour + ':';
    }
    if(minute >= 10)
    {
        string += minute;
    }
    else
    {
        string += '0' + minute;
    }
    return string;
}

function stringSpanTime(ev)
{
    var data_event = get_event_data(ev);
    var start_time = data_event.start_date.substr(11,5);
    var end_time;
    if('end_date' in data_event)
    {
        end_time = data_event.end_date.substr(11,5);
    }
    else
    {
        var enddatetime = parse_datetime( data_event.start_date );
        enddatetime.setMinutes(enddatetime.getMinutes() + 30);
        end_time = formatTimeString(enddatetime.getHours(),enddatetime.getMinutes());
    }
    
    return start_time + '-' + end_time;
}

function stringDragTime(ev)
{
    var data_event = get_event_data(ev);
    var start_time = data_event.start_date.substr(11,5);
    var end_time;
    if('end_date' in data_event)
    {
        end_time = data_event.end_date.substr(11,5);
        return start_time + '-' + end_time;
    }
    else
    {
        return start_time;
    }
}

function make_link(url,bdate,even_id,uid,gid,referer_key)
{
    return url + 'uid=' + uid +
                 '&gid=' + gid +
                 '&referer_key=' + referer_key +
                 '&bdate=' + bdate +
                 '&event=' + even_id;
}

function make_link_for_detail_modify(url,bdate,start_date,end_date,uid,gid,referer_key)
{
    return url + 'uid=' + uid +
             '&gid=' + gid +
             '&referer_key=' + referer_key +
             '&bdate=' + bdate +
             '&start_date=' + start_date +
             '&end_date=' + end_date +
             '&event=' + time_after_drag_drop.event_id +
             '&start_hour=' + time_after_drag_drop.start_hour +
             '&start_minute=' + time_after_drag_drop.start_minute +
             '&end_hour=' + time_after_drag_drop.end_hour +
             '&end_minute=' + time_after_drag_drop.end_minute;
}

function parse_datetime(time)
{
    var myregexp = /([0-9]+)-([0-9]+)-([0-9]+) +([0-9]+):([0-9]+):([0-9]+)/;
    var match = myregexp.exec(time);
    if (match != null) {
        return new Date(match[1],match[2]-1,match[3],match[4],match[5],match[6]);
    }
    
    myregexp = /([0-9]+)-([0-9]+)-([0-9]+)/;
    match = myregexp.exec(time);
    if (match != null) {
        return new Date(match[1],match[2]-1,match[3]);
    }
    
    return false;
}

(function() {
    GRN_Schedule_Event_Slot = function(start_index, end_index, event_data_index){
        this.start_index        = start_index;
        this.end_index          = end_index;
        this.event_data_index   = event_data_index;
        this.width              = 1;
    };
    
    GRN_Schedule_Event_Slot.prototype.checkExist = function(start_index, end_index)
    {
        if((start_index <= this.start_index && this.start_index <= end_index) ||
           (this.start_index <= start_index && start_index <= this.end_index) ||
           (this.start_index <= start_index && end_index <= this.end_index) ||
           (start_index <= this.start_index && this.end_index <= end_index))
        {
            return true;
        }
        return false;
    };
    
    GRN_Schedule_Manage_Event_Util = function(){
        this.list_events = [];
    };
    
    GRN_Schedule_Manage_Event_Util.prototype.addScheduleSlot = function(start, end, event_data_index){
        this.list_events.push(new GRN_Schedule_Event_Slot(start, end, event_data_index));
    };
    
    GRN_Schedule_Manage_Event_Util.prototype.checkTimeFree = function(start, end, index){
        for(var i = 0; i < this.list_events.length; i++)
        {
            if(this.list_events[i].checkExist(start, end))
            {
                return i;
            }
        }
        return -1;
    };
    
    GRN_Schedule_Manage_Personal_Day_Util = function(date, duration, unit, begin_index,end_index){
        this.date             = date;
        this.duration         = duration;
        this.unit             = unit;
        this.begin_index      = begin_index;
        this.end_index        = end_index;
        this.stack            = [];
        this.busytime         = new GRN_Schedule_Manage_Event_Util();
    };
    
    GRN_Schedule_Manage_Personal_Day_Util.prototype.addStack = function(){
        this.stack.push(new GRN_Schedule_Manage_Event_Util());
    };
    
    GRN_Schedule_Manage_Personal_Day_Util.prototype.calculateStartPoint = function(setdatetime){
        var start = 0;
        var begin_hour_view = new Date(this.date.getFullYear(),this.date.getMonth(),this.date.getDate(),0,0,0);
        var s_index;
        if(begin_hour_view.getDate() != setdatetime.getDate())
        {
            s_index = 0;
        }
        else
        {
            if( begin_hour_view.getTime() - setdatetime.getTime() < 0 )
                start = setdatetime.getHours();
            else
                start = begin_hour_view.getHours();

            var e = start - begin_hour_view.getHours();
            var stime = e * 60;

            if ( setdatetime.getMinutes() )
            {
                stime = stime + setdatetime.getMinutes();
            }
            s_index = Math.round(stime/this.unit) - this.begin_index;
            if(s_index < 0)
            {
                s_index = 0;
            }
        }
        return s_index;
    };
    
    GRN_Schedule_Manage_Personal_Day_Util.prototype.calculateEndPoint = function(enddatetime){
        var end = 0;
        var end_hour_view = new Date(this.date.getFullYear(),this.date.getMonth(),this.date.getDate(),24,0,0);
        if( enddatetime.getTime() - end_hour_view.getTime() >= 0 )
            end = end_hour_view.getTime();
        else
            end = enddatetime.getTime();

        var etime = (end - this.date.getTime()) / 60000 ;
        var e_index = Math.round(etime/this.unit) - 1 - this.begin_index;
        if(e_index > this.end_index - this.begin_index)
        {
            e_index = this.end_index - this.begin_index - 1;
        }
        return e_index;
    };
    
    GRN_Schedule_Manage_Personal_Day_Util.prototype.addScheduleToStack = function(setdatetime,enddatetime,event_data_index){
        var stime = this.calculateStartPoint(setdatetime);
        if(setdatetime.getTime() - enddatetime.getTime() == 0)
        {
            etime = stime;
        }
        else
        {
            etime = this.calculateEndPoint(enddatetime);
        }
        
        if(etime - stime < 3)
        {
            etime = stime + 3;
            if(etime >= this.end_index - this.begin_index)
            {
                etime = this.end_index - this.begin_index - 1;
                stime = etime - 3;
            }
        }

        var added = false;
        for(var i=0; i<this.stack.length; i++)
        {
            if(this.stack[i].checkTimeFree(stime, etime) < 0)
            {
                this.stack[i].addScheduleSlot(stime, etime, event_data_index);
                added = true;
                break;
            }
        }
        
        if(!added)
        {
            this.addStack();
            this.stack[this.stack.length - 1].addScheduleSlot(stime, etime, event_data_index);
        }
        
        var flag = this.busytime.checkTimeFree(stime, etime);
        if(flag < 0)
        {
            this.busytime.addScheduleSlot(stime, etime, -1);
        }
        else
        {
            if(this.busytime.list_events[flag].start_index > stime)
            {
                this.busytime.list_events[flag].start_index = stime;
            }
            if(this.busytime.list_events[flag].end_index < etime)
            {
                this.busytime.list_events[flag].end_index = etime;
            }
        }
    };
    
    GRN_Schedule_Manage_Personal_Day_Util.prototype.calculateWidthOfEvent = function(event_slot, stack_id){
        for(var i=0; i< this.stack.length; i++)
        {
            if(i > stack_id)
            {
                if(this.stack[i].checkTimeFree(event_slot.start_index, event_slot.end_index) < 0)
                {
                    event_slot.width++;
                }
                else
                {
                    return;
                }
            }
        }
    };
})();
