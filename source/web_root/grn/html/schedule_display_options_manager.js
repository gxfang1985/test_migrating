if( !GRN_ScheduleDisplayOptionFactory ){

    var GRN_ScheduleDisplayOptionFactory = {

        create: function( page_key, ticket, schedule_id, id){
            var pageKey = page_key;
            var dialog,that,optionsSwitch;
            var todoOption = null;
            var expiredTodoOption = null;
            var csrfTicket = ticket;
            var scheduleListID = schedule_id;
            var plid = id;
            return {

                init: function(){
                    that = GRN_ScheduleDisplayOptions[plid];
                    dialog = $('schedule_display_options_dialog'+plid);
                    optionsSwitch = $('schedule_display_options_switch'+plid);

                    // dialog exist -> addEvent
                    ( dialog ) && that.addEventOnDialog();
                    if(todoOption && todoOption.getCheckBoxElement())
                    {
                        Event.observe(todoOption.getCheckBoxElement() , 'click', function(){
                            todoOption.onClickShowToDo();
                        });
                    }

                    if (expiredTodoOption!== null)
                    {
                        Event.observe( expiredTodoOption.getCheckBoxElement() ,
                                       'click',
                                       function(){ expiredTodoOption.onClickShowToDo(); });
                    }
                },

                addEventOnDialog  : function(){
                    Event.observe(window, 'resize', function(){
                        setTimeout( 'GRN_ScheduleDisplayOptions["'+plid+'"].setDialogPosition()', 0 );
                    });

                    Event.observe(optionsSwitch, 'click', function(){
                        that.onClickDisplayOptions();
                        that.setDialogPosition();
                    });

                    Event.observe(window.document, 'click', function(e){
                        /* When click Inside of Dialog -> do nothing */
                        if( (e.element() != window.document) && that.isClickInsideOfDisplayOptions( e.element() )){ return ;}
                        /* When Dialog is visible -> Hide Dialog */
                        if( dialog.visible() ){
                            GRN_Event.fireEvent(optionsSwitch, 'click');
                        }
                    });

                },

                setDialogPosition : function(){
                    var dialogObj = jQuery('#schedule_display_options_dialog' + plid);
                    if (dialogObj.is(":visible")) {
                        dialogObj.css({"top": dialogObj.parent().outerHeight(), "left": dialogObj.parent().outerWidth() - dialogObj.outerWidth()});
                    }
                },

                isClickInsideOfDisplayOptions : function(target){
                    /* CASE 1 Click dialog  */
                    if( target === optionsSwitch || target === dialog ){
                        return true;
                    }
                    /* CASE 2 Click descendant Of dialog */
                    return target.descendantOf(dialog) || target.descendantOf(optionsSwitch);
                },

                onClickDisplayOptions: function(){
                    $('schedule_display_options_down_allow'+plid).toggle();
                    $('schedule_display_options_up_allow'+plid).toggle();
                    dialog.toggle();
                },

                createDisplayOptionOfToDo : function(url){
                     todoOption = ScheduleDisplayOptions.todo.create(url, pageKey, 'show_todos', plid,
                                                                     csrfTicket , scheduleListID ,'schedule_todo');
                },

                createDisplayOptionOfExpiredToDo : function(url){
                     expiredTodoOption = ScheduleDisplayOptions.todo.create(url, pageKey, 'show_expired_todos', plid,
                                                              csrfTicket , scheduleListID, 'schedule_expired_todo');
                },

                getTodoOption : function(){ return todoOption; }

            };
        }
    };

    var GRN_ScheduleDisplayOptions = {};

}
