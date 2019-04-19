(function()
{
    if (grn.base.isNamespaceDefined("grn.component.mobile_datepicker"))
    {
        return;
    }
    grn.base.namespace("grn.component.mobile_datepicker");
    grn.component.mobile_datepicker = (function(){
        function DatePicker(settings){
            this._construct(settings);
        }

        DatePicker.prototype = {
            _construct : function(settings)
            {
                this.initParams(settings);
                this.initPopupCalendar(settings);
                this.calendarInit();
                this.bindEventHandler();
            },
            initParams : function(settings)
            {
                this.year_unit = settings.year_unit;
                this.month_unit = settings.month_unit;
                this.day_unit = settings.day_unit;
                this.delimiter = settings.delimiter;
                this.date_order = settings.date_order;
                this.month_name = settings.month_name.split(",");
                this.wday_name = settings.wday_name.split(",");
                this.ajaxURL = settings.ajaxURLGetHoliday;
                this.locale = settings.locale;
            },
            initPopupCalendar : function(settings)
            {
                this.container = $('#' + settings.container);
                this.header = $("#datepicker_header").html();
                this.footer = $("#datepicker_footer").html();
                this.calendarList = this.container.find('.mobile_datepicker_list_grn');
                this.year_select = this.container.find("select.year_select");
                this.month_select = this.container.find("select.month_select");
                this.previousMonth = this.container.find(".previous_month");
                this.nextMonth = this.container.find(".next_month");
                this.today = this.container.find(".today");
            },
            calendarInit : function()
            {
                this.holiday = new Array();
                this.date = new Array();
                this.navigateCalendar = false; // flag to determine tap navigate or using select month or year
            },
            bindEventHandler : function()
            {
                this.previousMonth.click( $.proxy(this.previousHandle, this) );
                this.nextMonth.click( $.proxy(this.nextHandle, this) );
                this.today.click( $.proxy(this.todayHandle, this) );

                this.calendarList.on("touchstart", '.mobile_cancel_grn', $.proxy(this.closeDatepicker, this) );

                this.calendarList.on("touchstart", '.select_date', $.proxy(this.selectDateHandle, this) );

                this.month_select.change( $.proxy(this.changeMonthYear, this) );
                this.year_select.change( $.proxy(this.changeMonthYear, this) );
            },
            initBeforeShowCalendar : function()
            {

            },
            previousHandle : function()
            {
                this.navigateCalendar = true;
                this.currentDate.setMonth(this.currentDate.getMonth() - 1);
                this.drawCalendar();
                this.month_select.val(this.currentDate.getMonth() + 1).trigger("change");
                this.year_select.val(this.currentDate.getFullYear()).trigger("change");
                this.navigateCalendar = false;
            },
            nextHandle : function()
            {
                this.navigateCalendar = true;
                this.currentDate.setMonth(this.currentDate.getMonth() + 1);
                this.drawCalendar();
                this.month_select.val(this.currentDate.getMonth() + 1).trigger("change");
                this.year_select.val(this.currentDate.getFullYear()).trigger("change");
                this.navigateCalendar = false;
            },
            todayHandle : function()
            {
                this.navigateCalendar = true;
                this.resetToday();
                this.month_select.val(this.currentDate.getMonth() + 1).trigger("change");
                this.year_select.val(this.currentDate.getFullYear()).trigger("change");
                this.navigateCalendar = false;
            },
            changeMonthYear : function()
            {
                if(!this.navigateCalendar && typeof this.currentDate != 'undefined')
                {
                    this.currentDate.setMonth(this.month_select.find('option:selected').val() - 1);
                    this.currentDate.setFullYear(this.year_select.find('option:selected').val());
                    this.drawCalendar();
                }
                this.previousMonth.show();
                this.nextMonth.show();
                if(this.month_select.find('option:selected').val() == '1' &&
                    this.year_select.find('option:selected').val() == '1970')
                {
                    this.previousMonth.hide();
                }
                if(this.month_select.find('option:selected').val() == '12' &&
                    this.year_select.find('option:selected').val() == '2037')
                {
                    this.nextMonth.hide();
                }
            },
            closeDatepicker : function(event)
            {
                this.container.popup("close");
                event.preventDefault();
                event.stopPropagation();
                return false;
            },
            selectDateHandle : function(event)
            {
                var ele = $(event.target);
                if(!ele.hasClass('mobile_datepicker_select_grn'))
                {
                    this.container.find('.mobile_datepicker_select_grn').removeClass('mobile_datepicker_select_grn');

                    var date = ele.html();
                    var month = this.month_select.find('option:selected').val();
                    var year = this.year_select.find('option:selected').val();

                    if(ele.hasClass("previousMonth"))
                    {
                        if(month > 1)
                        {
                            month--;
                        }
                        else
                        {
                            month = 12;
                            year--;
                        }
                    }
                    if(ele.hasClass("nextMonth"))
                    {
                        if(month == 12)
                        {
                            month = 1;
                            year++;
                        }
                        else
                        {
                            month++;
                        }
                    }

                    ele.replaceWith('<span class="select_date mobile_datepicker_select_grn">' + date + '</span>');

                    this.date[this.elementId]['selectedDate'] = new Date(year, month - 1, date, 0, 0, 0);
                    this.date[this.elementId]['currentDate'] = new Date(year, month - 1, 1, 0, 0, 0);

                    var date_value = this.getStringDate(this.date[this.elementId]['selectedDate']);
                    if(this.iconOnly)
                    {
                        this.inputDate.val(date_value).triggerHandler('change');
                    }
                    else
                    {
                        var str_date = this.dateFormat(year, month, date);
                        this.currentElement.html(str_date);
                        if(this.id_associate.length > 0 && this.compareWithAssociatedDate(this.date[this.elementId]['selectedDate']) == 1)
                        {
                            this.inputAssociate.html(str_date);
                        }

                        this.setValueInputDate(date_value,year,month,date);
                        this.setValueAssociate(date_value,year,month,date);
                    }
                }

                if(!this.iconOnly)
                {
                    this.currentElement.closest('.mobile-btn-calender-grn').removeClass("ui-btn-active"); // remove state of selected by remove class ui-btn-active
                }
                var me = this;
                var e = event;
                setTimeout(function(){
                    me.closeDatepicker(e);
                },500);
            },
            resetToday : function()
            {
                var now = new Date();
                this.currentDate = now;
                this.drawCalendar();
                this.currentDate.setDate(1); // set current to first date of month
            },
            drawCalendar : function()
            {
                this.buildElement();

                var year = this.currentDate.getFullYear();
                if(typeof this.holiday[year] == 'undefined')
                {
                    this.getHoliday(year);
                }
            },
            buildElement : function()
            {
                var month = this.currentDate.getMonth();
                var year = this.currentDate.getFullYear();
                var tempDate = new Date(this.currentDate.getFullYear(),this.currentDate.getMonth(),this.currentDate.getDate(), 0, 0, 0);
                
                var startDate = this.getCalendarStartDate(tempDate);
                var endDate = this.getCalendarEndDate(tempDate);

                this.calendarList.empty();
                this.calendarList.append($($.parseHTML(this.header)).filter("*").clone());
                var now = new Date();
                var selectedDate = null;
                if(typeof this.date[this.elementId] != 'undefined')
                {
                    selectedDate = this.date[this.elementId]['selectedDate'];
                }

                while(startDate <= endDate)
                {
                    var div = $('<div></div>');
                    switch( startDate.getDay() )
                    {
                        case 0:
                            div.addClass('mobile_datepicker_sun_grn');
                            break;
                        case 6:
                            div.addClass('mobile_datepicker_sat_grn');
                            break;
                        default:
                            div.addClass('mobile_datepicker_workdays_grn');
                    }
                    var str_date = this.getStringDate(startDate);
                    div.data('str_date',str_date);
                    if(typeof this.holiday[year] != 'undefined')
                    {
                        this.addClassHoliday(div,str_date,this.holiday[year]);
                    }

                    if(startDate.getMonth() != month ||
                        startDate.getFullYear() != year)
                    {
                        if(startDate.getFullYear() < 1970 || startDate.getFullYear() > 2037)
                        {
                            div.append("<a href='#' class='ui-link mobile_datepicker_unabledate_grn'></a>");
                        }
                        else
                        {
                            var externalClass = "previousMonth";
                            if(startDate.getTime() >= this.currentDate.getTime())
                            {
                                externalClass = "nextMonth";
                            }
                            div.append("<a href='#' class='select_date ui-link mobile_datepicker_unabledate_grn " + externalClass + "'>" + startDate.getDate() + "</a>");
                        }
                    }
                    else
                    {
                        if(selectedDate != null &&
                            startDate.getDate() == selectedDate.getDate() &&
                            startDate.getMonth() == selectedDate.getMonth() &&
                            startDate.getFullYear() == selectedDate.getFullYear())
                        {
                            div.append("<span class='select_date mobile_datepicker_select_grn'>" + startDate.getDate() + "</span>");
                        }
                        else
                        {
                            if( startDate.getDate() == now.getDate() &&
                                startDate.getMonth() == now.getMonth() &&
                                startDate.getFullYear() == now.getFullYear() )
                            {
                                div.append("<span class='mobile_datepicker_today_grn'><a href='#' class='select_date ui-link'>" + startDate.getDate() + "</a></span>");
                            }
                            else
                            {
                                div.append("<a href='#' class='select_date ui-link'>" + startDate.getDate() + "</a>");
                            }
                        }
                    }
                    this.calendarList.append(div);
                    startDate.setDate(startDate.getDate() + 1);
                }
                this.calendarList.append($($.parseHTML(this.footer)).filter("*").clone());
                var cancelBtn = this.calendarList.find('[type="reset"]').button();
                cancelBtn.button('refresh');
            },
            getHoliday : function(year, callback)
            {
                var me = this;
                $.ajax(
                {
                    url : this.ajaxURL,
                    dataType : 'json',
                    data: 'year='+year,
                    type : 'post',
                    beforeSend : function()
                    {
                    },
                    success : function(json_obj, text_status, transport)
                    {
                        if (grn.component.mobile_error_handler.hasCybozuError(transport))
                        {
                            grn.component.mobile_error_handler.show(json_obj);
                        }
                        else
                        {
                            me.holiday[year] = json_obj.calendars;
                            me.buildHoliday(year);
                        }
                    },
                    error : function(transport)
                    {
                        if (grn.component.mobile_error_handler.hasCybozuLogin(transport))
                        {
                        }
                        else
                        {
                            document.write(transport.responseText);
                            document.close();
                        }
                    },
                    complete : function()
                    {
                    }
                });
            },
            buildHoliday : function(year)
            {
                var me = this;
                this.container.find('.mobile_datepicker_list_grn > div').each(function(){
                    var thisObj = $(this);
                    var str_date = thisObj.data('str_date');
                    me.addClassHoliday(thisObj, str_date, me.holiday[year]);
                });
            },
            addClassHoliday : function(thisObj, str_date, holiday)
            {
                var isWorkDay, isHoliday;
                if(str_date in holiday)
                {
                    isWorkDay = false;
                    isHoliday = false;
                    $.each( holiday[str_date], function( key, value ) {
                        switch( value.type )
                        {
                            case '1':
                                isHoliday = true;
                                break;
                            case '5':
                                isWorkDay = true;
                                break;
                        }
                        if(isHoliday && isWorkDay)
                        {
                            return false;
                        }
                    });
                    
                    if(isWorkDay)
                    {
                        thisObj.removeClass().addClass('mobile_datepicker_workdays_grn');
                    }
                    else if(isHoliday)
                    {
                        thisObj.addClass('mobile_datepicker_holidays_grn');
                    }
                }
            },
            getCalendarStartDate : function(date)
            {
                var tempDate = new Date(date);
                tempDate.setDate(1);
                tempDate.setDate(tempDate.getDate() - tempDate.getDay());
                return tempDate;
            },
            getCalendarEndDate : function(date)
            {
                var tempDate = new Date(date);
                tempDate.setDate(this.getEndOfMonthDay(date.getFullYear(),date.getMonth()+1));
                tempDate.setDate(tempDate.getDate() + (6 - tempDate.getDay()));
                return tempDate;
            },
            getEndOfMonthDay : function( year, month )
            {
                switch( month )
                {
                    case 1:
                    case 3:
                    case 5:
                    case 7:
                    case 8:
                    case 10:
                    case 12:
                        return 31;

                    case 4:
                    case 6:
                    case 9:
                    case 11:
                        return 30;

                    case 2:
                        if( (year % 4) !== 0 )
                            return 28;
                        if( (year % 400) === 0 )
                            return 29;
                        if( (year % 100) === 0 )
                            return 28;
                        return 29;
                }
            },
            dateFormat : function( year, month, day )
            {
                /*jshint -W053 */ /* Do not use {a} as a constructor. */
                var date_order = new String(this.date_order);
                /*jshint +W053 */
                if ( year && month && day )
                {
                    var cdate = new Date(year, month-1, day, 0, 0, 0);
                }
                else
                {
                    var cdate = new Date();
                }
                
                var format_str = "";
                var space = ' ';
                if(this.locale == 'zh')
                {
                    space = '';
                }
                var len = date_order.length;
                for( var i = 0 ; i < len ; i++ )
                {
                    if( i > 0 )
                    {
                        format_str += this.delimiter;
                    }

                    switch( date_order.charAt(i) )
                    {
                        case 'Y':
                           format_str += cdate.getFullYear()+ space+ this.year_unit+ space;
                            break;
                        case 'n':
                            format_str += this.month_name[cdate.getMonth()]+ space+ this.month_unit+ space;
                            break;
                        case 'j':
                            var date_format = cdate.getDate() < 10 ? '0' + cdate.getDate() : cdate.getDate();
                            format_str += date_format + space+ '('+ this.wday_name[cdate.getDay()]+ ')'+ space;
                            break;
                    }
                }
                return format_str;
            },
            setCurrentElement : function(element)
            {
                var ele;
                if(this.iconOnly)
                {
                    ele = $(element);
                }
                else
                {
                    ele = $(element);
                    if(!ele.hasClass('mobile-btn-calender-grn'))
                    {
                        ele = ele.closest('.mobile-btn-calender-grn');
                    }
                    this.currentElement = ele.find('.mobile-font-normal-grn'); // detect element to display string date
                }
                
                this.elementId = ele.attr('id');
                this.setInputDate();
                if(typeof this.date[this.elementId] != 'undefined' &&
                    typeof this.date[this.elementId]['currentDate'] != 'undefined')
                {
                    this.currentDate = this.date[this.elementId]['currentDate'];
                    this.drawCalendar();
                    this.changeMonthYearUI();
                }
                else
                {
                    this.date[this.elementId] = new Array();
                    this.date[this.elementId]['selectedDate'] = this.getDate(this.inputDate.val());
                    this.currentDate = this.getDate(this.inputDate.val());
                    this.drawCalendar();
                    this.currentDate.setDate(1); // set current to first date of month
                    this.changeMonthYearUI();
                }
            },
            setInputDate : function()
            {
                this.inputDate = $('#' + this.elementId + '_set');
                if(!this.iconOnly)
                {
                    this.inputHiddenDay = $('#' + this.elementId + '_day');
                    this.inputHiddenMonth = $('#' + this.elementId + '_month');
                    this.inputHiddenYear = $('#' + this.elementId + '_year');
                }
            },
            setValueInputDate : function(str_date,year,month,day)
            {
                this.inputHiddenDay.val(day).triggerHandler('change');
                this.inputHiddenMonth.val(month).triggerHandler('change');
                this.inputHiddenYear.val(year).triggerHandler('change');
                this.inputDate.val(str_date);//.triggerHandler('change');
            },
            setInputAssociate : function(id_associate)
            {
                this.id_associate = '';
                if(id_associate.length > 0)
                {
                    this.id_associate = id_associate;
                    this.inputAssociate = $('#' + id_associate).find('.mobile-font-normal-grn');
                    this.inputAssociateDate = $('#' + id_associate + '_set');
                    this.inputAssociateHiddenDay = $('#' + id_associate + '_day');
                    this.inputAssociateHiddenMonth = $('#' + id_associate + '_month');
                    this.inputAssociateHiddenYear = $('#' + id_associate + '_year');
                }
            },
            setValueAssociate : function(str_date,year,month,day)
            {
                if(this.id_associate.length > 0 && this.compareWithAssociatedDate(this.date[this.elementId]['selectedDate']) == 1)
                {
                    this.inputAssociateDate.val(str_date);
                    this.inputAssociateHiddenDay.val(day).triggerHandler('change');
                    this.inputAssociateHiddenMonth.val(month).triggerHandler('change');
                    this.inputAssociateHiddenYear.val(year).triggerHandler('change');
                }
            },
            compareWithAssociatedDate : function(date)
            {
                if(this.id_associate.length > 0)
                {
                    var associateDate = this.getDate(this.inputAssociateDate.val());
                    if(associateDate != null)
                    {
                        if(date > associateDate)
                        {
                            return 1;
                        }
                    }
                }
                return -1;
            },
            getCurrentElement : function()
            {
                return this.currentElement;
            },
            getDate : function(str_date)
            {
                /*jshint -W053 */ /* Do not use {a} as a constructor. */
                cdate_str = new String(str_date);
                /*jshint +W053 */
                cdate_arr = cdate_str.split("-");

                year  = (cdate_arr[0] == undefined) ? null : parseInt(cdate_arr[0]);
                month = (cdate_arr[1] == undefined) ? null : parseInt(cdate_arr[1]);
                day   = (cdate_arr[2] == undefined) ? null : parseInt(cdate_arr[2]);
                
                if (year && month && day) {
                    return new Date(year, month-1, day, 0 , 0 , 0);
                }
                
                return null;
            },
            getStringDate : function(date)
            {
                var str_date = date.getFullYear() + '-';
                if(date.getMonth() + 1 >= 10)
                {
                    str_date += (date.getMonth() + 1) + '-';
                }
                else
                {
                    str_date += '0' + (date.getMonth() + 1) + '-';
                }
                if(date.getDate() >= 10)
                {
                    str_date += date.getDate();
                }
                else
                {
                    str_date += '0' + date.getDate();
                }
                
                return str_date;
            },
            parseDate : function(str_date)
            {
                myregexp = /([0-9]+)-([0-9]+)-([0-9]+)/;
                match = myregexp.exec(str_date);
                if (match != null)
                {
                    return new Date(match[1],match[2]-1,match[3]);
                }
                return null;
            },
            setIconOnly : function(flag)
            {
                this.iconOnly = flag;
            },
            changeMonthYearUI : function()
            {
                this.navigateCalendar = true;
                this.month_select.val(this.currentDate.getMonth() + 1).trigger("change");
                this.year_select.val(this.currentDate.getFullYear()).trigger("change");
                this.navigateCalendar = false;
            },
            handlerChangeValue : function(event)
            {
                var input = $(event.target);
                if(input.length > 0)
                {
                    if(!this.iconOnly)
                    {
                        var str_date = input.val();
                        var date = this.getDate(str_date);
                        var formatDate = this.dateFormat(date.getFullYear(), date.getMonth() + 1, date.getDate());
                        input.siblings('a').find('.mobile-font-normal-grn').html(formatDate);
                    }
                }
            }
        };

        return DatePicker;
    })();
})();
