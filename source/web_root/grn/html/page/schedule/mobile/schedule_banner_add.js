// namespace
grn.base.namespace("grn.page.schedule.mobile.schedule_banner_add");
(function () {
    var G = grn.page.schedule.mobile.schedule_banner_add;
    if (G.is_loaded)
    {
        return;
    }

    G.init = function()
    {
        G.startYearSelect = $('#start_year');
        G.startMonthSelect = $('#start_month');
        G.startDaySelect = $('#start_day');
        G.endYearSelect = $('#end_year');
        G.endMonthSelect = $('#end_month');
        G.endDaySelect = $('#end_day');
        G.invalidDateStyle = $('#invalid_date');
        G.addBtn = $('#addBtn');
    };

    G.onChangeDateTime = function()
    {
        var startYear = parseInt(G.startYearSelect.val()),
            startMonth = parseInt(G.startMonthSelect.val()),
            startDay = parseInt(G.startDaySelect.val()),
            endYear = parseInt(G.endYearSelect.val()),
            endMonth = parseInt(G.endMonthSelect.val()),
            endDay = parseInt(G.endDaySelect.val());

        if( ( startYear > endYear ) ||
            ( startYear === endYear && startMonth > endMonth ) ||
            ( startYear === endYear && startMonth === endMonth && startDay > endDay ) )
        {
            G.invalidateForm();
            return;
        }
        
        G.validateForm();
    };
    
    G.validateForm = function()
    {
        G.invalidDateStyle.hide();
        G.addBtn.button('enable');
    };
    
    G.invalidateForm = function()
    {
        G.invalidDateStyle.show();
        G.addBtn.button('disable');
    };
    
    window.checked_redirect = false;
    $(document).on( "pagebeforecreate", function( event )
    {
        if(location.hash && !window.checked_redirect)
        {
            var index = location.href.indexOf("#");
            location.href = location.href.split('#')[0];
        }
        window.checked_redirect = true;
    });
    
    $(document).on( "pagechange", function( event )
    {
        G.init();

        // check when user change time
        G.onChangeDateTime();
        G.startYearSelect.change( G.onChangeDateTime );
        G.startMonthSelect.change( G.onChangeDateTime );
        G.startDaySelect.change( G.onChangeDateTime );
        G.endYearSelect.change( G.onChangeDateTime );
        G.endMonthSelect.change( G.onChangeDateTime );
        G.endDaySelect.change( G.onChangeDateTime );
    });
            
    G.is_loaded = true;
})();
