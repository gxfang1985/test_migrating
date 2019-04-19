(function(){
    "use strict";
    grn.base.namespace("grn.page.mail.personal.automation");

    var page = grn.page.mail.personal.automation;

    page.onSelectedAccountChanged = function() {
        var selectAccountId = jQuery(".menu_item > select :selected").val();
        var jumpLocation = location.href.replace(/\?.*$/,"");
        location.href  = jumpLocation + "?accountId=" + selectAccountId;
    };

    page.onDeleteClicked = function(eventId, accountId) {
        var title_element = jQuery("td.eventSummery%d.eventName > span".replace("%d", eventId));
        if( title_element.length !== 1 ) {
            return;
        }
        var title = title_element.text();
        jQuery("#delete_automatic_event_title").text(title);
        GRN_MsgBox.show(
            jQuery("#delete_automatic_event").html(),
            page.caption.deleteMessageBoxTitle,
            GRN_MsgBoxButtons.yesno,
            {
                ui : [],
                caption : {
                    yes : page.caption.yes,
                    no :  page.caption.no
                },
                callback : function(clickButton)
                {
                    if (clickButton == GRN_MsgBoxResult.yes)
                    {
                        page.createCommandAutomationAjax({
                            "action" : "delete.event",
                            "accountId" : accountId,
                            "eventId" : eventId
                        }).done(function(data, textStatus, jqXHR){
                            if(grn.component.error_handler.hasCybozuError(jqXHR))
                            {
                                grn.component.error_handler.show(jqXHR);
                            }
                            if(! data.result)
                            {
                                throw new Error("Invalid Response");
                            }
                            location.href = data.redirect;
                        });
                    }
                }
            }
        );
    };

    page.createCommandAutomationAjax = function(jsonData) {
        return jQuery.ajax({
            "type" : "POST",
            "url" : page.commandAutomationURL,
            "dataType" : "json",
            "data" : {
                "use_ajax" : 1,
                "csrf_ticket" : grn.csrfTicket,
                "json" : YAHOO.lang.JSON.stringify(jsonData)
            }
        }).fail(function(jqXHR) {
                grn.component.error_handler.show(jqXHR);
        });
    };

    page.changeEvent = function(actionName, eventId, callBack){

        var accountId = page.accountId;
        page.createCommandAutomationAjax({
            "action" : actionName,
            "accountId" : accountId,
            "eventId" : eventId
        }).done(function(data, textStatus, jqXHR){
                if(grn.component.error_handler.hasCybozuError(jqXHR))
                {
                    grn.component.error_handler.show(jqXHR);
                    return;
                }
                if(! data.result)
                {
                    throw new Error("Invalid response");
                }
                callBack(eventId);
        });

    };
    
    page.enableEvent = function(toggleButton) {
        var eventId = toggleButton.obj.attr("id").replace("serviceStatusToggleButton", "");
        page.changeEvent("enable.event", eventId, function(eventId){
            this.turnOn();
            var eventSummery = jQuery("td.eventSummery%d".replace("%d", eventId));
            eventSummery.removeClass("gray");
        }.bind(toggleButton));
    };

    page.disableEvent = function(toggleButton) {
        var eventId = toggleButton.obj.attr("id").replace("serviceStatusToggleButton", "");
        page.changeEvent("disable.event", eventId, function(eventId){
            this.turnOff();
            var eventSummery = jQuery("td.eventSummery%d".replace("%d", eventId));
            eventSummery.addClass("gray");
        }.bind(toggleButton));
    };


    jQuery(document).ready(function(){
        var toggleButton = grn.component.toggle_button;

        var caption = {
            "on_msg" : page.caption.inService,
            "off_msg" : page.caption.outOfService,
            "turn_on_msg" : page.caption.enableService,
            "turn_off_msg" : page.caption.disableService
        };

        var callback = {
            "turn_on" : page.enableEvent,
            "turn_off": page.disableEvent
        };
        jQuery("span.button_state_small_grn").each(function(index,element) {
              new toggleButton.ToggleButton(
                  jQuery(element).attr("id"),
                  caption,
                  callback
              );
          });
    });
})();
