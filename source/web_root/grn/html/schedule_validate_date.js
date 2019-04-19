var GRN_ScheduleDate = (function () {
    var startYearSelect = $('start_year'),
        startMonthSelect = $('start_month'),
        startDaySelect = $('start_day'),
        endYearSelect = $('end_year'),
        endMonthSelect = $('end_month'),
        endDaySelect = $('end_day'),
        scheduleSubmit = grn.component.button("#schedule_submit_button"),
        invalidDateStyle = $('invalid_date').style;
    
    return {
        onChangeDateTime: function(){
            var startYear = parseInt(startYearSelect.value),
                startMonth = parseInt(startMonthSelect.value),
                startDay = parseInt(startDaySelect.value),
                endYear = parseInt(endYearSelect.value),
                endMonth = parseInt(endMonthSelect.value),
                endDay = parseInt(endDaySelect.value);

            if( ( startYear > endYear ) ||
                ( startYear === endYear && startMonth > endMonth ) ||
                ( startYear === endYear && startMonth === endMonth && startDay > endDay ) ){
                this.invalidateForm();
                return;
            }
            
            this.validateForm();
        },
        validateForm: function(){
            invalidDateStyle.display = 'none';
            scheduleSubmit.enable();
        },
        invalidateForm: function(){
            invalidDateStyle.display = '';
            scheduleSubmit.disable();
        },

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
         * @returns {{year: Number, month: Number, day: Number}}
         */
        getStartDate: function () {
            return {
                year: parseInt(startYearSelect.value, 10),
                month: parseInt(startMonthSelect.value, 10),
                day: parseInt(startDaySelect.value, 10)
            }
        },

        /**
         * @returns {{year: Number, month: Number, day: Number}}
         */
        getEndDate: function () {
            return {
                year: parseInt(endYearSelect.value, 10),
                month: parseInt(endMonthSelect.value, 10),
                day: parseInt(endDaySelect.value, 10)
            }
        },

        /**
         * @param {number} year
         * @param {number} month
         * @param {number} day
         */
        setStartDate: function (year, month, day) {
            startYearSelect.value = year;
            startMonthSelect.value = month;
            startDaySelect.value = day;
        },

        /**
         * @param {number} year
         * @param {number} month
         * @param {number} day
         */
        setEndDate: function (year, month, day) {
            endYearSelect.value = year;
            endMonthSelect.value = month;
            endDaySelect.value = day;
        }
    };
}());

(function(){
    var func = function () {
        GRN_ScheduleDate.onChangeDateTime();
    };
Event.observe($('start_year'), 'change', func);
Event.observe($('start_month'), 'change', func);
Event.observe($('start_day'), 'change', func);
Event.observe($('end_year'), 'change', func);
Event.observe($('end_month'), 'change', func);
Event.observe($('end_day'), 'change', func);
Event.observe(window, 'load', func);
}());
