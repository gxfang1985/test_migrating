(function () {
    "use strict";

    grn.base.namespace("grn.page.system.user.sandbox.org_list");

    var popupClass = "div.balloon_sub_dialog_grn";

    var orgList = grn.page.system.user.sandbox.org_list = {
        ajaxUrl: "", // this is assigned on .tpl file.
        resources: {}, // this is assigned on .tpl file.

        showPopup: function (popup, labelType, position) {
            jQuery.ajax({
                "type": "POST",
                "url": this.ajaxUrl,
                "dataType": "json",
                "data": {
                    "use_ajax": 1,
                    "status": labelType
                }
            }).fail(function (jqXHR) {
                grn.component.error_handler.show(jqXHR);
            }).done(function (data, textStatus, jqXHR) {
                if (grn.component.error_handler.hasCybozuError(jqXHR)) {
                    grn.component.error_handler.show(jqXHR);
                    return;
                }

                // set title label
                var titleLabel = orgList.resources[labelType]["title"] + data.length + orgList.resources.unit;
                popup.find("div.sub_title").text(titleLabel);

                // set group label
                var box = popup.find("div.common_list_grn"), fragment;
                box.empty();
                if (data.length > 0) {
                    fragment = jQuery("<ul/>");
                    jQuery.each(data, function (indexId, groupObj) {
                        var groupLabel = jQuery("<li/>");
                        groupLabel.text(groupObj.name);
                        fragment.append(groupLabel);
                    });
                } else {
                    fragment = jQuery("<div class='mTop5'/>");
                    fragment.text(orgList.resources[labelType]["emptyLabel"]);
                }
                box.append(fragment);

                // show popup
                popup.css({
                    "visibility": "visible",
                    "top"  : position.top + 20 + "px",
                    "left" : position.left - 10 + "px"
                });
            });
        },
        hidePopup: function (popup) {
            popup.css({"visibility": "hidden"});
        },
        togglePopup: function (labelType, position) {
            var popup = jQuery(popupClass);
            if (popup.css("visibility") === "visible") {
                orgList.hidePopup(popup);
            } else {
                orgList.showPopup(popup, labelType, position);
            }
        }
    };

    // bind events
    var pulldownBase = jQuery("div.sandbox_pulldown_base_grn");
    pulldownBase.find("a.sandbox_pulldown_delete_grn").bind("click", function () {
        orgList.togglePopup("delete", jQuery(this).position());
        return false;
    });
    pulldownBase.find("a.sandbox_pulldown_update_grn").bind("click", function () {
        orgList.togglePopup("modify", jQuery(this).position());
        return false;
    });
    pulldownBase.find("a.sandbox_pulldown_new_grn").bind("click", function () {
        orgList.togglePopup("add", jQuery(this).position());
        return false;
    });

    jQuery(document).bind("click", function (event) {
        var parents = jQuery(event.target).parents(popupClass);
        if (parents.length === 0) {
            var popup = jQuery(popupClass);
            orgList.hidePopup(popup);
        }
    });
}());