{literal}
<style type="text/css">
.tableFixed{
  width:100%;
  table-layout:fixed;
}

.normalEvent {}
.normalEventElement{}

.showEventTitle{
  position:absolute;
  max-width: 300px;
  overflow:hidden;
  z-index: 20;
}

.hideEventTitle{}
.hideEventTitle .normalEvent {
  overflow:hidden;
  vertical-align:top;
}

.userElement{
    overflow:hidden;
}

.nowrap_class{
    white-space:nowrap;
    padding:2px;
    overflow:hidden;
}
</style>
{/literal}

{* Show full or short title
$function_click : name of function show full title
*}
<span id="measure_string" style="visibility:hidden;white-space:nowrap;"></span>
<script type="text/javascript" language="javascript">
{literal}
    var isScheduleGroupDay = false;
    var popup_dimensions = {};
    Event.observe(document, 'mousemove', getMousePosition);
    Event.observe(document, 'mouseover', getMousePosition);
    var mouse_position = null;
    function getMousePosition(e){
        mouseX = Event.pointerX(e);
        mouseY = Event.pointerY(e);
        mouse_position = {x:mouseX,y:mouseY};
        
        // hide popup with schedule Group Day
        if( isScheduleGroupDay )
        {
            if( mouseX < popup_dimensions.left || mouseX > popup_dimensions.left + popup_dimensions.width ||
                mouseY < popup_dimensions.top || mouseY > popup_dimensions.top + popup_dimensions.height )
            {
                var popup_title = $('popup_show_title');
                if(popup_title){
                    popup_title.remove();
                }
            }
        }
        
        return true;
    }

    function isGroupWeekPortlet(){
        if( typeof gw_table_prefix_items !== 'undefined' ){
            return true;
        }
        return false;
    }
    
    // page_on_load show that page is just on load
    function showFullShortTitle(check_id,schedule_id,page,page_on_load)
    {
        if(check_id == 'show_title_phonemessage')
        {
            showTitlePhoneMsg(schedule_id);
            return;
        }
        
        // check groupday or groupweekschedule
        if( page == "group_day" || page == "view_group_day" || page == "confirm" )
            isScheduleGroupDay = true;
        else
            isScheduleGroupDay = false;

        var show_full_title = $(check_id);
        if( !show_full_title )
            return;
        var scheduleWrapper = $(schedule_id);
        //var normalEventElements = scheduleWrapper.select('div.normalEventElement');
        var normalEventElements = fastGetElementsByClassName(schedule_id,'div','normalEventElement');
        var status = 0;

        // show full title
        if( show_full_title.checked )
        {
            if(!page_on_load)
            {
                scheduleWrapper.removeClassName('tableFixed');
                scheduleWrapper.removeClassName('hideEventTitle');
                
                if( isGroupWeekPortlet() ){
                    gw_table_prefix_items['classes'] = gw_table_prefix_items['classes'].without('tableFixed', 'hideEventTitle');
                }
                
                // show or hide shortcut
                scheduleWrapper.select('div.shortcut_box_full').each(function(e){
                    e.show();
                });
                scheduleWrapper.select('div.shortcut_box_short').each(function(e){
                    e.hide();
                });
            }
            
            // remove nowrap_class of username
            var userElements = scheduleWrapper.select('td.userBox')
            userElements.each(function(userElement){
                userElement.removeClassName('nowrap_class');
            });
            
            normalEventElements.each(function(e){
                e.stopObserving("mouseover");
                e.stopObserving("mouseout");
            });
            status = 1;
        }
        else // short title, full when over
        {
            if(!page_on_load)
            {
                scheduleWrapper.addClassName('tableFixed');
                scheduleWrapper.addClassName('hideEventTitle');
                
                if( isGroupWeekPortlet() ){
                    gw_table_prefix_items['classes'].push('tableFixed');
                    gw_table_prefix_items['classes'].push('hideEventTitle');
                }
                
                // show or hide shortcut
                scheduleWrapper.select('div.shortcut_box_full').each(function(e){
                    e.hide();
                });
                scheduleWrapper.select('div.shortcut_box_short').each(function(e){
                    e.show();
                });
            }
            processDisplayUserName(schedule_id);
            var body = $('body');
            normalEventElements.each(function(e){
                // save schedule type
                e.isScheduleGroupDay = isScheduleGroupDay;
                
                e.observe("mouseover", function(event){
                    if(typeof disable_tooltip == "undefined" || disable_tooltip == 0)
                    {
                        if(isTouchDevice()){return;}
                        // assign schedule type
                        isScheduleGroupDay = e.isScheduleGroupDay;

                        var popup_title = $('popup_show_title');
                        if(popup_title){
                            popup_title.remove();
                        }
                        var normalEvent = e.up('td.normalEvent');

                        // create popup
                        var popup_title = new Element('div', {id: 'popup_show_title', 'class': 'showEventTitle'});
                        popup_title.insert(e.innerHTML);
                        
                        // disable link
                        if( !isScheduleGroupDay )
                        {
                            var a_tag = popup_title.select('a')[0];
                            if(a_tag){
                                a_tag.removeAttribute('href');
                            }
                        }
                        else
                        {
                            // register star
                            var popup_star_item = popup_title.select('.star')[0];
                            var event_star_item = e.select('.star')[0];
                            if(popup_star_item && event_star_item.star_list){
                                popup_star_item.observe('click', event_star_item.star_list._onClick.bind(event_star_item.star_list,popup_star_item));
                            }
                        }
                        
                        // append to body
                        body.appendChild(popup_title);
                        
                        // position
                        if( isScheduleGroupDay )
                        {
                            var pos = findPositionElement(e);
                            mouse_position.x = pos.left;
                            mouse_position.y = pos.top;
                            popup_title.setStyle({top: mouse_position.y + 'px', left: mouse_position.x + 'px'});
                        }
                        else
                        {
                            popup_title.setStyle({top: mouse_position.y + 5 + 'px', left: mouse_position.x + 5 + 'px'});
                        }
                        
                        // caculate width for IE
                        var IE = document.all ? true : false;
                        if(IE)
                        {
                            var tooltip_width = measureStringByPixel(popup_title.innerHTML) + 20;
                            var body_width = Math.max(body.clientWidth, body.scrollWidth);
                            if( mouse_position.x + tooltip_width > body_width ){
                                tooltip_width = body_width - mouse_position.x;
                            }
                            if(tooltip_width > 300){
                                tooltip_width = '300';
                            }
                            popup_title.setStyle({width:tooltip_width + 'px'});
                        }
                        
                        // store popup dimension
                        popup_dimensions.top = mouse_position.y;
                        popup_dimensions.left = mouse_position.x;
                        popup_dimensions.width = popup_title.getWidth();
                        popup_dimensions.height = popup_title.getHeight();
                    }
                });
                
                // remove popup when mouse leave
                if( !isScheduleGroupDay )
                {
                    e.observe("mouseout", function(event){
                        var popup_title = $('popup_show_title');
                        if(popup_title){
                            popup_title.remove();
                        }
                    });
                }
            });
            status = 0;
        }
        // save status
        if(!page_on_load)
        {
            new Ajax.Request(
                show_full_title_url,
                {
                    'method':'POST',
                    'parameters':'status='+status + '&page='+ page +
                        '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                }
            );
            /* GTM-101 */
            /* Drag drop schedule */
            /*
            if( isScheduleGroupDay )
            {
                if( page == "view_group_day" )
                {
                    dd_remove(schedule_id.substring(10));
                    dd_init("",schedule_id.substring(10));
                    dd_handle(schedule_id.substring(10));
                }
                else if( page == "group_day" )
                {
                    dd_remove();
                    dd_init();
                    dd_handle();
                }
            }
            */
            /* End GTM-101 */
        }
    }
    
    // process display user name
    function processDisplayUserName(schedule_id)
    {
        var scheduleWrapper = $(schedule_id);
        if(!scheduleWrapper)
            return;
        var userBoxs = scheduleWrapper.select('td.userBox');
        userBoxs.each(function(userBox){
            userBox.addClassName('nowrap_class');
        });
    }
    
    // measure length of string by pixel
    function measureStringByPixel(data){
        var measure= $('measure_string');
        measure.update(data);
        var width = measure.offsetWidth;
        measure.update("");
        return width;
    }
    
    // find position on IE
    function findPositionElement(obj){
        var left = 0;
        var top = 0;
        if(obj.offsetParent)
        {
            do {
                left += obj.offsetLeft;
                top += obj.offsetTop;
            } while (obj = obj.offsetParent);
        }
        return {left:left,top:top};
    }
    
    function showTitlePhoneMsg(schedule_id)
    {
        processDisplayUserName(schedule_id);
        var body = $('body');
        var normalEventElements = fastGetElementsByClassName(schedule_id,'div','normalEventElement');
        normalEventElements.each(function(e){
            e.observe("mouseover", function(event){
                var popup_title = $('popup_show_title');
                if(popup_title){
                    popup_title.remove();
                }
                var normalEvent = e.up('td.normalEvent');

                // create popup
                var popup_title = new Element('div', {id: 'popup_show_title', 'class': 'showEventTitle'});
                popup_title.insert(e.innerHTML);
                
                var a_tag = popup_title.select('a')[0];
                if(a_tag){
                    a_tag.removeAttribute('href');
                }
                
                // append to body
                body.appendChild(popup_title);
                
                popup_title.setStyle({top: mouse_position.y + 5 + 'px', left: mouse_position.x + 5 + 'px'});
                
                // caculate width for IE
                var IE = document.all ? true : false;
                if(IE)
                {
                    var tooltip_width = measureStringByPixel(popup_title.innerHTML) + 20;
                    var body_width = Math.max(body.clientWidth, body.scrollWidth);
                    if( mouse_position.x + tooltip_width > body_width ){
                        tooltip_width = body_width - mouse_position.x;
                    }
                    if(tooltip_width > 300){
                        tooltip_width = '300';
                    }
                    popup_title.setStyle({width:tooltip_width + 'px'});
                }
                
                // store popup dimension
                popup_dimensions.top = mouse_position.y;
                popup_dimensions.left = mouse_position.x;
                popup_dimensions.width = popup_title.getWidth();
                popup_dimensions.height = popup_title.getHeight();
            });
            
            e.observe("mouseout", function(event){
                var popup_title = $('popup_show_title');
                if(popup_title){
                    popup_title.remove();
                }
            });
        });
    }
    
{/literal}
</script>

{* initShowFullShortTitle when onload*}
<script type="text/javascript" language="javascript">
    var show_full_title_url = "{grn_pageurl page='schedule/command_show_full_title'}";
    Event.observe( window, 'load', function(event){ldelim}
        {$function_click|grn_noescape}
        {rdelim});
</script>
