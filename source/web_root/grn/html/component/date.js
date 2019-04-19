(function () {
    'use strict';
    grn.base.namespace("grn.component.date");

    var G = grn.component.date;

    G.parse = function (date_string) {
        var date_regex = /([0-9]+)-([0-9]+)-([0-9]+) +([0-9]+):([0-9]+):([0-9]+)/;
        var match = date_regex.exec(date_string);
        if (match != null) {
            return new Date(match[1], match[2] - 1, match[3], match[4], match[5], match[6]);
        }

        date_regex = /([0-9]+)-([0-9]+)-([0-9]+)/;
        match = date_regex.exec(date_string);
        if (match != null) {
            return new Date(match[1], match[2] - 1, match[3]);
        }

        return false;
    };

    G.toLocaleDateString = function (date, format) {
        format = format || grn.data.short_date_format;

        var string_day;
        if (date.getDate() < 10) {
            string_day = format.replace('&&mday&&', '0' + date.getDate());
        }
        else {
            string_day = format.replace('&&mday&&', date.getDate());
        }

        if (date.getMonth() + 1 < 10) {
            string_day = string_day.replace('&&mon&&', '0' + (date.getMonth() + 1));
        }
        else {
            string_day = string_day.replace('&&mon&&', date.getMonth() + 1);
        }

        var i18n = grn.component.i18n;

        string_day = string_day.replace('&&year&&', date.getFullYear());
        string_day = string_day.replace('&&monthfull&&', i18n.cbMsg('fw.date', 'MonthFull' + (date.getMonth() + 1)));
        string_day = string_day.replace('&&wdayshort&&', i18n.cbMsg('fw.date', 'WDayShort' + date.getDay()));
        string_day = string_day.replace('&&wdayfull&&', i18n.cbMsg('fw.date', 'WDayFull' + date.getDay()));

        return string_day;
    };
})();