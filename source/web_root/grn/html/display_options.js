if( !GRN_DisplayOptionFactory ){

    var GRN_DisplayOptionFactory = {
        create: function(){
            var downAllow, upAllow, optionsSwitch,
                dialog,
                csrfTicket, page, ListID, plid;

            return {
                init: function(){
                    downAllow = jQuery("#display_options_down_allow" + plid);
                    upAllow = jQuery("#display_options_up_allow" + plid);
                    optionsSwitch = jQuery("#display_options_switch" + plid);
                    dialog = jQuery("#display_options_dialog" + plid);

                    displayOptions = optionsSwitch.parents('.display_options');
                    if( displayOptions.find('li.display_options_dialog_ch').length == 0 )
                    {
                        displayOptions.hide();
                    }

                    if( optionsSwitch.is(":visible") && dialog ){
                        this.setDialogPosition();

                        jQuery(window).resize(function(){
                            setTimeout(
                            'GRN_DisplayOptions["' + plid +'"].setDialogPosition()',0
                            );
                        });

                        optionsSwitch.click(function(e){
                            e.stopPropagation();
                            GRN_DisplayOptions[plid].setDialogPosition();
                            GRN_DisplayOptions[plid].onClickDisplayOptions();
                        });

                        jQuery(document).click(function(e){
                            var target = e.target,
                            dialog = jQuery("#display_options_dialog" + plid),
                            optionSwitch = jQuery("#display_options_switch" + plid);

                            if( !jQuery(target).is( dialog ) && !jQuery(target).is( optionsSwitch ) && dialog.is(":visible"))
                            {
                                GRN_DisplayOptions[plid].setDialogPosition();
                                GRN_DisplayOptions[plid].onClickDisplayOptions();
                            }
                        });
                    }

                },
                setDialogPosition: function () {
                    var switchOffset = cumulativeOffset(optionsSwitch.get(0));

                    var left = switchOffset[0];
                    var top = switchOffset[1] + optionsSwitch.height();

                    dialog.css("left", left);
                    dialog.css("top", top + 2 + "px");

                    if (navigator.userAgent.indexOf("AppleWebKit/") > -1)
                    {
                        dialog.css("top", top + 8);
                    }
                },
                onClickDisplayOptions: function(){
                    downAllow.toggle();
                    upAllow.toggle();
                    dialog.toggle();
                },
                setCSRFTicket: function(ticket){
                    csrfTicket = ticket;
                },
                setPage: function(pageKey){
                    page = pageKey;
                },
                setListID: function(id){
                    ListID = id;
                },
                setPLID: function(id){
                    plid = id;
                }
            };
        }
    };

    var GRN_DisplayOptions = {};
}