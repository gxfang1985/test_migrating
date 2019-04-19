var GRN_ScheduleTimeSpan = (function(){
    var startHour = $('start_hour'),
        startMinute = $('start_minute'),
        endHour = $('end_hour'),
        endMinute = $('end_minute'),
        hoursNum = $('hours_num'),
        minutesNum = $('minutes_num'),
        scheduleSubmit = grn.component.button("#schedule_submit_button"),
        minutesNumStyle = minutesNum.style,
        minutesUnitStyle = $('minutes_unit').style,
        hoursNumStyle = hoursNum.style,
        hoursUnitStyle = $('hours_unit').style,
        validateRepeatDateStyle = $('validate_repeat_date').style,
        formScheduleAdd = $('schedule/repeat_add'),
        timeSpanStyle = $('time_span').style;

    return {
        onChangeTime: function(){
            var startHourValue = startHour.value,
                startMinuteValue = startMinute.value,
                endHourValue = endHour.value,
                endMinuteValue = endMinute.value,
                hours, minutes;
            
            hoursNumStyle.display = 'none';
            hoursUnitStyle.display = 'none';
            minutesNumStyle.display = 'none';
            minutesUnitStyle.display = 'none';
            validateRepeatDateStyle.display = 'none';
            
            if( startHourValue === '' && endHourValue !== '' ){
                validateRepeatDateStyle.display = '';
                timeSpanStyle.display = 'none';
                scheduleSubmit.disable();
                return;
            }else{
                timeSpanStyle.display = '';
                scheduleSubmit.enable();
            }
            
            if( startHourValue === '' && endHourValue === '' ){
                hours = 24;
                minutes = 0;
            }else if( startHourValue !== '' && endHourValue === '' ){
                hours = 0;
                minutes = 0;
            }else{
                if( startMinuteValue === '' ){
                    startMinuteValue = 0;
                }
                if( endMinuteValue === '' ){
                    endMinuteValue = 0;
                }
                
                hours = endHourValue - startHourValue;
                
                if( startHourValue !== '' && endHourValue === '' ){
                    minutes = 0;
                }else{
                    minutes = endMinuteValue - startMinuteValue;
                }
            }
            
            if( minutes < 0 ){
                minutes += 60;
                hours -= 1;
            }
            if( hours < 0 ){
                hours += 24;
            }
            if( hours !== 0 ){
                hoursNum.innerHTML = hours;
                hoursNumStyle.display = '';
                hoursUnitStyle.display = '';
            }
            if( minutes !== 0 || hours === 0){
                minutesNum.innerHTML = minutes;
                minutesNumStyle.display = '';
                minutesUnitStyle.display = '';
            }
        },
        //GTM-105 set end_time = start_time + 1
        setEndTime: function(){
            if (startHour.value != '' && startMinute.value == '' && endHour.value == '' && endMinute.value == ''
                && formScheduleAdd != null)
            {
                if (startHour.value == '23') {
                    endHour.value = parseInt(startHour.value);
                }
                else {
                    endHour.value = parseInt(startHour.value) + 1;
                }
                endMinute.value = 0;
                startMinute.value = 0;
            }
        },

        /**
         * @param {number} hour
         * @param {number} minute
         */
        setStartTime: function (hour, minute) {
            startHour.value = hour !== this.SELECT_VALUE_EMPTY ? hour : "";
            startMinute.value = minute !== this.SELECT_VALUE_EMPTY ? minute : "";
        },

        /**
         * Set End hour & end minute with input hour and minute
         * @param {number} hour
         * @param {number} minute
         */
        setEndHourAndMinute: function (hour, minute) {
            endHour.value = hour !== this.SELECT_VALUE_EMPTY ? hour : "";
            endMinute.value = minute !== this.SELECT_VALUE_EMPTY ? minute : "";
        },

        /**
         * @param {number} minute
         * @returns {boolean}
         */
        isValidMinute: function (minute) {
            var values = jQuery.map(startMinute.options, function (option) {
                return option.value;
            });
            return values.indexOf(minute.toString()) !== -1;
        },

        /**
         * @returns {{hour: Number, minute: Number}}
         */
        getStartTime: function () {
            var hour = startHour.value !== "" ? parseInt(startHour.value, 10) : this.SELECT_VALUE_EMPTY;
            var minute = startMinute.value !== "" ? parseInt(startMinute.value, 10) : this.SELECT_VALUE_EMPTY;
            return {
                hour: hour,
                minute: minute
            };
        },

        /**
         * @returns {{hour: Number, minute: Number}}
         */
        getEndTime: function () {
            var hour = endHour.value !== "" ? parseInt(endHour.value, 10) : this.SELECT_VALUE_EMPTY;
            var minute = endMinute.value !== "" ? parseInt(endMinute.value, 10) : this.SELECT_VALUE_EMPTY;
            return {
                hour: hour,
                minute: minute
            };
        },

        SELECT_VALUE_EMPTY: -1
    };
}());
Event.observe($('start_hour'), 'change', GRN_ScheduleTimeSpan.setEndTime); //GTM-105
Event.observe($('start_hour'), 'change', GRN_ScheduleTimeSpan.onChangeTime);
Event.observe($('start_minute'), 'change', GRN_ScheduleTimeSpan.onChangeTime);
Event.observe($('end_hour'), 'change', GRN_ScheduleTimeSpan.onChangeTime);
Event.observe($('end_minute'), 'change', GRN_ScheduleTimeSpan.onChangeTime);
Event.observe(window, 'load', GRN_ScheduleTimeSpan.onChangeTime);
