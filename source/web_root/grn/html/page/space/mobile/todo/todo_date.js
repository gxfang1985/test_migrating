// namespace
grn.base.namespace("grn.page.space.mobile.todo.todo_date");
(function () {
    var G = grn.page.space.mobile.todo.todo_date;
    var CK = grn.component.checkbox_mobile;
    if (G.is_loaded)
    {
        return;
    }

    $(document).on("click", "#date_button", function() {
        if ( $('#start_date').is(':hidden') )
        {
            G.showStartDate($(this));
            CK.check('#date_nolimit', false);
            if ( ! $('#start').val())
            {
                G.setDefaultDate('start');
            }
        }
        else
        {
            G.hideStartDate($(this));
        }
    });

    $(document).on("click", "#date_nolimit", function() {
        if ( $('#date_nolimit').hasClass("mobile-checkboxOff-todo-grn") )
        {
            G.disableDate("end", true);
        }
        else
        {
            G.disableDate("end", false);
        }
    });

    G.openDatebox = function( event )
    {
        str = event.data.str;
        $('#'+ str).datebox('open');
        $('#'+ str).bind('change', function () {
            $('span#'+ str + '_set').text( G.dateFormat( $('#'+ str).val() ) );
        });
    };

    G.showStartDate = function(button)
    {
        var $dButton = button;
        $('#start_date').show();
        G.removeMark(false);
        G.disableDate('start', false);
        G.disableDate("end", false);
        $('#end_date_nolimit').hide();
        
        $dButton.text(G.HIDE_END_DATE);
    };

    G.hideStartDate = function(button)
    {
        var $dButton = button;
        $('#start_date').hide();
        G.removeMark(true);
        G.disableDate('start', true);
        $('#end_date_nolimit').show();
        $('#start_linkmodelink').unbind('click');
        $dButton.text(G.SHOW_END_DATE);
    };

    G.disableDate = function( str, flag)
    {
        var s_div    = '#' + str + '_date';
        var s_input  = '#' + str;
        var btn_link = '#' + str + '_linkmodelink';

        if (flag)
        {
            if ( ! $(s_div).hasClass("ui-disabled") )
            {
                $(s_div).addClass("ui-disabled");
            }
            $(s_input).attr('disabled', 'disabled');
            $(btn_link).unbind('click', G.openDatebox);
        }
        else
        {
            if ( $(s_div).hasClass("ui-disabled") )
            {
                $(s_div).removeClass("ui-disabled");
            }
            $(s_input).removeAttr('disabled');
            $(btn_link).bind('click', {str: str}, G.openDatebox);
        }
    };

    // remove '~'
    G.removeMark = function(flag)
    {
        var end_link = '#end_linkmodelink';
        var mark = '.mobile-sign-calender-grn';
        if (flag)
        {
            $(mark).hide();
            if ( $(end_link).hasClass("mobile-btn-2calender-grn") )
            {
                $(end_link).removeClass("mobile-btn-2calender-grn");
            }
        }
        else
        {
            $(mark).show();
            if ( ! $(end_link).hasClass("mobile-btn-2calender-grn") )
            {
                $(end_link).addClass("mobile-btn-2calender-grn");
            }
        }
    };

    G.setDefaultDate = function(str)
    {
        var fdate = new Date();
        var Y = fdate.getFullYear();
        var M = fdate.getMonth()+1;
        var D = fdate.getDate();
        $('#'+ str).val(Y + '/' + M + '/' + D);
        $('span#'+ str +'_set').text( G.dateFormat( $('#'+ str).val() ) );
    };

    G.top = function()
    {
        location.hash = '#';
    };

    G.is_loaded = true;
})();
