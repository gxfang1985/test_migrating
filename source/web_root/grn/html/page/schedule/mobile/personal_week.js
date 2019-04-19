(function ($) {
    grn.base.namespace('grn.page.schedule.mobile.personal_week');
    if (grn.page.schedule.mobile.personal_week.PersonalWeek) {
        return;
    }

    grn.page.schedule.mobile.personal_week.PersonalWeek = function (options) {//Functions are object
        var bdate = options.bdate || "";
        var uid = options.uid || "";
        var gid = options.gid || "";
        var referer_key = options.referer_key || "";
        var url = options.url || window.location.href;
        this.goToAddPage = function () {
            if (url != "" && url.indexOf("?") > -1) {
                url = url.substr(0, url.indexOf("?"));
            }
            url = url.replace(/personal_week/gi, 'add');
            url = url + "?bdate=" + bdate + "&uid=" + uid + "&gid=" + gid + "&referer_key=" + referer_key;
            window.location.href = url;
        };
    };

    $(document).on("pageinit", function () {
        //add new event click here
        var add_event = function (e) {
            var _this = $(e);
            var options = {
                'bdate': _this.attr('data-bdate'),
                'uid': _this.attr('data-uid'),
                'gid': _this.attr('data-gid'),
                'referer_key': _this.attr('data-ref_key'),
                'url': window.location.href
            };
            var personal_week = new grn.page.schedule.mobile.personal_week.PersonalWeek(options);
            personal_week.goToAddPage();
        };
        $(".mobile_week_day_title_grn").children(".mobile_right_icon_grn").on("click", function () {
            add_event(this);
        });
        //Add new event (at footer)
        $("#footer_bar_b").on("click", function (e) {
            e.preventDefault();
            var personal_week = new grn.page.schedule.mobile.personal_week.PersonalWeek(grn.page.schedule.mobile.personal_week.Parameters);
            personal_week.goToAddPage();
        });
        //auto-fix
        $("li.no-appointment").parent().addClass("mobile_no_appointment_ul_grn");
    });//end ready
})(jQuery);