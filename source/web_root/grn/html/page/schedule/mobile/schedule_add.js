// namespace
grn.base.namespace("grn.page.schedule.mobile.schedule_add");
(function () {
    var G = grn.page.schedule.mobile.schedule_add;
    if (G.is_loaded)
    {
        return;
    }

    G.init = function()
    {
        G.startYearSelect = $('#start_year');
        G.startMonthSelect = $('#start_month');
        G.startDaySelect = $('#start_day');
        G.startHourSelect = $('#start_hour');
        G.startMinuteSelect = $('#start_minute');
        G.endYearSelect = $('#end_year');
        G.endMonthSelect = $('#end_month');
        G.endDaySelect = $('#end_day');
        G.endHourSelect = $('#end_hour');
        G.endMinuteSelect = $('#end_minute');
        G.startTimezone = $('#timezone');
        G.endTimezone = $('#end_timezone');
        G.validateDateStyle = $('#validate_date');
        G.invalidDateStyle = $('#invalid_date');
        G.addBtn = $('#addBtn');
        G.allday = $('#notime');
        G.changeRepeatAdd = $('#tab-repeat-schedule');
        G.usingPurposeElement = $('#using_purpose_element');
        G.approval = $('#approval');
        G.timezoneInfo = GRN_TimezoneInfo;
    };

    G.setEndTime = function()
    {
        if (G.startHourSelect.val() != '' && G.startMinuteSelect.val() == '' && G.endHourSelect.val() == '' && G.endMinuteSelect.val() == '')
        {
            if (G.startHourSelect.val() == '23')
            {
                G.endHourSelect.val(parseInt(G.startHourSelect.val())).trigger('change');
            }
            else
            {
                G.endHourSelect.val(parseInt(G.startHourSelect.val()) + 1).trigger('change');
            }
            G.endMinuteSelect.val(0).trigger('change');
            G.startMinuteSelect.val(0).trigger('change');
        }
    };

    G.onChangeDateTime = function()
    {
        var startYear = parseInt(G.startYearSelect.val()),
            startMonth = parseInt(G.startMonthSelect.val()),
            startDay = parseInt(G.startDaySelect.val()),
            startHour = G.startHourSelect.val(),
            startMinute = G.startMinuteSelect.val(),
            endYear = parseInt(G.endYearSelect.val()),
            endMonth = parseInt(G.endMonthSelect.val()),
            endDay = parseInt(G.endDaySelect.val()),
            endHour = G.endHourSelect.val(),
            endMinute = G.endMinuteSelect.val(),
            startTransitions = G.timezoneInfo[G.startTimezone.val()],
            endTransitions = G.timezoneInfo[G.endTimezone.val()],
            startTransitionsLength = startTransitions.length,
            endTransitionsLength = endTransitions.length,
            startUTCTS, endUTCTS, startTS, endTS, startTransition, endTransition, hours, minutes, i;

        G.validateForm();
        
        if( startHour === '' && endHour !== '' )
        {
            G.validateDateStyle.show();
            G.addBtn.button('disable');
            return;
        }

        if( !startTransitions || !endTransitions )
        {
            G.addBtn.button('disable');
            return;
        }
        
        if( startHour !== '' && endHour !== '' )
        {
            if( startMinute === '' )
            {
                startMinute = 0;
            }
            if( endMinute === '' )
            {
                endMinute = 0;
            }
            
            startUTCTS = Date.UTC(startYear, startMonth-1, startDay, startHour, startMinute, 0) / 1000;
            endUTCTS = Date.UTC(endYear, endMonth-1, endDay, endHour, endMinute, 0) / 1000;
            
            startTS = parseInt(startUTCTS) - parseInt(startTransitions[0]['offset']);
            endTS = parseInt(endUTCTS) - parseInt(endTransitions[0]['offset']);
            if( startTransitions[0]['ts'] > startTS || endTransitions[0]['ts'] > endTS )
            {
                // out of the range of timezone information
                G.validateForm();
                return;
            }
            
            i = 1;
            while( i < startTransitionsLength && startTransitions[i]['ts'] < parseInt(startUTCTS) - parseInt(startTransitions[i]['offset']) )
            {
                i += 1;
            }
            startTransition = startTransitions[i-1];
            startTS = parseInt(startUTCTS) - parseInt(startTransition['offset']);
            
            i = 1;
            while( i < endTransitionsLength && endTransitions[i]['ts'] < parseInt(endUTCTS) - parseInt(endTransitions[i]['offset']) )
            {
                i += 1;
            }
            endTransition = endTransitions[i-1];
            endTS = parseInt(endUTCTS) - parseInt(endTransition['offset']);
            
            if( endTS < startTS )
            {
                G.invalidDateStyle.show();
                G.addBtn.button('disable');
                return;
            }
        }
    };

    G.validateForm = function()
    {
        G.validateDateStyle.hide();
        G.invalidDateStyle.hide();
        G.addBtn.button('enable');
    };

    G.disableTime = function(flag)
    {
        if(flag)
        {
            // disable select time
            G.startHourSelect.selectmenu('disable');
            G.startMinuteSelect.selectmenu('disable');
            G.endHourSelect.selectmenu('disable');
            G.endMinuteSelect.selectmenu('disable');
            
            // change time to --
            G.startHourSelect.find("option:contains('--')").first().prop('selected','selected').trigger('change');
            G.startMinuteSelect.find("option:contains('--')").first().prop('selected','selected').trigger('change');
            G.endHourSelect.find("option:contains('--')").first().prop('selected','selected').trigger('change');
            G.endMinuteSelect.find("option:contains('--')").first().prop('selected','selected').trigger('change');
        }
        else
        {
            G.startHourSelect.selectmenu('enable');
            G.startMinuteSelect.selectmenu('enable');
            G.endHourSelect.selectmenu('enable');
            G.endMinuteSelect.selectmenu('enable');
        }
    };

    G.checkAllDay = function()
    {
        if ( G.allday.hasClass("mobile-checkboxOff-todo-grn") )
        {
            G.disableTime( true );
        }
        else
        {
            G.disableTime( false );
        }
    };

    G.switchOption = function()
    {
        var parent = $(this).parent();
        parent.hide();
        parent.siblings('.mobile_switch_button_grn').show();

        var switchValue = parent.siblings('input').val();
        if(parseInt(switchValue) == 1)
        {
            parent.siblings('input').val('');
        }
        else
        {
            parent.siblings('input').val(1);
        }
    };

    G.privateRaidoButton = function(event)
    {
        var checkOnClass   = "mobile_icon_radiobuttonon_grn";
        var checkOffClass  = "mobile_icon_radiobuttonoff_grn";
        $("#idPrivateRaidoButton").find('.mobile_icon_radiobutton_grn').each(function(){
            var eachObject = $(this);
            if( eachObject.hasClass(checkOnClass))
            {
                eachObject.removeClass(checkOnClass);
            }
            if( ! eachObject.hasClass(checkOffClass) )
            {
                eachObject.addClass(checkOffClass);
            }
        });

        var element = $(event.target);
        if( element.hasClass( checkOffClass ) )
        {
            element.removeClass(checkOffClass);
            element.addClass(checkOnClass);
            element.siblings('.mobile_radiobutton_grn').find('input[type="radio"]').each(function(){
                var private_setting = $(this).val();
                $('#idPrivateSetting').val( private_setting );
                if( private_setting == 2 )
                {
                    $('#idPrivateSettingPublicTo').show();
                }
                else
                {
                    $('#idPrivateSettingPublicTo').hide();
                }
            });
        }
    };

    G.checkFacility = function(event)
    {
        var check_repeat = $('#checkrepeat').val().split(':');
        var check_approval = $('#approval').val().split(':');

        if(check_repeat.indexOf('0') >= 0 || check_approval.indexOf('1') >= 0)
        {
            grn.component.msgbox_mobile.MsgBox.show(G.msgRepeat, G.titleRepeat, grn.component.msgbox_mobile.MsgBoxButtons.yesno, {
                ui : {},
                caption : {
                    yes : G.yes,
                    no  : G.no
                },
                callback : function(result, form)
                {
                    if(result == grn.component.msgbox_mobile.MsgBoxResult.yes)
                    {
                        add_menu_submit('repeat');
                    }

                    grn.component.msgbox_mobile.MsgBox._remove();
                    //if (typeof my_callback != 'undefined') my_callback();
                }
            });
        }
        else
        {
            add_menu_submit('repeat');
        }
        event.stopPropagation();
    };

    G.checkToggleUsingPurpose = function(event)
    {
        if(G.usingPurposeElement != 'undefined')
        {
            var approvalItems = $('#approval').val().split(':');
            if(approvalItems.indexOf('1') >= 0)
            {
                G.usingPurposeElement.show();
            }
            else
            {
                G.usingPurposeElement.hide();
            }
        }
    };
    window.checked_redirect = false;
    $(document).on( "pagebeforecreate", function( event )
    {
        if(location.hash && location.hash.length > 1 && !window.checked_redirect)
        {
            var index = location.href.indexOf("#");
            location.href = location.href.split('#')[0];
        }
        window.checked_redirect = true;
    });
    
    $(document).on( "pagechange", function( event )
    {
        G.init();

        // check when user change time
        G.onChangeDateTime();
        G.startHourSelect.change( G.onChangeDateTime );
        G.startMinuteSelect.change( G.onChangeDateTime );
        G.startYearSelect.change( G.onChangeDateTime );
        G.startMonthSelect.change( G.onChangeDateTime );
        G.startDaySelect.change( G.onChangeDateTime );
        G.endHourSelect.change( G.onChangeDateTime );
        G.endMinuteSelect.change( G.onChangeDateTime );
        G.endYearSelect.change( G.onChangeDateTime );
        G.endMonthSelect.change( G.onChangeDateTime );
        G.endDaySelect.change( G.onChangeDateTime );

        //GTM-105
        G.startHourSelect.change( G.setEndTime );

        // check all day
        G.allday.click( G.checkAllDay );

        // change radio public and private schedule
        $('.mobile_icon_radiobutton_grn').click( G.privateRaidoButton );

        // change between attendance check schedule
        $('.mobile_schedule_switch_type_grn').click( G.switchOption );

        // check facility before change to repeat add schedule screen
        G.changeRepeatAdd.click( G.checkFacility );
    });

    $(document).on( "pagecreate", function( event )
    {
        var height = $("#textarea_id").css("height");
        $("#using_purpose").css({"height":height});
    });
            
    G.is_loaded = true;
})();
