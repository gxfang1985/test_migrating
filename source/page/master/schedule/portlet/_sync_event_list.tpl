{if $is_first_ajax_portlet}
{literal}
<script type="text/javascript">
function syncEventList()
{
    var Y = YAHOO.util,
        Dom = Y.Dom;
    var plid = arguments.length > 0 ? arguments[0] : 0;
    var p = plid_array[plid];
    if (!p) {return;}
    var eid = arguments.length == 2 ? arguments[1] : '';
    if (typeof CyScheduleGwProperty != 'undefined' && p instanceof CyScheduleGwProperty)
    {
        CyScheduleGw.ctrl('refresh', plid, eid);
    }
    else if (typeof CyScheduleUmProperty != "undefined" && p instanceof CyScheduleUmProperty)
    {
        CyScheduleUm.ctrl('refresh', plid, eid);
    }
    else if (p.name == 'view_personal_week')
    {
        url = p.ajax_path;
        jQuery.ajax({
            url: url,
            dataType : 'json',
            data: {
                plid: plid,
                event: eid,
                uid: p.uid,
                gid: p.gid,
                bdate: p.bdate,
                referer_key: p.referer
            },
            type: "POST",
            success: function(json,textStatus,jqXHR){
                if (grn.component.error_handler.hasCybozuError(jqXHR))
                {
                    showErrMsg(jqXHR, function(){
                        dialog.parentNode.removeChild(dialog);
                    });
                    return;
                }
                if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                {
                    location.href = location.href;
                    return;
                }

                aeid = json.simple_add_eid;
                begin_day_hour = json.set_hour;
                end_day_hour = json.end_hour;
                do_not_have_using_privilege[plid] = json.do_not_have_using_privilege;
                var week_new_event = json.data_event_json;
                var data_new_event = week_new_event.schedule_event;

                list_data_event[plid] = new Array();
                var params = {
                    data                 : data_new_event,
                    uid                  : p.uid,
                    gid                  : p.gid,
                    referer_key          : p.referer_key,
                    unit                 : unit,
                    banner_events        : week_new_event.banner_event,
                    begin_day            : begin_day_hour,
                    end_day              : end_day_hour,
                    container_timesheet  : '#time_event_'+plid,
                    container_banner     : '#personal_week_list_event_notime_'+plid,
                    container_list_event : '#personal_calendar_list_'+plid,
                    ajax                 : true,
                    do_not_have_using_privilege: do_not_have_using_privilege[plid],
                    plid                 : plid
                };

                display_personal_week_UI(params);
                trigger_js_api_week_index_show(params);
            },
            error: function(jqXHR,textStatus,errorThrown){
                GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
            }
        });
    }
    else if (p.name == 'view_personal_day')
    {
        url = p.ajax_path;
        jQuery.ajax({
            url: url,
            dataType : 'json',
            data: {
                plid: plid,
                event: eid,
                uid: p.uid,
                gid: p.gid,
                bdate: p.bdate,
                referer_key: p.referer
            },
            type: "POST",
            success: function(json,textStatus,jqXHR){
                if (grn.component.error_handler.hasCybozuError(jqXHR))
                {
                    showErrMsg(jqXHR, function(){
                        dialog.parentNode.removeChild(dialog);
                    });
                    return;
                }
                if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                {
                    location.href = location.href;
                    return;
                }
                
                aeid = json.simple_add_eid;
                begin_day_hour = json.set_hour;
                end_day_hour = json.end_hour;
                day_new_event = json.data_event_json;
                do_not_have_using_privilege[plid] = json.do_not_have_using_privilege;
                list_data_event[plid] = new Array();
                list_data_event[plid][p.bdate] = new Array();
                var params = {
                        options: {
                                    data         : day_new_event.schedule_event,
                                    bdate        : p.bdate,
                                    uid          : p.uid,
                                    gid          : p.gid,
                                    referer_key  : p.referer_key,
                                    page         : 'schedule/view',
                                    week         : 0,
                                    unit         : unit,
                                    begin_day    : begin_day_hour,
                                    end_day      : end_day_hour,
                                    plid         : plid
                        },
                        options_allday: {
                                    data         : day_new_event.allday_event,
                                    bdate        : p.bdate,
                                    uid          : p.uid,
                                    gid          : p.gid,
                                    referer_key  : p.referer_key
                        },
                        options_banner: {
                                    data         : day_new_event.banner_event,
                                    date         : p.bdate,
                                    is_porlet    : 1,
                                    uid          : p.uid,
                                    gid          : p.gid,
                                    referer_key  : p.referer_key
                        },
                        begin_day : begin_day_hour,
                        end_day   : end_day_hour,
                        container_timesheet: '#time_event_'+plid,
                        container_normal: '#'+date_type+'_'+plid,
                        container_allday: '#personal_day_event_notime_'+plid,
                        container_banner: '#banner_event_'+plid,
                        container_list_event: '#personal_calendar_list_'+plid,
                        ajax: true,
                        do_not_have_using_privilege: do_not_have_using_privilege[plid],
                        plid: plid
                };
                display_personal_day_UI(params);
                trigger_js_api_day_index_show(params);
            },
            error: function(jqXHR,textStatus,errorThrown){
                GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
            }
        });
    }
    else if (p.name == 'view_group_day')
    {
        AjaxObject.sendRequest('GET', p.ajax_path + '&event=' + eid, function(o) {
            var event_list = Dom.get('event_list'+plid);
            if (event_list)
            {
                if (YAHOO.env.ua.ie)
                {
                    var dummy = _getDummyElement('event_list'+plid+'_dummy');
                    dummy.innerHTML = '<table><tbody>' + o.responseText + '</tbody></table>';
                    event_list.replaceChild(dummy.firstChild.firstChild, event_list.firstChild);
                }
                else
                {
                    event_list.innerHTML = o.responseText;
                }
                rebuild_popup_title(plid);
            }
            
            var params = {
                bdate: p.bdate,
                plid: plid
            };
            trigger_js_api_group_day_index_show(params);
        });
    }
    function _getDummyElement(eid)
    {
        var dummy = YAHOO.util.Dom.get(eid);
        if (!dummy)
        {
            dummy = document.createElement('div');
            dummy.id = eid;
            document.body.appendChild(dummy);
        }
        return dummy;
    }

    /**
     * @param {object} params
     */
    function trigger_js_api_week_index_show(params) {
        var schedule_week_event_name = "schedule.calendar.weekIndex.show";
        if (typeof garoon !== "undefined"
            && typeof garoon.schedule !== "undefined"
            && typeof garoon.schedule.data !== "undefined"
            && typeof garoon.schedule.data.isCustomizationAvailable
            && garoon.schedule.data[schedule_week_event_name].portletId == params.plid) {
            // empty the content of customization space
            var $calendar = jQuery("#view_personal_week" + params.plid);
            $calendar.find("[class^='js_customization_schedule_date_']").empty();
            
            var week = [];
            params.data.forEach(function (date) {
                week.push(date.date);
            });
            var event_data = {"type": schedule_week_event_name, "viewType": "WEEK", "dates": week};
            garoon.events.trigger(schedule_week_event_name, event_data);
        }
    }

    /**
     * @param {object} params
     */
    function trigger_js_api_day_index_show(params) {
        var schedule_day_event_name = "schedule.calendar.dayIndex.show";
        if (typeof garoon !== "undefined"
            && typeof garoon.schedule !== "undefined"
            && typeof garoon.schedule.data !== "undefined"
            && typeof garoon.schedule.data.isCustomizationAvailable
            && garoon.schedule.data[schedule_day_event_name].portletId == params.plid) {

            // empty the content of customization space
            var $calendar = jQuery("#view_personal_day_main" + params.plid);
            $calendar.find("[class^='js_customization_schedule_date_']").empty();

            var event_data = {"type": schedule_day_event_name, "viewType": "DAY", "dates": [params.options.bdate]};
            garoon.events.trigger(schedule_day_event_name, event_data);
        }
    }

    /**
     * @param {object} params
     */
    function trigger_js_api_group_day_index_show(params) {
        var schedule_group_day_event_name = "schedule.calendar.groupDayIndex.show";
        if (typeof garoon !== "undefined"
            && typeof garoon.schedule !== "undefined"
            && typeof garoon.schedule.data !== "undefined"
            && typeof garoon.schedule.data.isCustomizationAvailable
            && garoon.schedule.data[schedule_group_day_event_name].portletId == params.plid) {

            // empty the content of customization space
            var $calendar = jQuery("#view_group_day_main" + params.plid);
            $calendar.find("[class^='js_customization_schedule_date_']").empty();

            var event_data = {"type": schedule_group_day_event_name, "viewType": "GROUP_DAY", "dates": [params.bdate]};
            garoon.events.trigger(schedule_group_day_event_name, event_data);
        }
    }
}
</script>
{/literal}
{/if}
