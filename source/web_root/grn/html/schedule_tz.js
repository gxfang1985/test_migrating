Event.observe(window, 'resize', function(){
    if( typeof GRN_ScheduleSelectTimezone != "undefined" )
    {
        GRN_ScheduleSelectTimezone.resizeBackground();
    }
});

jQuery(function() {

GRN_ScheduleSelectTimezone = (function(){
    var timezoneDialog = $('timezone_dialog'),
        timezoneDialogStyle = timezoneDialog.style,
        appliedStartTimezone = $('applied_timezone'),
        appliedEndTimezone = $('applied_end_timezone'),
        backgroundStyle = $('background').style,
        startTimezone = $('timezone'),
        endTimezone = $('end_timezone'),
        startTimezoneCandidate = $('timezone_candidate'),
        endTimezoneCandidate = $('end_timezone_candidate'),
        startTimezoneRegion = $('timezone_candidate-region'),
        endTimezoneRegion = $('end_timezone_candidate-region'),
        spanStartTimezone = $('span_timezone'),
        spanEndTimezone = $('span_end_timezone'),
        endTimezoneBlock = $('end_timezone_block'),
        timezoneToLink = $('timezone_to_link'),
        currentTimezone = $('current_timezone'),
        body = document.body,
        selectElements = $('body').select('select'),
        timezoneDialogSelectElements = timezoneDialog.select('select'),
        startTimezoneSelectedValue = startTimezone.value,
        endTimezoneSelectedValue = endTimezone.value,
        startTimezoneRegionValue, endTimezoneRegionValue,
        oldKeyHandler = null,
        enableKey = true;
    
    return {
        openTimezoneDialog: function(){
            this.selectOption('timezone_candidate', startTimezone.value);
            GRN_Event.fireEvent(startTimezoneCandidate, 'change');
            startTimezoneRegionValue = this.getSelectedValue(startTimezoneRegion);
            if(endTimezoneBlock){
                endTimezoneRegionValue = this.getSelectedValue(endTimezoneRegion);
                this.selectOption('end_timezone_candidate', endTimezone.value);
                GRN_Event.fireEvent(endTimezoneCandidate, 'change');
            }
            this.coverBackground();
            this.adjustTimezoneDialog();

            timezoneDialogStyle.display = '';
            
            this.disableKeyDown();
        },
        closeTimezoneDialog: function(){
            this.enableKeyDown();

            //show select box for IE6 only
            if( navigator.userAgent.indexOf("MSIE 6") > 0 ){
                selectElements.each(function(se){
                    se.style.visibility="";
                });
            }

            timezoneDialogStyle.display = 'none';
            this.uncoverBackground();
        },
        coverBackground: function(){
            this.resizeBackground();
            backgroundStyle.display = '';
        },
        uncoverBackground: function(){
            backgroundStyle.display = 'none';
        },
        applyTimezone: function(){
            var startTimezoneCandidateText = this.getSelectedText(startTimezoneCandidate),
                startTimezoneCandidateValue = this.getSelectedValue(startTimezoneCandidate);
            
            startTimezone.value = startTimezoneCandidateValue;
            
            if(this.isNormalEvent()){
                endTimezone.value = this.getSelectedValue(endTimezoneCandidate);
                if( timezoneToLink ){
                    timezoneToLink.style.display = 'none';
                }
                appliedStartTimezone.style.display = '';
                appliedEndTimezone.style.display = '';
                spanStartTimezone.innerHTML = startTimezoneCandidateText;
                spanEndTimezone.innerHTML = this.getSelectedText(endTimezoneCandidate);
                GRN_ScheduleAdd.onChangeDateTime();
            }else{
                endTimezone.value = startTimezoneCandidateValue;
                currentTimezone.innerHTML = startTimezoneCandidateText;
            }

            this.closeTimezoneDialog();
        },
        selectOption: function(id, value){
            var selectOptions = $(id).getElementsByTagName('option'),
                selectLength = $(id).length,
                i;
            
            for(i=0; i<selectLength; i+=1){
                if(selectOptions[i].value === value){
                    selectOptions[i].selected = true;
                    break;
                }
            }
        },
        adjustTimezoneDialog: function(){
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            timezoneDialogStyle.left = (GRN_Window.getWidth() / 2) - (450 / 2) + 'px';
            timezoneDialogStyle.top = (GRN_Window.getHeight() / 4) + scrollTop + 'px';
        },
        resizeBackground: function(){
            backgroundStyle.width = Math.max(body.clientWidth,body.scrollWidth) + 'px';
            backgroundStyle.height = Math.max(body.clientHeight,body.scrollHeight) + 'px';
        },
        onChangeStartTimezone: function(){
            var selectedValue = this.getSelectedValue(startTimezoneCandidate);
            
            if(endTimezoneBlock && this.hasEqualTimezones()){
                this.selectOption('end_timezone_candidate', selectedValue);
                GRN_Event.fireEvent(endTimezoneCandidate, 'change');
            }
            
            startTimezoneSelectedValue = selectedValue;
        },
        onChangeStartTimezoneRegion: function(){
            var selectedValue = this.getSelectedValue(startTimezoneRegion);
            
            if(this.isNormalEvent() && this.hasEqualTimezones()){
                this.selectOption('end_timezone_candidate-region', selectedValue);
                GRN_Event.fireEvent(endTimezoneRegion, 'change');
            }
            
            startTimezoneRegionValue = selectedValue;
        },
        onChangeEndTimezone: function(){
            endTimezoneSelectedValue = this.getSelectedValue(endTimezoneCandidate);
        },
        onChangeEndTimezoneRegion: function(){
            endTimezoneRegionValue = this.getSelectedValue(endTimezoneRegion);
        },
        hasEqualTimezones: function(){
            if(startTimezoneSelectedValue === endTimezoneSelectedValue && startTimezoneRegionValue === endTimezoneRegionValue){
                return true;
            }
            return false;
        },
        getSelectedValue: function(selectElement){
            var selectedIndex = selectElement.selectedIndex;
            return selectElement.options[selectedIndex].value;
        },
        getSelectedText: function(selectElement){
            var selectedIndex = selectElement.selectedIndex;
            return selectElement.options[selectedIndex].text;
        },
        isNormalEvent: function(){
            if(endTimezoneBlock){
                return true;
            }
            return false;
        },
        enableKeyDown: function(){
            if(!enableKey){
                document.onkeydown = oldKeyHandler;
                oldKeyHandler = null;
                enableKey = true;
            }
        },
        disableKeyDown: function(){
            if(enableKey){
                oldKeyHandler = document.onkeydown;
                document.onkeydown = function(e){
                    e = (e == undefined) ? event : e;
                    if( GRN_Event.keyCode(e) == Event.KEY_ESC ){
                        GRN_ScheduleSelectTimezone.closeTimezoneDialog();
                        return true;
                    }
                    return false;
                };
                enableKey = false;
            }
        },

        TIMEZONE_REGION_ALL: "(All)",

        /**
         * @param {string} newStartTimeZone
         * @param {string} newEndTimeZone
         */
        setStartAndEndTimeZones: function (newStartTimeZone, newEndTimeZone) {
            if (newStartTimeZone === startTimezoneSelectedValue &&
                newEndTimeZone === endTimezoneSelectedValue) {
                // Prevent calling "applyTimeZone" method.
                return;
            }

            if (newStartTimeZone !== startTimezoneSelectedValue) {
                var startCandidateValues = jQuery.map(startTimezoneCandidate.options, function (option) {
                    return option.value;
                });

                if (startCandidateValues.indexOf(newStartTimeZone) === -1) {
                    startTimezoneRegion.value = this.TIMEZONE_REGION_ALL;
                    GRN_Event.fireEvent(startTimezoneRegion, "change");
                }
                this.selectOption("timezone_candidate", newStartTimeZone);
            }
            if(endTimezoneBlock){
                if (newEndTimeZone !== endTimezoneSelectedValue) {
                    var endCandidateValues = jQuery.map(endTimezoneCandidate.options, function (option) {
                        return option.value;
                    });

                    if (endCandidateValues.indexOf(newEndTimeZone) === -1) {
                        endTimezoneRegion.value = this.TIMEZONE_REGION_ALL;
                        GRN_Event.fireEvent(endTimezoneRegion, "change");
                    }
                    this.selectOption("end_timezone_candidate", newEndTimeZone);
                }
            }
            this.applyTimezone();
        },

        /**
         * @returns {string}
         */
        getStartTimeZone: function () {
            return startTimezone.value;
        },

        /**
         * @returns {string}
         */
        getEndTimeZone: function () {
            return endTimezone.value;
        }
    };
}());

Event.observe($('timezone_candidate'), 'change', function(){
        GRN_ScheduleSelectTimezone.onChangeStartTimezone();
});
Event.observe($('timezone_candidate-region'), 'change', function(){
        GRN_ScheduleSelectTimezone.onChangeStartTimezoneRegion();
});
if($('end_timezone_block')){
    Event.observe($('end_timezone_candidate'), 'change', function(){
            GRN_ScheduleSelectTimezone.onChangeEndTimezone();
    });
    Event.observe($('end_timezone_candidate-region'), 'change', function(){
            GRN_ScheduleSelectTimezone.onChangeEndTimezoneRegion();
    });
}

});
