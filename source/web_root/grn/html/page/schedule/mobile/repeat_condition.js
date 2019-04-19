// namespace
grn.base.namespace("grn.page.schedule.mobile.repeat_condition");
(function () {
    var G = grn.page.schedule.mobile.repeat_condition;
    if (G.is_loaded)
    {
        return;
    }
    
    G.isSaved = false; // check weather save settings of last choice repeat condition
    
    G.init = function()
    {
        G.container = $('#_repeat_condition');
        G.btnOK = G.container.find('.mobile_ok_grn');
        G.btnCancel = G.container.find('.mobile_cancel_grn');
        G.repeatConditionTitle = $('#repeat_condition_title');
        G.checkOnClass   = "mobile_icon_radiobuttonon_grn";
        G.checkOffClass  = "mobile_icon_radiobuttonoff_grn";
    };
    
    G.handleCheckRepeatCondition = function( event)
    {
        G.uncheckAllRadio();

        var item = event.target;
        var itemObj = $(item);
        
        itemObj.removeClass(G.checkOffClass);
        itemObj.addClass(G.checkOnClass);
        itemObj.siblings('.mobile_radiobutton_grn').find('input[type="radio"]').each(function(){
            $(this).prop('check','checked');
            G.container.find('#repeat_condition_type').val($(this).val());
        });
    };
    
    G.uncheckAllRadio = function()
    {
        G.container.find('input[type="radio"]').each(function(){
            $(this).prop('check',false);
        });

        G.container.find('.' + G.checkOnClass).each(function(){
            $(this).removeClass(G.checkOnClass);
            $(this).addClass(G.checkOffClass);
        });
    };
    
    G.setCondition = function()
    {
        G.container.find('.' + G.checkOnClass).each(function(){
            var thisObj = $(this);
            var liTag = thisObj.closest('li');
            var conditionCaption = '';
            if(liTag.hasClass('mobile_schedule_repeat_everyday'))
            {
                conditionCaption = liTag.find('.mobile_text_grn').html();
                G.repeatConditionTitle.html(conditionCaption);
            }
            
            if(liTag.hasClass('mobile_schedule_repeat_weekday'))
            {
                conditionCaption = liTag.find('.mobile_text_grn').html();
                G.repeatConditionTitle.html(conditionCaption);
            }
            
            if(liTag.hasClass('mobile_schedule_repeat_week'))
            {
                conditionCaption = liTag.find('#menu_week > .mobile_event_menu_content_grn').html();
                conditionCaption += ' ' + liTag.find('#menu_weekday > .mobile_event_menu_content_grn').html();
                G.repeatConditionTitle.html(conditionCaption);
            }
            
            if(liTag.hasClass('mobile_schedule_repeat_month'))
            {
                conditionCaption = liTag.find('.mobile_textmargin_grn').html();
                conditionCaption += ' ' + liTag.find('#menu_monthday > .mobile_event_menu_content_grn').html();
                G.repeatConditionTitle.html(conditionCaption);
            }
        });
    };
    
    G.handleApply = function()
    {
        G.setCondition();
        G.saveLastChoice();
        location.href = '#';
    };
    
    G.handleCancel = function()
    {
        if(G.isSaved)
        {
            G.returnLastChoice();
        }
        
        location.href = '#';
    };
    
    G.saveLastChoice = function()
    {
        G.isSaved = true;
        
        G.container.find('input[type="radio"]').each(function(){
            var thisObj = $(this);
            if(thisObj.prop('check') == 'checked')
            {
                G.lastCheck = thisObj.attr('id');
                return false;
            }
        });

        G.lastMenuWeekValue = $('#menu_week_value').val();
        G.lastMenuWeekTitle = $('#menu_week > .mobile_event_menu_content_grn').html();

        G.lastMenuWeekDayValue = $('#menu_weekday_value').val();
        G.lastMenuWeekDayTitle = $('#menu_weekday > .mobile_event_menu_content_grn').html();
        
        G.lastMenuMonthDayValue = $('#menu_monthday_value').val();
        G.lastMenuMonthDayTitle = $('#menu_monthday > .mobile_event_menu_content_grn').html();
    };
    
    G.returnLastChoice = function()
    {
        // return lastest check 
        G.selectRadioBtn(G.lastCheck);
        
        // return last select menu week
        $('#menu_week_value').val(G.lastMenuWeekValue);
        $('#menu_week_title').val(G.lastMenuWeekTitle).triggerHandler('change');
        
        // return last select menu week day
        $('#menu_weekday_value').val(G.lastMenuWeekDayValue);
        $('#menu_weekday_title').val(G.lastMenuWeekDayTitle).triggerHandler('change');
        
        // return last select menu month day
        $('#menu_monthday_value').val(G.lastMenuMonthDayValue);
        $('#menu_monthday_title').val(G.lastMenuMonthDayTitle).triggerHandler('change');
    };
    
    G.selectRadioBtn = function(id)
    {
        G.uncheckAllRadio();
        var radio = $('#' + id);
        radio.prop('check','checked');
        var liTag = radio.closest('li');
        var iconBtn = liTag.find('.mobile_icon_radiobutton_grn');
        iconBtn.addClass(G.checkOnClass);
    };
    
    $(document).ready(function()
    {
        G.init();
        G.container.find(".mobile_icon_radiobutton_grn").click( G.handleCheckRepeatCondition );
        
        G.btnOK.click( G.handleApply );
        G.btnCancel.click( G.handleCancel );
    });
            
    G.is_loaded = true;
})();
