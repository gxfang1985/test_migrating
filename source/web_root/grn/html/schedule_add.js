var GRN_ScheduleAdd = (function(){
    var startYearSelect = $('start_year'),
        startMonthSelect = $('start_month'),
        startDaySelect = $('start_day'),
        startHourSelect = $('start_hour'),
        startMinuteSelect = $('start_minute'),
        endYearSelect = $('end_year'),
        endMonthSelect = $('end_month'),
        endDaySelect = $('end_day'),
        endHourSelect = $('end_hour'),
        endMinuteSelect = $('end_minute'),
        startTimezone = $('timezone'),
        endTimezone = $('end_timezone'),
        scheduleSubmit = grn.component.button("#schedule_submit_button"),
        validateDateStyle = $("validate_date").style,
        invalidDateStyle = $('invalid_date').style,
        formScheduleAdd = $('schedule/add'),
        timezoneInfo = GRN_TimezoneInfo;
    
    return {
        onChangeDateTime: function(){
            var startYear = startYearSelect.value,
                startMonth = startMonthSelect.value,
                startDay = startDaySelect.value,
                startHour = startHourSelect.value,
                startMinute = startMinuteSelect.value,
                endYear = endYearSelect.value,
                endMonth = endMonthSelect.value,
                endDay = endDaySelect.value,
                endHour = endHourSelect.value,
                endMinute = endMinuteSelect.value,
                startTransitions = timezoneInfo[startTimezone.value],
                endTransitions = timezoneInfo[endTimezone.value],
                startTransitionsLength = startTransitions.length,
                endTransitionsLength = endTransitions.length,
                startUTCTS, endUTCTS, startTS, endTS, startTransition, endTransition, hours, minutes, i;

            this.validateForm();

            if( startHour === '' && endHour !== '' ){
                validateDateStyle.display = '';
                scheduleSubmit.disable();
                return;
            }
            
            if( !startTransitions || !endTransitions ){
                scheduleSubmit.enable();
                return;
            }

            if( startHour !== '' && endHour !== '' ){
                if( startMinute === '' ){
                    startMinute = 0;
                }
                if( endMinute === '' ){
                    endMinute = 0;
                }
                
                startUTCTS = Date.UTC(startYear, startMonth-1, startDay, startHour, startMinute, 0) / 1000;
                endUTCTS = Date.UTC(endYear, endMonth-1, endDay, endHour, endMinute, 0) / 1000;
                
                startTS = parseInt(startUTCTS) - parseInt(startTransitions[0]['offset']);
                endTS = parseInt(endUTCTS) - parseInt(endTransitions[0]['offset']);
                if( startTransitions[0]['ts'] > startTS || endTransitions[0]['ts'] > endTS ){
                    // out of the range of timezone information
                    this.validateForm();
                    return;
                }
                
                i = 1;
                while( i < startTransitionsLength && startTransitions[i]['ts'] < parseInt(startUTCTS) - parseInt(startTransitions[i]['offset']) ){
                    i += 1;
                }
                startTransition = startTransitions[i-1];
                startTS = parseInt(startUTCTS) - parseInt(startTransition['offset']);
                
                i = 1;
                while( i < endTransitionsLength && endTransitions[i]['ts'] < parseInt(endUTCTS) - parseInt(endTransitions[i]['offset']) ){
                    i += 1;
                }
                endTransition = endTransitions[i-1];
                endTS = parseInt(endUTCTS) - parseInt(endTransition['offset']);
                
                if( endTS < startTS ){
                    invalidDateStyle.display = '';
                    scheduleSubmit.disable();
                    return;
                }//else{
                //    // calculate the amount of time required.
                //    hours = Math.floor( (endTS - startTS) / 3600 );
                //    minutes = ( (endTS - startTS) % 3600 ) / 60;
                //}
            }
        },
        validateForm: function(){
            validateDateStyle.display = 'none';
            invalidDateStyle.display = 'none';
            scheduleSubmit.enable();
        },
        // GTM-105(set end_time = start_time + 1)
        setEndTime: function(){
            if (startHourSelect.value != '' && startMinuteSelect.value == '' && endHourSelect.value == '' && endMinuteSelect.value == ''
                && formScheduleAdd != null)
            {
                if (startHourSelect.value == '23') {
                    endHourSelect.value = parseInt(startHourSelect.value);
                }
                else {
                    endHourSelect.value = parseInt(startHourSelect.value) + 1;
                }
                endMinuteSelect.value = 0;
                startMinuteSelect.value = 0;
            }
        },

        SELECT_VALUE_EMPTY: -1,

        /**
         * @param {number} year
         * @returns {boolean}
         */
        isValidYear: function (year) {
            var values = jQuery.map(startYearSelect.options, function (option) {
                return option.value;
            });

            return values.indexOf(year.toString()) !== -1;
        },

        /**
         * @param {number} minute
         * @returns {boolean}
         */
        isValidMinute: function (minute) {
            var values = jQuery.map(startMinuteSelect.options, function (option) {
                return option.value;
            });

            return values.indexOf(minute.toString()) !== -1;
        },

        /**
         * @returns {{year: Number, month: Number, day: Number, hour: Number, minute: Number}}
         */
        getStartDateTime: function () {
            var hour = startHourSelect.value !== "" ? parseInt(startHourSelect.value, 10) : this.SELECT_VALUE_EMPTY;
            var minute = startMinuteSelect.value !== "" ? parseInt(startMinuteSelect.value, 10) : this.SELECT_VALUE_EMPTY;
            return {
                year: parseInt(startYearSelect.value, 10),
                month: parseInt(startMonthSelect.value, 10),
                day: parseInt(startDaySelect.value, 10),
                hour: hour,
                minute: minute
            };
        },

        /**
         * @returns {{year: Number, month: Number, day: Number, hour: Number, minute: Number}}
         */
        getEndDateTime: function () {
            var hour = endHourSelect.value !== "" ? parseInt(endHourSelect.value, 10) : this.SELECT_VALUE_EMPTY;
            var minute = endMinuteSelect.value !== "" ? parseInt(endMinuteSelect.value, 10) : this.SELECT_VALUE_EMPTY;
            return {
                year: parseInt(endYearSelect.value, 10),
                month: parseInt(endMonthSelect.value, 10),
                day: parseInt(endDaySelect.value, 10),
                hour: hour,
                minute: minute
            };
        },

        /**
         * @param {number} year
         * @param {number} month
         * @param {number} day
         * @param {number} hour
         * @param {number} minute
         */
        setStartDateTime: function (year, month, day, hour, minute) {
            startYearSelect.value = year;
            startMonthSelect.value = month;
            startDaySelect.value = day;
            startHourSelect.value = hour !== this.SELECT_VALUE_EMPTY ? hour : "";
            startMinuteSelect.value = minute !== this.SELECT_VALUE_EMPTY ? minute : "";
        },

        /**
         * @param {number} year
         * @param {number} month
         * @param {number} day
         * @param {number} hour
         * @param {number} minute
         */
        setEndDateTime: function (year, month, day, hour, minute) {
            endYearSelect.value = year;
            endMonthSelect.value = month;
            endDaySelect.value = day;
            endHourSelect.value = hour !== this.SELECT_VALUE_EMPTY ? hour : "";
            endMinuteSelect.value = minute !== this.SELECT_VALUE_EMPTY ? minute : "";
        }
    };
}());

(function(){
var func = function(){GRN_ScheduleAdd.onChangeDateTime();};
Event.observe($('start_year'), 'change', func);
Event.observe($('start_month'), 'change', func);
Event.observe($('start_day'), 'change', func);
Event.observe($('start_hour'), 'change', func);
Event.observe($('start_minute'), 'change', func);
Event.observe($('end_year'), 'change', func);
Event.observe($('end_month'), 'change', func);
Event.observe($('end_day'), 'change', func);
Event.observe($('end_hour'), 'change', func);
Event.observe($('end_minute'), 'change', func);
Event.observe(window, 'load', func);
}());

//GTM-105
(function(){
var func = function(){GRN_ScheduleAdd.setEndTime();};
Event.observe($('start_hour'), 'change', func);
}());
