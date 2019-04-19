grn.base.namespace("grn.page.schedule.attendance_confirm");

grn.page.schedule.attendance_confirm = (function($)
{
    "use strict";

    function _initialize( $part )
    {
        /*jshint validthis: true*/
        $part.find('#btnAttendance').click($.proxy(_submit, this, "attendant"));
        $part.find('#btnAbsent').click($.proxy(_submit, this, "absent"));

        var $textArea = $part.find('.form_textarea_grn');
        $textArea.css({"width": 689, "height": 30, "min-height": 30});
        $textArea.click($.proxy(_expandTextArea, this, $textArea));
    }

    function _expandTextArea( $target )
    {
        if ($target.hasClass("prefix-grn"))
        {
            $target.val("");
            $target.css("height", 60);
            $target.removeClass("prefix-grn");
        }
    }

    function _submit( $action )
    {
        var form = document.forms.namedItem("attendance_confirm");
        if (form) {
            form.status.value = $action;
            if ($(form.message).hasClass("prefix-grn"))
            {
                form.message.value = "";
            }
            var tabActive = $("#attendanceStatusTab").find("li.active");
            var elTab = $("<input type='hidden' name='tab'>");
            elTab.attr("value", tabActive.index());
            $(form).append(elTab);
            form.submit();
        }
    }

    function _tabInitialize( tabList )
    {
        var tabActive = tabList.find("li.active"),
            attendees = $("#attendanceStatusSection").find("div.schedule_member_base_grn"),
            groups = attendees.find("span.group-grn"),
            users = attendees.find("span.user-grn"),
            attendances = attendees.find("span.attendant"),
            absents = attendees.find("span.absent"),
            unconfirmed = attendees.find("span.unconfirmed"),
            showHideAttendeesElement = attendees.find("span.nowrap-grn"),
            numOfGroups = 0,
            numOfUsers = 0,
            displayLimit = 0,
            displayAll = false;
        
        displayLimit = tabList.data("displayLimit") ? parseInt(tabList.data("displayLimit")) : 0;
        displayAll = (displayLimit > grn.page.schedule.attendance_confirm.DISPLAY_USERS_LIMIT);
        displayLimit = displayAll ? displayLimit : grn.page.schedule.attendance_confirm.DISPLAY_USERS_LIMIT;
        _displayTab( tabActive, displayLimit );

        tabList.on("click", "li", function()
        {
            var thisTab = $(this);
            /**
             * Deactivate current tab
             */
            tabList.find("li.active").each(function() {
                var _thisTab = $(this);
                _thisTab.removeClass("active").empty().append("<p><a href='javascript:void(0);'>"+ _thisTab.data("displayText") +"</a></p>");
            });
            /**
             * Activate new tab
             */
            thisTab.addClass("active");
            thisTab.empty();
            thisTab.append("<p><span>" + thisTab.data("displayText") + "</span></p>");

            _displayTab( thisTab, displayLimit );
            tabActive = thisTab;
        });
        
        showHideAttendeesElement.click(function(event)
        {
            if (typeof getPageUrl === "function")
            {
                var currentUrl = getPageUrl();
                currentUrl += "&tab=" + tabActive.index();
                if (!displayAll)
                {
                    currentUrl += "&du=1";
                }
                location.href = currentUrl;
                event.preventDefault();
            }
        });
        
        function _displayTab( tab, displayLimit )
        {
            if (tab === "undefined")
            {
                return;
            }
            attendees.children().hide();
            numOfGroups = tab.data("groupCount") ? parseInt(tab.data("groupCount")) : 0;
            numOfUsers = tab.data("userCount") ? parseInt(tab.data("userCount")) : 0;
            switch (tab.index())
            {
                case 1:
                    _displayUsers( attendances, displayLimit );
                    break;
                case 2:
                    _displayUsers( absents, displayLimit );
                    break;
                case 3:
                    _displayUsers( unconfirmed, displayLimit );
                    break;
                default:    /*tab.index = 0*/
                    groups.show();
                    _displayUsers( users, displayLimit - numOfGroups );
                    break;
            }
            /**
             * Display the link to show/hide users.
             */
            if (numOfUsers > grn.page.schedule.attendance_confirm.DISPLAY_USERS_LIMIT)
            {
                showHideAttendeesElement.show();
            }
        }
        
        function _displayUsers( users, limit )
        {
            /**
             * When list of items need to show is less than limit, use jQuery feature to show them.
             */
            if (users.length <= limit)
            {
                users.show();
                return;
            }
            /**
             * when list of items need to show is greater than limit, just display "limit" items
             */
            for(var i = 0; i < users.length && i < limit; i++)
            {
                $(users[i]).show();
            }
        }
    }

    var api = {
        $attendanceConfirmPart:  null,
        $attendanceStatusPart: null,
        initialize: function() {
            this.$attendanceConfirmPart = $("#attendance_confirm_part");
            this.$attendanceStatusPart = $("#attendanceStatusTab");
            _initialize(this.$attendanceConfirmPart);
            _tabInitialize(this.$attendanceStatusPart);
        }
    };
    return api;
})(jQuery);

jQuery.event.add(window, "load", function()
{
    "use strict";
    grn.page.schedule.attendance_confirm.DISPLAY_USERS_LIMIT = 10;
    grn.page.schedule.attendance_confirm.initialize();
});
