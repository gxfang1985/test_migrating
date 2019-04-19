// namespace
grn.base.namespace("grn.page.schedule.kintoneRelation");

(function () {
    var G = grn.page.schedule.kintoneRelation;

    // the table of schedule form; DOM object
    var table = null;

    // select tag; DOM object
    var selectTag = null;

    // information of kintone relation
    var systemInfo = null;

    var resources = {"add": "Add", "edit": "Edit", "delete": "Delete", "naviNum": "10", "spinnerImage": "", "accessError": "アクセス権がありません。"};

    // The place where appended items are inserted
    // At the point of F5.1,it is fixed
    var rowPosition = 2;

    // Row numbers of schedule form
    var allRowsNumber = 1;

    // Remove appended rows (reset form)
    var removeRows = function () {
        var rowLen = table.rows.length;
        if (rowLen > allRowsNumber) {
            var curRow = rowPosition;
            while (rowLen-- > allRowsNumber) {
                var child = jQuery(table.rows[curRow]).find("[id^=app_]");
                if (child.length > 0 && typeof child.attr("id") !== "undefined") {
                    var itemId = child.attr("id").substr(4);
                    if (G.isAllMenuItem(itemId)) {
                        curRow++;
                    }
                    else {
                        table.deleteRow(curRow);
                    }
                }
            }
        }
    };

    // Insert one item
    var insertRow = function (rownum, rowname, rowfunc, itemId) {
        if (table == null) {
            return;
        }

        var row = table.insertRow(rownum);

        var th1 = document.createElement("th");
        th1.innerHTML = rowname;
        row.appendChild(th1);

        var cell1 = row.insertCell(-1);
        cell1.setAttribute("id", "td_kintone_" + itemId);

        var div = document.createElement("div");
        div.setAttribute("class", "mTop7 mBottom7 mLeft5");
        cell1.appendChild(div);

        var ank1 = document.createElement("a");
        ank1.setAttribute("href", "javascript:void(0);");
        ank1.setAttribute("class", "icon_add_grn");
        ank1.setAttribute("onclick", rowfunc);
        ank1.innerHTML = resources["add"];
        div.appendChild(ank1);

        var input1 = document.createElement("input");
        input1.setAttribute("type", "hidden");
        input1.setAttribute("name", "app_" + itemId);
        input1.setAttribute("id", "app_" + itemId);
        row.appendChild(input1);

        var input2 = document.createElement("input");
        input2.setAttribute("type", "hidden");
        input2.setAttribute("name", "record_" + itemId);
        input2.setAttribute("id", "record_" + itemId);
        row.appendChild(input2);
    };

    // insert all items
    G.insertItems = function () {
        removeRows();

        if (selectTag == null) {
            return false;
        }

        var selected = selectTag.selectedIndex;
        if (selected === -1) {
            return false;
        }

        var selectedMenu = selectTag.options[selected].text;
        var curRow = rowPosition;

        if (systemInfo != null) {
            jQuery.each(systemInfo, function (itemId, value) {
                var needInsertRow = false;
                var allMenu = value["allMenu"];
                if (allMenu) {
                    var child = jQuery(table.rows[curRow]).find("[id^=app_]");
                    if (child.attr("id") === "app_" + itemId) {
                        curRow++;
                    }
                    else {
                        needInsertRow = true;
                    }
                }
                else {
                    var menus = value["menus"];
                    jQuery.each(menus, function (i) {
                        if (selectedMenu === menus[i]) {
                            needInsertRow = true;
                        }
                    });
                }

                if (needInsertRow) {
                    var itemName = value["itemName"].escapeHTML();
                    var func = "grn.page.schedule.kintoneRelation.showDialog('" + itemId + "');";
                    insertRow(curRow++, itemName, func, itemId);
                }
            });
        }
    };

    G.setResource = function (target, value) {
        resources[target] = value;
    };

    // set table where items will be inserted
    G.setBaseTable = function (tableName) {
        table = document.getElementById(tableName);
        allRowsNumber = table.rows.length;
    };

    // set select tag for appointment menu
    G.setSelectTag = function (id) {
        selectTag = document.getElementById(id);
    };

    // copy the system setting information
    G.setSystemInfo = function (info) {
        systemInfo = info;
    };

    // current item id; set in "initDialog"
    var currentItemId = null;

    // selected app id; set in "initDialog", reset in "changeAppList"
    var selectedAppId = null;

    // field code list of kintone form, Object{"app id" : ["field code"]}; set in "initDialog"
    var fieldsList = {};

    // the active fields of one app, use for get records from kintone,
    // Object{"item id" : [{"field":"xx", "name":"xx", "type":"xx"}]}; set in "setActiveFields"
    var activeFields = {};

    // the user_select fields of one app, use for filter by user,
    // Object{"item id" : [{"field":"xx", "name":"xx", "type":"xx"}]}; set in "resetActiveFields"
    var userSelectFields = {};

    // current position of navigation; set in "initDialog", reset in "pageNavigation"
    var navigationPosition = 0;

    G.showMenuChangeDialog = function (yesCallback) {
        showOverlay();
        adjustDialog("menu_change_dialog");
        jQuery("#menu_change_dialog").show();

        jQuery("#menu_change_dialog").find("#yes_button").click(function () {
            if (typeof yesCallback === "function") {
                yesCallback();
                G.closeDialog("menu_change_dialog");
            }
        });
    };

    G.openKintoneAddRecordPopup = function () {
        G.closeDialog("kintone_dialog");

        var $iframeKintone = jQuery("<iframe></iframe>");

        // create simple dialog contain kintone iframe
        var $kintoneSimpleDialog = G._createKintoneAddDialog(selectedAppId, $iframeKintone);
        $kintoneSimpleDialog.openDialog();

        // Bind event iframe kintone loaded
        $iframeKintone.on("load", G._initKintoneFrame.bind(this, selectedAppId, $iframeKintone, $kintoneSimpleDialog));

    };

    G._initKintoneFrame = function (appId, iframeKintone, kintoneSimpleDialog){
        var $iframeContentWindow = iframeKintone[0].contentWindow;
        var kintoneObj = $iframeContentWindow.kintone;
        kintoneObj.events.on("app.record.create.submit.success", function (ev) {
            var record = ev.record;
            var recordId = record["$id"]["value"];
            if (typeof recordId !== "undefined") {
                G.getRecordForModify(currentItemId.substr(5), appId, recordId, []);
                kintoneSimpleDialog.closeDialog();
            }
        });

        var $buttonCancelKintone = jQuery($iframeContentWindow.document.getElementById("appForm-gaia")).find(".gaia-ui-actionmenu-cancel");
        var $newButtonCancelKintone = $buttonCancelKintone.clone();
        $buttonCancelKintone.replaceWith($newButtonCancelKintone);
        $newButtonCancelKintone.on('click', function (event) {
            kintoneSimpleDialog.closeDialog();
        });
    };

    G._createKintoneAddDialog = function (appId, iframeKintone) {
        // create iframe object contain kintone add record screen
        var $divContentKintoneDialog = jQuery("<div id='kintone-content-dialog'></div>");
        $divContentKintoneDialog.css("width", 800)
            .css("height", 700);

        if (isTouchDevice()) {
            $divContentKintoneDialog.css("-webkit-overflow-scrolling", "touch")
                .css("overflow-y", "scroll");
        }

        iframeKintone.attr("id", "kintone-iframe")
            .attr("src", "/k/" + appId + "/edit")
            .css("border", "0px")
            .css("width", 800)
            .css("height", 700);

        $divContentKintoneDialog.append(iframeKintone);

        // create simple dialog contain kintone iframe
        var $kintoneSimpleDialog = new grn.component.WindowSimpleDialog({
            title: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1063"),
            content: $divContentKintoneDialog,
            modal: true
        });

        return $kintoneSimpleDialog;
    };

    var showOverlay = function () {
        adjustOverlay();
        jQuery("#kintone_overlay").show();
    };

    G.closeDialog = function (dialogId) {
        jQuery("#kintone_overlay").outerWidth(0);
        jQuery("#kintone_overlay").outerHeight(0);
        jQuery("#kintone_overlay").hide();

        jQuery("#" + dialogId).hide();
    };

    G.showDialog = function (itemId, appId) {
        showOverlay();
        initDialog(itemId, appId);
        adjustDialog("kintone_dialog");
        jQuery("#kintone_dialog").show();
    };

    var initDialog = function (itemId, oldAppId) {
        jQuery("#kintone_dialog_title").html(systemInfo[itemId]["itemName"].escapeHTML());

        showContent("spinner");
        jQuery("#app_list_select").html("");
        jQuery("#keyword_kintone_search_key").val("");
        jQuery("#keyword_kintone_search_user").val("");
        jQuery("#kintone_user_code_name").val("");
        jQuery("#record_list").html("");
        jQuery("#kintone_add_record_button")
            .off("click")
            .on("click", G.openKintoneAddRecordPopup.bind(G));

        currentItemId = itemId;
        fieldsList = {};

        var appIds = "{";
        var kintoneApp = systemInfo[itemId]["kintoneApp"];
        jQuery.each(kintoneApp, function (i) {
            var appId = kintoneApp[i]["appID"];
            fieldsList[appId] = kintoneApp[i]["fieldCode"];
            if (i !== 0) {
                appIds += ", \"ids[" + i + "]\" : " + appId;
            }
            else {
                appIds += "\"ids[" + i + "]\" : " + appId;
            }
        });
        appIds += "}";

        kintoneAjaxGet("/k/v1/apps.json", appIds, function (data, textStatus, jqXHR) {
            var apps = data.apps;
            if (apps.length > 0) {
                if (1 === apps.length) {
                    selectedAppId = apps[0].appId;
                    setActiveFields(itemId, selectedAppId, fieldsList[selectedAppId], function () {
                        setRecordTableTitle(itemId);
                        setStatusUserSearchInput(itemId);
                        G.pageNavigation("top");
                    });
                }
                else {
                    var activeApps = [];
                    var appLength = apps.length;

                    var checkLength = function () {
                        appLength--;
                        if (0 === appLength) {
                            if (activeApps.length > 0) {
                                setAppList();
                            }
                            else {
                                G.kintoneError.showGaroonError();
                            }
                        }
                    };

                    var setAppList = function () {
                        if (1 === activeApps.length) {
                            selectedAppId = activeApps[0].appId;
                        }
                        else {
                            var appListHtml = "<span class='text_color_sub_grn mRight3'>" + grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1067") + "：</span><dl class='selectmenu_grn selectmenu_base_grn'><dt>";
                            appListHtml += "<a class='nowrap-grn' href='javascript:void(0)'><span></span><span class='pulldownbutton_arrow_down_grn mLeft3'></span></a>";
                            appListHtml += "</dt><dd><div style='display: none;' class='pulldown_menu_grn'><ul>";

                            var isFirstOption = true;
                            var appName = "";
                            jQuery.each(kintoneApp, function (i) {
                                var isExisted = false;
                                var tmpAppName = "";
                                jQuery.each(activeApps, function (j) {
                                    if (activeApps[j].appId === kintoneApp[i]["appID"]) {
                                        isExisted = true;
                                        tmpAppName = activeApps[j].name.escapeHTML();
                                        appListHtml += "<li><a href='javascript:void(0)'><span class='vAlignMiddle-grn'>";
                                        appListHtml += tmpAppName + "</span><input type='hidden' value='";
                                        appListHtml += activeApps[j].appId.escapeHTML() + "'/></a></li>";
                                        if (isFirstOption) {
                                            selectedAppId = activeApps[j].appId;
                                            appName = tmpAppName;
                                            isFirstOption = false;
                                        }
                                    }
                                });
                                if (isExisted && kintoneApp[i]["appID"] === oldAppId) {
                                    selectedAppId = oldAppId;
                                    appName = tmpAppName;
                                }
                            });

                            appListHtml += "</ul></div></dd></dl><div class='border_partition_common_dashed_grn'></div>";
                            jQuery("#app_list_select").html(appListHtml);
                            jQuery("#app_list_select").find("dt").children("a").children("span:first-child").html(appName);
                            grn.component.pulldown_menu.pulldown_menu.init(jQuery("#app_list_select").children("dl"), changeAppList);
                        }

                        setActiveFields(itemId, selectedAppId, fieldsList[selectedAppId], function () {
                            setRecordTableTitle(itemId);
                            setStatusUserSearchInput(itemId);
                            G.pageNavigation("top");
                        });
                    };

                    jQuery.each(apps, function (i) {
                        var jsonData = "{\"app\": " + apps[i].appId + ", \"fields[0]\": \"$id\", \"query\": \"limit 1\"}";
                        kintoneAjaxGet("/k/v1/records.json", jsonData, function () {
                            activeApps.push(apps[i]);
                            checkLength();
                        }, checkLength);
                    });
                }
            }
            else {
                G.kintoneError.showGaroonError();
            }
        });
    };

    var setActiveFields = function (itemId, appId, fields, callback, errorHandle) {
        var resetActiveFields = function (data, textStatus, jqXHR) {
            activeFields[itemId] = [];
            userSelectFields[itemId] = [];
            jQuery.each(fields, function (i) {
                var properties = data.properties;
                jQuery.each(properties, function (j) {
                    if (properties[j].code === fields[i]) {
                        activeFields[itemId].push({"field": properties[j].code, "name": properties[j].label, "type": properties[j].type});
                        if (properties[j].type === "USER_SELECT") {
                            userSelectFields[itemId].push({"field": properties[j].code, "name": properties[j].label, "type": properties[j].type});
                        }
                    }
                });
            });
            if (typeof callback === "function") {
                callback();
            }
        };

        var jsonData = "{\"app\": " + appId + "}";
        if (typeof errorHandle === "function") {
            kintoneAjaxGet("/k/v1/form.json", jsonData, resetActiveFields, errorHandle);
        }
        else {
            kintoneAjaxGet("/k/v1/form.json", jsonData, resetActiveFields);
        }
    };

    var setRecordTableTitle = function (itemId) {
        jQuery("#record_list").children().remove();
        if (typeof activeFields[itemId] !== "undefined" && activeFields[itemId].length > 0) {
            var fields = activeFields[itemId];
            var titleHtml = "<tr><th width='5px' nowrap=''></th>";
            jQuery.each(fields, function (i) {
                titleHtml += "<th>" + fields[i].name.escapeHTML() + "</th>";
            });
            titleHtml += "</tr>";
            jQuery("#record_list").append(titleHtml);
        }
    };

    var retrieveRecords = function (itemId, appId, keyWord) {
        showContent("spinner");

        if (typeof activeFields[itemId] === "undefined" || activeFields[itemId].length === 0) {
            jQuery("#record_list").find(".linetwo, .lineone").remove();
            setNavigationBar(0);
            showContent("record");
            return;
        }

        var fields = activeFields[itemId];
        var jsonData = "{\"app\" : " + appId;
        var query = ", \"query\" : \"";
        var firstQuery = true;
        if (keyWord !== null && jQuery.trim(keyWord) !== "") {
            var trimKeyWord = jQuery.trim(keyWord);
            keyWord = "";
            var escapeChars = {"\"": "\\\"", "\\": "\\\\", "\b": "b", "\f": "f", "\n": "n", "\r": "r", "\t": "t"};
            for (var i = 0; i < trimKeyWord.length; i++) {
                if (typeof escapeChars[trimKeyWord.charAt(i)] === "string") {
                    keyWord += "\\\\" + escapeChars[trimKeyWord.charAt(i)];
                }
                else {
                    keyWord += trimKeyWord.charAt(i);
                }
            }

            jQuery.each(fields, function (i) {
                if (fields[i].type === "SINGLE_LINE_TEXT" ||
                    fields[i].type === "MULTI_LINE_TEXT" ||
                    fields[i].type === "RICH_TEXT" ||
                    fields[i].type === "LINK" ||
                    fields[i].type === "FILE") {
                    if (firstQuery) {
                        query += "( ";
                        query += fields[i].field + " like \\\"" + keyWord + "\\\"";
                    }
                    else {
                        query += " or " + fields[i].field + " like \\\"" + keyWord + "\\\"";
                    }
                    firstQuery = false;
                }
            });

            if (!firstQuery) {
                query += " )";
            }
        }
        var firstUserSelectField = true;
        var hiddenKintoneCodeName  = jQuery("#kintone_user_code_name");
        if (hiddenKintoneCodeName.val().trim() !== "") {
            if(typeof userSelectFields[itemId] !== 'undefined' && userSelectFields[itemId].length > 0) {
                if (!firstQuery) {
                    query += " and ( ";
                }
                else {
                    query += " ( ";
                }

                var userFieldsCodes = userSelectFields[itemId];
                jQuery.each(userFieldsCodes, function (i) {
                    if (firstUserSelectField) {
                        query += userFieldsCodes[i].field + " in ( \\\"" + hiddenKintoneCodeName.val() + "\\\" )";
                    }
                    else {
                        query += " or " + userFieldsCodes[i].field + " in ( \\\"" + hiddenKintoneCodeName.val() + "\\\" )";
                    }
                    firstUserSelectField = false;

                });
                query += " ) ";
            }
        }

        query += " limit " + (parseInt(resources["naviNum"], 10) + 1) + " offset " + navigationPosition + "\"";
        jsonData += query;

        jQuery.each(fields, function (i) {
            jsonData += ", \"fields[" + i + "]\" : \"" + fields[i].field + "\"";
        });
        jsonData += ", \"fields[" + fields.length + "]\" : \"$id\"}";

        kintoneAjaxGet("/k/v1/records.json", jsonData, function (data, textStatus, jqXHR) {
            jQuery("#record_list").find(".linetwo, .lineone").remove();
            var removedCount = 0;
            jQuery.each(data.records, function (i) {
                var record = data.records[i];
                if (typeof record["$id"] === "undefined") {
                    removedCount++;
                    return;
                }

                if ((parseInt(resources["naviNum"], 10)) === i) {
                    return;
                }
                var recordId = record["$id"].value;
                var trClass = (i % 2 === 0) ? "linetwo" : "lineone";
                var recordHtml = "<tr class='" + trClass + "'>";
                recordHtml += "<td><input type='radio' value='" + recordId + "' id='radio_" + recordId + "' name='record_radio'></td>";
                recordHtml += "<td><label onmouseout=\"this.style.color=''\" onmouseover=\"this.style.color='#ff0000'\" for='radio_" + recordId + "'>" + constructRecordValue(fields[0].type, fields[0].field, record, false) + "</label></td>";
                for (var j = 1; j < fields.length; j++) {
                    recordHtml += "<td>" + constructRecordValue(fields[j].type, fields[j].field, record, false) + "</td>";
                }
                recordHtml += "</tr>";
                jQuery("#record_list").append(recordHtml);
            });
            setNavigationBar(data.records.length - removedCount);
            showContent("record");
        });
    };

    var changeAppList = function (element) {
        if (selectedAppId !== jQuery(element).find("input").val()) {
            showContent("spinner");
            selectedAppId = jQuery(element).find("input").val();
            jQuery("#app_list_select").find("dt").children("a").children("span:first-child").html(jQuery(element).find("span").html());
            setActiveFields(currentItemId, selectedAppId, fieldsList[selectedAppId], function () {
                setRecordTableTitle(currentItemId);
                jQuery("#kintone_user_code_name").val("");
                jQuery("#keyword_kintone_search_key").val("");
                jQuery("#keyword_kintone_search_user").val("");
                setStatusUserSearchInput(currentItemId);
                G.pageNavigation("top");
            });
        }
    };

    G.searchRecord = function () {
        G.pageNavigation("top");
    };

    G.pageNavigation = function (navi) {
        switch (navi) {
            case "top":
                navigationPosition = 0;
                break;
            case "prev":
                navigationPosition = navigationPosition - parseInt(resources["naviNum"], 10);
                break;
            case "next":
                navigationPosition = navigationPosition + parseInt(resources["naviNum"], 10);
                break;
            default :
                navigationPosition = 0;
        }

        if (navigationPosition < 0) {
            navigationPosition = 0;
        }
        retrieveRecords(currentItemId, selectedAppId, jQuery("#keyword_kintone_search_key").val());
    };

    var setStatusUserSearchInput = function (itemId) {
        var $_keyword_kintone_search_user = jQuery("#keyword_kintone_search_user");
        if (typeof userSelectFields[itemId] === 'undefined' || userSelectFields[itemId].length === 0) {
            $_keyword_kintone_search_user.addClass("disable_style_grn");
            $_keyword_kintone_search_user.prop("disabled", true);
        }
        else {
            $_keyword_kintone_search_user.removeClass("disable_style_grn");
            $_keyword_kintone_search_user.prop("disabled", false);
        }
    };

    var setNavigationBar = function (cnt) {
        if (0 < navigationPosition) {
            jQuery("#top_page_on").show();
            jQuery("#prev_page_on").show();
            jQuery("#top_page_off").hide();
            jQuery("#prev_page_off").hide();
            if (cnt === 0) {
                jQuery("#start_num").html(navigationPosition);
            }
            else {
                jQuery("#start_num").html(navigationPosition + 1);
            }
        }
        else {
            jQuery("#top_page_on").hide();
            jQuery("#prev_page_on").hide();
            jQuery("#top_page_off").show();
            jQuery("#prev_page_off").show();
            if (cnt === 0) {
                jQuery("#start_num").html(0);
            }
            else {
                jQuery("#start_num").html(1);
            }
        }

        if (cnt > parseInt(resources["naviNum"], 10)) {
            jQuery("#next_page_on").show();
            jQuery("#next_page_off").hide();
            jQuery("#end_num").html(navigationPosition + parseInt(resources["naviNum"], 10));
        }
        else {
            jQuery("#next_page_on").hide();
            jQuery("#next_page_off").show();
            jQuery("#end_num").html(navigationPosition + cnt);
        }
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
                jQuery.each(value, function (i) {
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
                jQuery.each(value, function (i) {
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
            returnValue = returnValue.escapeHTML();
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

    jQuery(document).click(function (e) {
        var filterObj = jQuery("#app_list_select").children("dl");
        var pullDownObj = filterObj.find("div.pulldown_menu_grn");

        var isExist = function () {
            return filterObj.length !== 0 && pullDownObj.length !== 0;
        };

        var isOpenedPullDown = function () {
            return pullDownObj.is(":visible");
        };

        var isClickOther = function (e) {
            return filterObj.has(e.target).length === 0;
        };

        if (isExist() && isOpenedPullDown() && isClickOther(e)) {
            grn.component.pulldown_menu.pulldown_menu.closePullDownMenu(filterObj.find("dt"), pullDownObj);
        }
    });

    G.addRelation = function () {
        var recordId = jQuery("#record_list").find("input:radio[name='record_radio']:checked").val();
        if (typeof recordId !== "undefined") {
            G.getRecordForModify(currentItemId.substr(5), selectedAppId, recordId, []);
            G.closeDialog("kintone_dialog");
        }
    };

    G.deleteRelation = function (itemId) {
        jQuery("#td_kintone_" + itemId).html("<div class='mTop7 mBottom7 mLeft5'><a class='icon_add_grn' href='javascript:void(0);' onclick=\"grn.page.schedule.kintoneRelation.showDialog('" + itemId + "');\">" + resources["add"] + "</a></div>");
        jQuery("#app_" + itemId).val("");
        jQuery("#record_" + itemId).val("");
    };

    G.getRecordForModify = function (itemId, appId, recordId, fieldCodes) {
        var getRecord = function () {
            var jsonData = "{ \"app\" : " + appId + ", \"id\" : " + recordId + "}";

            kintoneAjaxGet("/k/v1/record.json", jsonData, function (data, textStatus, jqXHR) {
                if (typeof activeFields["item_" + itemId] === "undefined" || activeFields["item_" + itemId].length === 0) {
                    G.deleteRelation("item_" + itemId);
                    return;
                }

                var recordHtml = "<table class='table_grn form_table_relation_grn'>";
                var fields = activeFields["item_" + itemId];
                recordHtml += "<tr><th class='nowrap-grn'>" + fields[0].name.escapeHTML() + "</th><td class='label_separator_grn'>:</td>";
                recordHtml += "<td><a target='_blank' href='/k/" + appId + "/show#record=" + recordId + "'>" + constructRecordValue(fields[0].type, fields[0].field, data.record, true) + "</a></td></tr>";
                for (var i = 1; i < fields.length; i++) {
                    recordHtml += "<tr><th class='nowrap-grn'>" + fields[i].name.escapeHTML() + "</th><td class='label_separator_grn'>:</td><td>" + constructRecordValue(fields[i].type, fields[i].field, data.record, true) + "</td></tr>";
                }
                recordHtml += "</table><div class='mTop7 mBottom7 mLeft5'><span class='mRight15'><a class='icon_edit_grn' href='javascript:void(0);' onclick=\"grn.page.schedule.kintoneRelation.showDialog('item_" + itemId + "', '" + appId + "');\">" + resources["edit"] + "</a></span>";
                recordHtml += "<a class='icon-delete-grn' href='javascript:void(0);' onclick=\"grn.page.schedule.kintoneRelation.deleteRelation('item_" + itemId + "');\">" + resources["delete"] + "</a></div>";
                jQuery("#td_kintone_item_" + itemId).html(recordHtml);
                jQuery("#record_item_" + itemId).val(recordId);
                jQuery("#app_item_" + itemId).val(appId);
            }, function (jqXHR) {
                failHandle(jqXHR, "GAIA_RE01");
            });
        };

        var failHandle = function (jqXHR, errorCode) {
            if (typeof jqXHR.responseJSON !== "undefined" && typeof jqXHR.responseJSON.code !== "undefined" && jqXHR.responseJSON.code === errorCode) {
                G.deleteRelation("item_" + itemId);
            }
            else {
                jQuery("#td_kintone_item_" + itemId).html("<div class='text_color_sub2_grn'>" + resources.accessError + "</div>");
                jQuery("#record_item_" + itemId).val(recordId);
                jQuery("#app_item_" + itemId).val(appId);
            }
        };

        jQuery("#td_kintone_item_" + itemId).html("<img border='0' src='" + resources.spinnerImage + "'>");
        if (typeof activeFields["item_" + itemId] === "undefined") {
            setActiveFields("item_" + itemId, appId, fieldCodes, getRecord, function (jqXHR) {
                failHandle(jqXHR, "GAIA_AP01");
            });
        }
        else {
            getRecord();
        }
    };

    G.getRecordForView = function (itemId, appId, recordId, fieldCodes) {
        var showRecord = function () {
            var jsonData = "{ \"app\" : " + appId + ", \"id\" : " + recordId + "}";

            kintoneAjaxGet("/k/v1/record.json", jsonData, function (data, textStatus, jqXHR) {
                if (typeof activeFields["item_" + itemId] === "undefined" || activeFields["item_" + itemId].length === 0) {
                    jQuery("#td_kintone_item_" + itemId).html("");
                    return;
                }

                var recordHtml = "<table class='table_grn view_table_relation_grn'>";
                var fields = activeFields["item_" + itemId];
                recordHtml += "<tr><th width='1px'>" + fields[0].name.escapeHTML() + "</th><td width='1px' class='label_separator_grn'>:</td>";
                recordHtml += "<td><a target='_blank' href='/k/" + appId + "/show#record=" + recordId + "'>" + constructRecordValue(fields[0].type, fields[0].field, data.record, true) + "</a></td></tr>";
                for (var i = 1; i < fields.length; i++) {
                    recordHtml += "<tr><th width='1px'>" + fields[i].name.escapeHTML() + "</th><td width='1px' class='label_separator_grn'>:</td><td>" + constructRecordValue(fields[i].type, fields[i].field, data.record, true) + "</td></tr>";
                }
                recordHtml += "</table>";
                jQuery("#td_kintone_item_" + itemId).html(recordHtml);
            }, function (jqXHR) {
                failHandle(jqXHR, "GAIA_RE01");
            });
        };

        var failHandle = function (jqXHR, errorCode) {
            if (typeof jqXHR.responseJSON !== "undefined" && typeof jqXHR.responseJSON.code !== "undefined" && jqXHR.responseJSON.code === errorCode) {
                jQuery("#td_kintone_item_" + itemId).html("");
            }
            else {
                jQuery("#td_kintone_item_" + itemId).html("<div class='text_color_sub2_grn'>" + resources.accessError + "</div>");
            }
        };

        jQuery("#td_kintone_item_" + itemId).html("<img border='0' src='" + resources.spinnerImage + "'>");
        if (typeof activeFields["item_" + itemId] === "undefined") {
            setActiveFields("item_" + itemId, appId, fieldCodes, showRecord, function (jqXHR) {
                failHandle(jqXHR, "GAIA_AP01");
            });
        }
        else {
            showRecord();
        }
    };

    var kintoneAjaxGet = function (targetUrl, jsonData, successCallback, failCallback) {
        jQuery.ajax({
            url: targetUrl,
            data: JSON.parse(jsonData),
            dataType: "json",
            type: "GET"
        }).done(function(data, status, xhr){
            if (typeof successCallback === "function") {
                successCallback(data, status, xhr);
            }
        }).fail(function(jqXHR, textStatus, errorThrown){
            if (typeof failCallback === "function") {
                failCallback(jqXHR, textStatus, errorThrown);
            }
            else {
                G.kintoneError.handle(jqXHR, textStatus, errorThrown);
            }
        });
    };

    var showContent = function (key) {
        jQuery("[id^=kintone_content_]").hide();
        jQuery("#kintone_content_" + key).show();

        jQuery("#active_button").hide();
        jQuery("#inactive_button").show();
        if ("record" === key) {
            jQuery("#active_button").show();
            jQuery("#inactive_button").hide();
        }
    };

    var adjustDialog = function (dialogId) {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        var dialog = jQuery("#" + dialogId);
        dialog.css({"left": (GRN_Window.getWidth() / 2) - (dialog.outerWidth() / 2), "top": (GRN_Window.getHeight() / 2) - (dialog.outerHeight() / 2) + scrollTop});
    };

    var adjustOverlay = function () {
        var b = document.body;
        jQuery("#kintone_overlay").outerWidth(Math.max(b.clientWidth, b.scrollWidth));
        jQuery("#kintone_overlay").outerHeight(Math.max(b.clientHeight, b.scrollHeight));
    };

    jQuery(window).resize(function () {
        if (jQuery("#kintone_dialog").is(":visible")) {
            adjustOverlay();
            adjustDialog("kintone_dialog");
        }

        if (jQuery("#menu_change_dialog").is(":visible")) {
            adjustOverlay();
            adjustDialog("menu_change_dialog");
        }
    });

    jQuery(window).scroll(function () {
        if (jQuery("#kintone_dialog").is(":visible")) {
            adjustDialog("kintone_dialog");
        }

        if (jQuery("#menu_change_dialog").is(":visible")) {
            adjustDialog("menu_change_dialog");
        }
    });

    G.kintoneError = {
        resources: {"warnImage": "", "error": "Error", "cause": "Cause", "countermeasure": "Countermeasure"},
        errorMsg: null,

        handle: function (jqXHR, textStatus, errorThrown) {
            var fn = G.kintoneError;
            if (typeof jqXHR.responseJSON !== "undefined") {
                var json = jqXHR.responseJSON;
                if (typeof json.code !== "undefined" && typeof json.id !== "undefined" && typeof json.message !== "undefined") {
                    if (json.code === "GAIA_IL26") {
                        showContent("spinner");
                        jQuery("#record_list").find(".linetwo, .lineone").remove();
                        setNavigationBar(0);
                        showContent("record");
                    }
                    else {
                        fn.showGaroonError(json.message);
                    }
                }
                else {
                    fn.showGaroonError();
                }
            }
            else {
                fn.showGaroonError();
            }
        },

        showGaroonError: function (kintoneErrorMessage) {
            var fn = G.kintoneError;
            var msg = "<div><img border='0' src='" + fn.resources.warnImage + "'></div>";
            msg += "<div class='bold'>" + fn.resources.error + " (" + fn.errorMsg.code + ")</div><div>" + fn.errorMsg.error + "</div><br>";
            msg += "<div class='bold'>" + fn.resources.cause + "</div><div>" + fn.errorMsg.cause + "</div>";
            if (typeof kintoneErrorMessage !== "undefined") {
                msg += "<div>" + kintoneErrorMessage.escapeHTML() + "</div><br>";
            }
            else {
                msg += "<br>";
            }
            msg += "<div class='bold'>" + fn.resources.countermeasure + "</div><div>" + fn.errorMsg.countermeasure + "</div>";
            jQuery("#kintone_content_error").html(msg);
            showContent("error");
        },

        setResource: function (key, value) {
            G.kintoneError.resources[key] = value;
        },

        setErrorMsg: function (errorMsg) {
            G.kintoneError.errorMsg = errorMsg;
        }
    };

    G.isAllMenuItem = function (itemId) {
        if (systemInfo != null && typeof systemInfo[itemId] !== "undefined") {
            var value = systemInfo[itemId];
            if (value["allMenu"]) {
                return true;
            }
        }
        return false;
    };

    jQuery(document).ready(function() {
        jQuery('#keyword_kintone_search_user').keyup(function (e) {
            if (e.keyCode === 13) {
                G.searchRecord();
            }
        });
        // Handle Escape Key Button
        jQuery(document).keyup(function(e) {
            if (GRN_Event.keyCode(e) == 27) {
                G.closeDialog("kintone_dialog");
            }
        });

        // object picker from user
        var memberPicker = new grn.component.schedule.kintone_relation_user_picker({
                triggerClickElementID : "#search-kintone-submit-button"
            }
        );
        memberPicker.init();
    });
})();
