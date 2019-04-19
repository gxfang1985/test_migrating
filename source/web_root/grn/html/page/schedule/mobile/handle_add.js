// namespace
grn.base.namespace("grn.page.schedule.mobile.handle_add");
(function () {
    var G = grn.page.schedule.mobile.handle_add;
    if (G.is_loaded)
    {
        return;
    }
    
    G.init = function()
    {
        G.btnAdd = $('#addBtn');
        G.btnCancel = $('#cancelBtn');
        G.usingPurposeElement = $('#using_purpose_element');
        G.requireUsingPurpose = $('#require_using_purpose');
        G.usingPurpose        = $('#using_purpose');
    };
    
    var checkSubmit = false;
    
    G.ajaxSubmit = function(formId)
    {
        if (checkSubmit || typeof formId === "undefined")
        {
            return false;
        }

        var form = $("#" + formId);
        var submitPage = form.attr("action");
        if (typeof submitPage === "undefined")
        {
            return;
        }
        G.setAjaxElement();
        if(typeof G.showRefreshDialog !== 'undefined' && G.showRefreshDialog)
        {
            if(typeof G.needRefresh !== 'undefined' && G.needRefresh)
            {
                G.setRefreshAttendanceStatusElement(1);
            }
            else
            {
                G.setRefreshAttendanceStatusElement(0);
            }
        }
        checkSubmit = true;
        grn.component.mobile_loading.show();
        
        // init form data 
        var aFormData = new FormData();
        var file = $('input[type=file]');
        if(file.length > 0)
        {
            var checked = $('input[name=attached_file]').prop('checked');
            if(typeof checked != 'undefined')
            {
                aFormData.append("file", file[0].files[0]);
            }
        }

        $("input").each(function(i) {
            var disabled = $(this).attr('disabled');
            var name = $(this).attr('name');
            if(typeof disabled != 'undefined' || typeof name == 'undefined')
            {
                return;
            }
            var type = $(this).attr('type');
            if(type == 'checkbox')
            {
                var checked = $(this).prop('checked');
                if(typeof checked == 'undefined')
                {
                    return;
                }
            }
            aFormData.append(name, $(this).val());
        });
        
        $("select").each(function(i) {
            var name = $(this).attr('name');
            if(typeof name == 'undefined')
            {
                return;
            }
            aFormData.append(name, $(this).val());
        });
        
        $("textarea").each(function(i) {
            var name = $(this).attr('name');
            if(typeof name == 'undefined')
            {
                return;
            }
            aFormData.append(name, $(this).val());
        });
        
        // using XMLHttpRequest to send formdata with file 
        var xhr = new XMLHttpRequest();
        xhr.open("POST", submitPage, true);
        xhr.setRequestHeader("X-Requested-With", 'XMLHttpRequest'); // flag ajax request 
        
        xhr.onreadystatechange = function(oEvent)
        {
            if (this.readyState !== 4)
            {
                return;
            }
            
            if (xhr.status == 200 || xhr.status >= 500)
            {
                try
                {
                    data = $.parseJSON(xhr.responseText || "null");
                }
                catch(e)
                {
                    document.write( xhr.responseText );
                    document.close();
                    return false;
                }
                
                if (grn.component.mobile_error_handler.hasCybozuError(xhr))
                {
                    grn.component.mobile_loading.remove();
                    xhr.responseJSON = data;
                    grn.component.mobile_error_handler.show(xhr);
                }
                else
                {
                    grn.component.mobile_loading.remove();
                    if(data.conflict_facility == 1)
                    {
                        G.createDuplicatedPopup(data);
                    }
                    else
                    {
                        var redirect = data.redirect;
                        if (typeof redirect !== "undefined")
                        {
                            window.location.href = redirect;
                            return;
                        }
                    }
                }
                checkSubmit = false;
                G.removeAjaxElement();
                G.removeRefreshAttendanceStatusElement();
            }
            else
            {
                grn.component.mobile_loading.remove();
                G.removeAjaxElement();
                G.removeRefreshAttendanceStatusElement();
            }
        };
        xhr.send(aFormData);
    };
    
    G.handleSubmit = function(event)
    {
        var applyRepeatModify = $('#apply');
        if(applyRepeatModify.length > 0)
        {
            if(applyRepeatModify.val() == '')
            {
                $('#validate_range').show();
                $('body').animate({scrollTop:0}, '500');
                return;
            }
            else
            {
                $('#validate_range').hide();
            }
        }
        if(!G.checkUsingPurposeNotEmpty())
        {
            return;
        }
        G.ajaxSubmit( G.formId );
        event.stopPropagation();
    };
    
    G.setAjaxElement = function()
    {
        if( $('#use_ajax').length > 0 ) return false;
        
        var element = $('<input type="hidden" id="use_ajax" name="use_ajax" value="1">');
        $('#'+G.formId).append(element);
        return true;
    };

    G.removeAjaxElement = function()
    {
        $('#use_ajax').remove();
    };
    
    G.setRefreshAttendanceStatusElement = function(value)
    {
        if( $('#refresh_status').length > 0 ) return false;
        
        var element = $('<input type="hidden" id="refresh_status" name="refresh_status" value="' + value + '">');
        $('#'+G.formId).append(element);
        return true;
    };

    G.removeRefreshAttendanceStatusElement = function()
    {
        $('#refresh_status').remove();
    };

    G.createDuplicatedPopup = function(json_obj)
    {
        var popupDup = $('#popup_duplicated');
        popupDup.find('.mobile_repeating_table_grn').empty();
        popupDup.find('.mobile_repeating_table_grn').html( G.header );
        popupDup.find('.mobile_repeating_text_small_grn').remove();
        
        var frag = document.createDocumentFragment();
        var event_except = "";
        var rowscount = 0;
        var flag = false;
        $.each( json_obj.conflict_events, function( key, value ) {
            event_except += ";"+ value.col_setdatetime;
            
            if(rowscount > 4)
            {
                flag =true;
                return;
            }
            rowscount++;
            
            var trTag = $('<tr></tr>');
                
            var tdTagTime = $('<td></td>').html(value.setdatetime);
            var span = $('<span class="mobile_icon_listmarks_grn"></span>');
            tdTagTime.prepend(span);
            trTag.append(tdTagTime);
            
            var tdTagFacility = $('<td></td>').html(value.col_facility);
            trTag.append(tdTagFacility);
            
            frag.appendChild( trTag[0] );
        });
        popupDup.find('.mobile_repeating_table_grn').append(frag);
        
        var spanRepeatCaption = popupDup.find('.mobile_repeating_text_grn');
        if(json_obj.conflict_all == 1)
        {
            spanRepeatCaption.html(G.conflict + '<br>' + G.conflictAll);
            popupDup.find('.mobile_ok_grn').hide();
            popupDup.find('.no_button').hide();
            popupDup.find('.cancel_button').show();
        }
        else
        {
            spanRepeatCaption.html(G.conflict + '<br>' + G.onlyNoConflict);
            popupDup.find('.mobile_ok_grn').show();
            popupDup.find('.no_button').show();
            popupDup.find('.cancel_button').hide();
            
            if(flag)
            {
                var div_more = $('<div class="mobile_repeating_text_small_grn">...' + G.more + '</div>');
                popupDup.find('.mobile_repeating_scroll_grn').append(div_more[0]);
            }
        }
        
        popupDup.popup("open");
        
        popupDup.find('.mobile_ok_grn').click(function(event) {
            $('#popup_duplicated').popup('close');
            $("#hfExcept").val(event_except);
            G.handleSubmit(event);
        });
        
        popupDup.find('.mobile_cancel_grn').click(function() {
            $("#hfExcept").empty();
            $('#popup_duplicated').popup('close');
        });
    };

    G.showAttendanceConfirm = function(event)
    {
        var popupAttendanceConfirm = $('#attendane_confirm_html');
        var content = popupAttendanceConfirm.html();

        var Gm = grn.component.msgbox_mobile;
        Gm.MsgBox.showAttendanceCheck(content, {
            callback : function(result, form)
            {
                var needRefresh = Gm.MsgBox.msgbox.find('#need_refresh').get(0);
                if(needRefresh.checked)
                {
                    G.needRefresh = true;
                }
                else
                {
                    G.needRefresh = false;
                }
                Gm.MsgBox._remove();
                if(result == Gm.MsgBoxResult.yes)
                {
                    G.showRefreshDialog = true;
                    G.handleSubmit(event);
                }
            },
            html_id: { overlay: 'overlay', msgbox: 'confirm_dialog' }
        });
    };

    G.oldTime = {
        startYearSelect     : $('#start_year').val(),
        startMonthSelect    : $('#start_month').val(),
        startDaySelect      : $('#start_day').val(),
        startHourSelect     : $('#start_hour').val(),
        startMinuteSelect   : $('#start_minute').val(),
        endYearSelect       : $('#end_year').val(),
        endMonthSelect      : $('#end_month').val(),
        endDaySelect        : $('#end_day').val(),
        endHourSelect       : $('#end_hour').val(),
        endMinuteSelect     : $('#end_minute').val()
    };

    G.checkShowDialog = function(event)
    {
        if(!G.checkUsingPurposeNotEmpty())
        {
            return;
        }
        
        var attendanceCheckElm = $('#attendance_check');

        if(attendanceCheckElm.length == 0 || attendanceCheckElm.val() == '')
        {
            G.handleSubmit(event);
            return;
        }

        G.currentTime = {
            startYearSelect     : $('#start_year').val(),
            startMonthSelect    : $('#start_month').val(),
            startDaySelect      : $('#start_day').val(),
            startHourSelect     : $('#start_hour').val(),
            startMinuteSelect   : $('#start_minute').val(),
            endYearSelect       : $('#end_year').val(),
            endMonthSelect      : $('#end_month').val(),
            endDaySelect        : $('#end_day').val(),
            endHourSelect       : $('#end_hour').val(),
            endMinuteSelect     : $('#end_minute').val()
        };

        var arrMapCompare = [
                'startYearSelect',
                'startMonthSelect',
                'startDaySelect',
                'startHourSelect',
                'startMinuteSelect',
                'endYearSelect',
                'endMonthSelect',
                'endDaySelect',
                'endHourSelect',
                'endMinuteSelect',
                'startTimezone',
                'endTimezone'
            ];

        var showDialogFlag = false;
        for (i = 0; i < arrMapCompare.length; i++)
        {
            if( G.oldTime[arrMapCompare[i]] !== G.currentTime[arrMapCompare[i]] )
            {
                showDialogFlag = true;
                break;
            }
        }
        
        if(showDialogFlag)
        {
            // get title of appointment
            var menu = $("input[name=menu]").val();
            menu = menu.substring(0, menu.length - 3);
            var title = $("input[name=title]").val();
            var appointmentTitle = '';
            if( menu.length == 0 && title.length == 0 )
            {
                appointmentTitle = '--';
            }
            else
            {
                if( menu.length > 0 && title.length > 0 )
                {
                    appointmentTitle = menu + ':' + title;
                }
                else
                {
                    appointmentTitle += (menu.length > 0) ? menu : '';
                    appointmentTitle += (title.length > 0) ? title : '';
                }
            }
            $("#attendance_check_confirm_title").text(appointmentTitle);
            G.showAttendanceConfirm(event);
        }
        else
        {
            G.handleSubmit(event);
        }
    };

    // GTM-1681
    G.checkUsingPurposeNotEmpty = function()
    {
        if(typeof G.usingPurposeElement != 'undefined' && G.usingPurposeElement.is(':visible'))
        {
            if( ! $.trim( G.usingPurpose.val() ) )
            {
                G.requireUsingPurpose.show();
                return false;
            }
        }
        G.requireUsingPurpose.hide();
        return true;
    };

    isInitial = false;
    $(document).on( "pagechange", function( event )
    {
        if(isInitial)
        {
            return;
        }
        isInitial = true;
        
        G.init();
        if(G.typeSchedule == 'modify' && G.needCheckShowRefreshDialog)
        {
            G.btnAdd.click( G.checkShowDialog );
        }
        else
        {
            G.btnAdd.click( G.handleSubmit );
        }
    });
    
    G.is_loaded = true;
})();
