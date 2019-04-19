// namespace
grn.base.namespace("grn.page.schedule.mobile.kintoneRelation");

(function ($) {

    var G = grn.page.schedule.mobile.kintoneRelation;
    var k_access_error_code = "CB_NO02";
    var resources = {};

    G.setResource = function (target, value) {
        resources[target] = value;
    };

    var constructRecordValue = function (fieldType, fieldCode, record, keepWrap) {
        if (typeof record[fieldCode] === "undefined") {
            return "";
        }

        var lengthLimit = 100;
        var returnValue = "";
        var value =  record[fieldCode].value === null ? "" : record[fieldCode].value;
        switch (fieldType) {
            case "CHECK_BOX" :
            case "MULTI_SELECT" :
                $.each(value, function (i) {
                    if (keepWrap) {
                        var v = value[i];
                        if (v.length > lengthLimit) {
                            v = v.substr(0, lengthLimit) + "...";
                        }
                        returnValue += (i === 0 ? "" : "\n") + v;
                    }
                    else {
                        returnValue += (i === 0 ? "" : "\n") + value[i];
                    }
                });
                break;
            case "FILE" :
                $.each(value, function (i) {
                    if (keepWrap) {
                        var v = value[i].name;
                        if (v.length > lengthLimit) {
                            v = v.substr(0, lengthLimit) + "...";
                        }
                        returnValue += (i === 0 ? "" : "\n") + v;
                    }
                    else {
                        returnValue += (i === 0 ? "" : "\n") + value[i].name;
                    }
                });
                break;
            case "RICH_TEXT" :
                returnValue = deleteHtmlTag(value);
                break;
            case "USER_SELECT":
                jQuery.each(value, function (i) {
                    if (keepWrap) {
                        var v = value[i].name;
                        if (v.length > lengthLimit) {
                            v = v.substr(0, lengthLimit) + "...";
                        }
                        returnValue += (i === 0 ? "" : ", ") + v;
                    }
                    else {
                        returnValue += (i === 0 ? "" : ", ") + value[i].name;
                    }
                });
                break;
            default :
                returnValue = value;
        }

        if (((fieldType !== "CHECK_BOX" && fieldType !== "MULTI_SELECT" && fieldType !== "FILE") || !keepWrap) && returnValue.length > lengthLimit) {
            returnValue = returnValue.substr(0, lengthLimit) + "...";
        }

        if (fieldType !== "RICH_TEXT") {
            returnValue = $.htmlEscape( returnValue );
        }
        if (keepWrap) {
            returnValue = returnValue.replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>");
        }
        else {
            returnValue = returnValue.replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, " ");
        }

        return returnValue;
    };

    var deleteHtmlTag = function (string) {
        return string.replace(/<br\s*\/?>/gi, "\n").replace(/<\/?([a-z][a-z0-9]*)\b[^>]*>/gi, "");
    };

    G.getRecordForView = function (itemId, appId, recordId, fieldCodes) {
        var jsonData = "{\"app\" : " + appId + ", \"id\" : " + recordId + "}";

        getFieldCodeName(fieldCodes, appId,
            function (fieldNames) {
                $.ajax({
                    url: "/k/v1/record.json",
                    data: JSON.parse(jsonData),
                    dataType: "json",
                    type: "GET"
                }).done(function (data, status, xhr) {

                    var recordHtml = $("#k_record_content_" + itemId);
                    for (var i = 0; i < fieldNames.length; i++) {
                        var divA = document.createElement("div");
                        divA.setAttribute("class", "mobile-list-todoDetail-grn");

                        var divB = document.createElement("div");
                        divB.setAttribute("class", "mobile-label-small-grn");
                        divB.innerHTML = $.htmlEscape(fieldNames[i].name);
                        divA.appendChild(divB);

                        var divC = document.createElement("div");
                        divC.setAttribute("class", "mobile_contents_detail_grn");
                        divA.appendChild(divC);
                        var record_value = constructRecordValue(fieldNames[i].type, fieldNames[i].code, data.record, true);
                        if (i !== 0) {
                            divC.innerHTML = record_value;
                        }

                        if (i === 0) {
                            var a = document.createElement("a");
                            a.setAttribute("class", "ui-link");
                            a.setAttribute("target", "_blank");
                            a.setAttribute("href", "/k/" + appId + "/show#record=" + recordId);
                            a.innerHTML = record_value;
                            divC.appendChild(a);
                        }
                        recordHtml.append(divA);
                    }
                }).fail(function (jqXHR, textStatus, errorThrown){
                    if (typeof jqXHR.responseJSON !== "undefined" && jqXHR.responseJSON.code === k_access_error_code) {
                        var recordHtml = $("#k_record_content_" + itemId);
                        var error_div = document.createElement("div");
                        error_div.setAttribute("class", "text_color_sub2_grn");
                        error_div.innerHTML = resources.access_error;
                        recordHtml.append(error_div);
                    }
                });
            },
            function(){
                var recordHtml = $("#k_record_content_" + itemId);
                var error_div = document.createElement("div");
                error_div.setAttribute("class", "text_color_sub2_grn");
                error_div.innerHTML = resources.access_error;
                recordHtml.append( error_div );
            }
        );

    };

    var getFieldCodeName = function (fieldCodes, appId, successCallBack, failCallBack) {
        var jsonData = '{"app":"' + appId + '"}';

        $.ajax({
            url: "/k/v1/form.json",
            data: JSON.parse(jsonData),
            dataType: "json",
            type: "GET"
        }).done(function (data, status, xhr) {
            var data_count = data.properties.length;
            var result = [];
            for (var i = 0; i < fieldCodes.length; i++) {
                for (var j = 0; j < data_count; j++) {
                    if (typeof data.properties[j].code !== "undefined" && (fieldCodes[i] === data.properties[j].code)) {
                        var temp_data = {};
                        temp_data.code = fieldCodes[i];
                        temp_data.name = data.properties[j].label;
                        temp_data.type = data.properties[j].type;
                        result.push(temp_data);
                    }
                }
            }
            successCallBack(result);
        }).fail(function (jqXHR, textStatus, errorThrown) {
            if (typeof jqXHR.responseJSON !== "undefined" && jqXHR.responseJSON.code === k_access_error_code) {
                failCallBack();
            }
        });
    };
})(jQuery);
