// namespace
grn.base.namespace("grn.page.schedule.mobile.schedule_repeat_add");
(function () {
    var G = grn.page.schedule.mobile.schedule_repeat_add;
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
        G.validateRepeatDateStyle = $('#validate_repeat_date');
        G.invalidRepeatDateStyle = $('#invalid_date');
        G.allday = $('#notime');
        G.addBtn = $('#addBtn');
        G.rangeRepeatModify = $('#range_repeat_modify');
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
            endMinute = G.endMinuteSelect.val();

        G.validateForm();
        
        if( startHour === '' && endHour !== '' )
        {
            G.validateRepeatDateStyle.show();
            G.addBtn.button('disable');
        }
        
        if( ( startYear > endYear ) ||
            ( startYear === endYear && startMonth > endMonth ) ||
            ( startYear === endYear && startMonth === endMonth && startDay > endDay ) )
        {
            G.invalidRepeatDateStyle.show();
            G.addBtn.button('disable');
        }
    };
    
    G.validateForm = function()
    {
        G.validateRepeatDateStyle.hide();
        G.invalidRepeatDateStyle.hide();
        G.addBtn.button('enable');
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
    
    G.switchTypeAppoinment = function()
    {
        if($(this).hasClass('mobile_left_grn'))
        {
            $('.mobile_schedule_private_grn').hide();
            $('.mobile_schedule_public_grn').show();
            $('#private').val('');
        }
        else if($(this).hasClass('mobile_right_grn'))
        {
            $('.mobile_schedule_public_grn').hide();
            $('.mobile_schedule_private_grn').show();
            $('#private').val(1);
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

    G.handleRangeModify = function()
    {
        var checkOnClass   = "mobile_icon_radiobuttonon_grn";
        var checkOffClass  = "mobile_icon_radiobuttonoff_grn";
        G.rangeRepeatModify.find('.mobile_icon_radiobutton_grn').tap(function(){
            var thisObj = $(this);
            if(thisObj.hasClass(checkOffClass))
            {
                G.rangeRepeatModify.find('.' + checkOnClass).each(function(){
                    $(this).removeClass(checkOnClass);
                    $(this).addClass(checkOffClass);
                });
                
                thisObj.removeClass(checkOffClass);
                thisObj.addClass(checkOnClass);
                
                thisObj.siblings('.mobile_radiobutton_grn').find('input[type="radio"]').each(function(){
                    $(this).prop('check','checked');
                    var typeModify = $(this).val();
                    G.rangeRepeatModify.find('#apply').val(typeModify);

                    switch (typeModify)
                    {
                        case 'this':
                            G.selectOff('start');
                            G.selectOff('end');
                            break;

                        case 'after':
                            G.selectOn('end');
                            G.changeDate('start',G.t_year,G.t_month,G.t_day);
                            G.selectOff('start');

                            break;

                        default:
                            G.selectOn('start');
                            G.selectOn('end');
                            G.changeDate('start',G.s_year,G.s_month,G.s_day);
                    }

                });
            }
        });
    };

    G.changeDate = function(sobj,year,month,day)
    {
        $('#' + sobj + '_year').val(year);
        $('#' + sobj + '_month').val(month);
        $('#' + sobj + '_day').val(day);
        $('#' + sobj + '_set').val(year + '-' + month + '-' + day).trigger('change');
    };

    G.selectOn = function(name)
    {
        var y = name + '_year';
        var m = name + '_month';
        var d = name + '_day';
        form = document.forms[G.form];
        form.elements[y].disabled = false;
        form.elements[m].disabled = false;
        form.elements[d].disabled = false;
        $('#'+name).removeClass("ui-disabled");
    };

    G.selectOff = function(name)
    {
        var y = name + '_year';
        var m = name + '_month';
        var d = name + '_day';
        form = document.forms[G.form];
        form.elements[y].disabled = true;
        form.elements[m].disabled = true;
        form.elements[d].disabled = true;
        $('#'+name).addClass("ui-disabled");
    };
    
    window.checked_redirect = false;
    $(document).on( "pagebeforecreate", function( event )
    {
        if(location.hash && !window.checked_redirect)
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
        $('#idPrivateRaidoButton .mobile_icon_radiobutton_grn').click( G.privateRaidoButton );

        // change between attendance check schedule
        $('.mobile_schedule_switch_type_grn').click( G.switchTypeAppoinment );

        if(G.rangeRepeatModify.length > 0)
        {
            G.handleRangeModify();
        }
    });
            
    G.is_loaded = true;
})();
