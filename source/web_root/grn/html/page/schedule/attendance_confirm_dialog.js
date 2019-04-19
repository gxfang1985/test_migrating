// namespace
grn.base.namespace("grn.page.schedule.attendance_confirm_dialog");

(function ($) {
    var G = grn.page.schedule.attendance_confirm_dialog;

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
        endMinuteSelect     : $('#end_minute').val(),
        startTimezone       : $('#timezone').val(),
        endTimezone         : $('#end_timezone').val()
    };

    G.checkShowDialog = function () {
        var attendanceCheckElm = $('#attendance_check');

        if (attendanceCheckElm.length == 0 || !attendanceCheckElm.get(0).checked) {
            G.yesCallback();
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
            endMinuteSelect     : $('#end_minute').val(),
            startTimezone       : $('#timezone').val(),
            endTimezone         : $('#end_timezone').val()
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
        for (i = 0; i < arrMapCompare.length; i++) {
            if (G.oldTime[arrMapCompare[i]] !== G.currentTime[arrMapCompare[i]]) {
                showDialogFlag = true;
                break;
            }
        }

        if (showDialogFlag) {
            G.showDialog();
        }
        else {
            G.yesCallback();
        }
    };

    G.closeDialog = function (dialogId) {
        $("#attendance_check_overlay").outerWidth(0);
        $("#attendance_check_overlay").outerHeight(0);
        $("#attendance_check_overlay").hide();

        $("#" + dialogId).hide();
        grn.component.button('#schedule_submit_button').hideSpinner();
    };

    G.showDialog = function () {
        showOverlay();

        adjustDialog("attendance_check_dialog");

        // get title of appointment
        var menu = $("select[name=menu]").val();
        menu = menu.substring(0, menu.length - 3);
        var title = $("input[name=title]").val();
        var appointmentTitle = '';
        if (menu.length == 0 && title.length == 0) {
            appointmentTitle = '--';
        }
        else {
            if (menu.length > 0 && title.length > 0) {
                appointmentTitle = menu + ':' + title;
            }
            else {
                appointmentTitle += (menu.length > 0) ? menu : '';
                appointmentTitle += (title.length > 0) ? title : '';
            }
        }
        $("#attendance_check_confirm_title").text(appointmentTitle);
        $("#refresh_status").prop("checked", false);

        $("#attendance_check_dialog").show();

        $("#attendance_check_dialog").find("#yes_button").click(function () {
            if (typeof G.yesCallback === "function") {
                G.yesCallback();
            }
        });
    };

    var showOverlay = function () {
        adjustOverlay();
        $("#attendance_check_overlay").show();
    };

    var adjustDialog = function (dialogId) {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        var dialog = $("#" + dialogId);
        dialog.css({"left": (GRN_Window.getWidth() / 2) - (dialog.outerWidth() / 2), "top": (GRN_Window.getHeight() / 2) - (dialog.outerHeight() / 2) + scrollTop});
    };

    var adjustOverlay = function () {
        var b = document.body;
        $("#attendance_check_overlay").outerWidth(Math.max(b.clientWidth, b.scrollWidth));
        $("#attendance_check_overlay").outerHeight(Math.max(b.clientHeight, b.scrollHeight));
    };

    $(window).resize(function () {
        if ($("#attendance_check_dialog").is(":visible")) {
            adjustOverlay();
            adjustDialog("attendance_check_dialog");
        }
    });

    $(window).scroll(function () {
        if ($("#attendance_check_dialog").is(":visible")) {
            adjustDialog("attendance_check_dialog");
        }
    });
})(jQuery);
