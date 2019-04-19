(function(){
    "use strict";
    grn.base.namespace("grn.page.mail.personal.automation.register");

    var page = grn.page.mail.personal.automation.register;

    page.onDeleteConditionClicked = function(element)
    {
        if(jQuery("div.list_of_conditions > div.condition").length === 1)
        {
            return;
        }
        jQuery(element).parent(".condition").remove();

    };

    page.appendConditionTemplate = function()
    {
        jQuery(".list_of_conditions").append(jQuery(".template_of_condition").html());
    };

    page.onDeleteAllConditionsClicked = function()
    {
        jQuery(".list_of_conditions > .condition").remove();
        page.appendConditionTemplate();
    };

    page.onAddConditionClicked = function()
    {
        page.appendConditionTemplate();
    };

    page.constructConditions = function()
    {
        var conditions = [];
        jQuery("div.list_of_conditions > div.condition").each(function(index,element){
            var target = jQuery(element);
            conditions.push({
                "evaluationObject" : target.find("select[name=evaluationObject] :selected").val(),
                "evaluationMethod" : target.find("select[name=evaluationMethod] :selected").val(),
                "matchData" : target.find("input[name=matchData]").val()
            });
        });
        return conditions;
    };

    page.constructAutoForwardMessage = function(){
        var forwardTo = [];
        jQuery("ul.holder > li.bit-box").each(function(item, element)
        {
            forwardTo.push(grn.page.mail.personal.automation.register.createForwardAddress(element));
        });

        return {
          "forwardTo" : forwardTo
        };
    };

    page.createForwardAddress = function(element){
        var obj = jQuery(element);
        var display = obj.attr('dis');
        var address = obj.attr('rel');
        if (display.length > 0) {
            return '"' + decodeURIComponent(display) + '" ' + '<' + decodeURIComponent(address) + '>';
        } else {
            return address;
        }
    };

    page.constructActions = function()
    {
        var actions = [];
        jQuery("div.list_of_actions > div.action").each(function(index,element){
            var target = jQuery(element);
            var actionName = target.find("input[name=actionName]").val();
            var message = {};

            if( actionName === "grn.mail.automatic.forward") {
                message = page.constructAutoForwardMessage();
            } else {
                throw new Error("Invalid Automation Action Name (%s)".replace("%s", actionName));
            }

            actions.push({
                "name" : actionName,
                "message" : message
            });

        });
        return actions;
    };

    page.onRegisterEventClicked = function(actionName)
    {
        if( actionName !== "add" && actionName !== "modify")
        {
            throw new Error("Invalid actionName (%s)".replace("%s", actionName));
        }

        var accountId = parseInt(jQuery("input[name=accountId]").val());
        var eventName = jQuery("input[name=eventName]").val();
        if(jQuery.trim(eventName).length === 0)
        {
            jQuery("div#errorMessageField").show();
            return;
        }

        var json = {
                "action"    : "%s.event".replace("%s", actionName),
                "accountId" : accountId,
                "eventId"   : jQuery("input[name=eventId]").val(),
                "event" : {
                    "name" : jQuery.trim(eventName),
                    "logicType" : jQuery("select[name=logicType] :selected").val(),
                    "serviceStatus" : jQuery("input[name=serviceStatus]").val(),
                    "actions" : page.constructActions(),
                    "conditions" : page.constructConditions()
                }
        };

        jQuery.ajax(
            {
                "type" : "POST",
                "url" : page.commandAutomationURL,
                "dataType" : "json",
                "data" : {
                    "use_ajax" : 1,
                    "csrf_ticket" : grn.csrfTicket,
                    "json" : YAHOO.lang.JSON.stringify(json)
            }
        }).done(function(data, textStatus, jqXHR){
                if(grn.component.error_handler.hasCybozuError(jqXHR))
                {
                    grn.component.error_handler.show(jqXHR);
                }
                else if(data.result && data.result === "ok")
                {
                    location.href=data.redirect;
                }
                else
                {
                    throw new Error("Invalid response");
                }

        }).fail(function(jqXHR) {
                grn.component.error_handler.show(jqXHR);
        });
    };

    page.restoreAddressees = function()
    {
        var forwardTo = jQuery("textarea[name=forwardTo]").text().match(/("|\s")(\\\"|[^"])*"\s<[^>]+>+|[^,;]+/g);
        jQuery.each(forwardTo? forwardTo : [], function(index, address) {
            if(jQuery.trim(address).length === 0)
            {
                return;
            }
            //It is defined in web_root/grn/html/ui.mail.address.js
            //ugly....
            var data = grn.ui.mail.address.getEmailAndDisplayName(address);
            jQuery("select#forwardTo").append(
                "<option class='selected' value='%email%'>%name%</option>"
                    .replace("%email%", data.email)
                    .replace("%name%", data.display)
            );
        });
    };

    page.setUpFCBKComplete = function()
    {
        jQuery("select#forwardTo").fcbkcomplete(
            {
                "json_url": page.autoCompleteURL,
                "addontab": false,
                "maxitems": 1000,
                "input_min_size": 0,
                "height": 10,
                "cache": false,
                "newel": false,
                "firstselected": true,
                "oncreate" : function(){
                    var addressArea = jQuery("select#forwardTo").next();
                    grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                },
                "onremove" : function(){
                    var addressArea = jQuery("select#forwardTo").next();
                    grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                },
                "resource": {
                    "deletetooltip" :'delete'
                }
            }
        );

        jQuery(".holder").sortable(
            {
                "opacity": 0.6,
                "cursor": 'move',
                "tolerance": 'pointer',
                "connectWith": ".holder"
            }
        );

    };

    page.onAddressBookPopupClicked = function() {
        popupWin(page.popupAddressUrl,'address','','',0,0,0,1,0,1);
    };

    page.setUpAutoComplete = function() {
        page.restoreAddressees();
        page.setUpFCBKComplete();
    };

})();

/**
 * popup window callback
 */
(function(){
    "use strict";
    window.getFormParams = function()
    {
        var addressElements = jQuery("ul.holder > li.bit-box");
        var addressees = jQuery.map(addressElements, function(element){
            var result = grn.ui.mail.address.getEmailAndDisplayName(jQuery(element).text().trim());
            if(jQuery.trim(result.email) != "" && result.email != result.display)
            {
                return '"%name%" <%mail%>'.
                    replace('%name%', jQuery.trim(decodeURIComponent(result.display))).
                    replace('%mail%', jQuery.trim(decodeURIComponent(result.email)));
            }
            return jQuery.trim(decodeURIComponent(result.display));
        });
        return {
            "address_forwardTo" : addressees.join(","),
            "selectType" : "automaticForward",
            "form_name" : "mail/personal/automation/register",
            "tab_name" : window.tag_name,
            "reset" : 1
        };
    };

    window.ApplyAddress = function(object)
    {
        if(object === null)
        {
            return;
        }

        var addressees = object.forwardTo;
        var textArea   = jQuery("textarea[name=forwardTo]");
        jQuery("ul.holder").remove();
        jQuery("select[name=forwardTo]").empty();
        textArea.text(addressees);
        grn.page.mail.personal.automation.register.setUpAutoComplete();

    };
})();
