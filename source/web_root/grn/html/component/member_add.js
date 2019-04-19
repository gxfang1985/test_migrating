(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.member_add")) {
        return;
    }
    grn.base.namespace("grn.component.member_add");
    var member_add = grn.component.member_add;
    var instances = {};
    /**
     *
     * @type {number}
     * @const
     */
    var MAX_MEMBER_LENGTH = 1000;
    var default_options = {
        memberListOptions: {},
        candidateListOptions: {},
        categorySelectUrl: "",
        searchBoxOptions: {
            "is_use":           true,
            "id_searchbox":     "",
            "url":              "",
            "append_post_data": {}
        },
        pulldownPartsOptions: {
            "is_use": true
        },
        includeOrg: "",
        accessPlugin: "",
        accessPluginEncoded: "",
        pluginSessionName: "",
        pluginDataName: "",
        isCalendar: false,
        isPopup: false,
        showGroupRole: true,
        addOrgWithUsers: false,
        showOmitted: false,
        useCandidateSupportParts: true,
        operatorAddName: false,
        selectAllUsersInSearch: false
    };

    /**
     *
     * @param name
     * @param form_name
     * @param member_list_names
     * @param candidate_list_Name
     * @param options
     * @constructor
     */
    member_add.MemberAdd = function (name, form_name, member_list_names, candidate_list_Name, options) {
        if (grn.component.pubsub) {
            grn.component.pubsub.installTo(this);
        }
        options = $.extend({}, default_options, options);
        options.memberListOptions["isCalendar"] = options.isCalendar;
        options.candidateListOptions["isCalendar"] = options.isCalendar;
        if (options.isPopup) {
            options.memberListOptions["isCurrentScreen"] = false;
            options.candidateListOptions["isCurrentScreen"] = true;
        }
        options.memberListOptions["memberAddName"] = name;
        options.candidateListOptions["memberAddName"] = name;

        this.name = name;
        this.memberListNames = member_list_names;
        this.memberLists = {};
        this.memberListNames.forEach(function(list_name) {
            var member_list_options = $.extend({}, {isCandidateList: false}, options.memberListOptions);
            this.memberLists[list_name] = new grn.component.member_select_list.MemberSelectList(list_name, member_list_options);
        }.bind(this));

        this.candidateListName = candidate_list_Name;
        this.candidateList = new grn.component.member_select_list.MemberSelectList(
            this.candidateListName,
            $.extend({}, {isCandidateList: true}, options.candidateListOptions)
        );
        this.formName = form_name;

        this.userAddSelectByGroupURL = options.categorySelectUrl;

        this.searchBoxOptions = options.searchBoxOptions;
        this.pulldownPartsOptions = options.pulldownPartsOptions;

        this.appId = options.appId;
        this.includeOrg = options.includeOrg;
        this.accessPlugin = options.accessPlugin;
        this.accessPluginEncoded = options.accessPluginEncoded;
        this.pluginSessionName = options.pluginSessionName;
        this.pluginDataName = options.pluginDataName;
        this.isCalendar = options.isCalendar;
        this.isPopup = options.isPopup;
        this.showGroupRole = options.showGroupRole;
        this.addOrgWithUsers = options.addOrgWithUsers;
        this.showOmitted = options.showOmitted;
        this.operatorAddName = options.operatorAddName;
        this.selectAllUsersInSearch = options.selectAllUsersInSearch;
        this.isSearching = false;
        this.ajaxUrl = options.ajax_url;

        var self = this;
        $(function () {
            self.init(name);
        });
        instances[name] = this;
    };

    /**
     *
     * @param {array} names
     */
    member_add.prepareSubmit = function (names) {
        var instance;
        var index;
        for (index = 0; index < names.length; ++index) {
            instance = this.get_instance(names[index]);
            if (instance) {
                instance.prepareSubmit();
            }
        }
    };

    /**
     *
     * @param {string} name
     * @return MemberAdd
     */
    member_add.get_instance = function (name) {
        return instances[name];
    };

    member_add.MemberAdd.prototype = {
        init: function () {
            var self = this;
            this.memberListNames.forEach(function(list_name) {
                var member_list = self.memberLists[list_name];
                grn.component.button("#btn_add_" + list_name).on("click", self.addMembers.bind(self, member_list, self.candidateList));
                grn.component.button("#btn_rmv_" + list_name).on("click", self.removeMembers.bind(self, member_list));

                $("#" + list_name + "_order_top").on("click", member_list.orderTop.bind(member_list));
                $("#" + list_name + "_order_up").on("click", member_list.orderUp.bind(member_list));
                $("#" + list_name + "_order_down").on("click", member_list.orderDown.bind(member_list));
                $("#" + list_name + "_order_bottom").on("click", member_list.orderBottom.bind(member_list));
            });

            if(this.pulldownPartsOptions.is_use && !this.isPopup){
                var $pulldown = $("#" + self.candidateListName + "_pulldown");

                var pulldown_options = {
                    onSelect: function (pulldown_item) {
                        self.changeCategory(pulldown_item);
                    },
                    autoClose: true
                };
                grn.component.pulldown_menu.pulldown_menu.initWithOptions($pulldown, pulldown_options);
                var $selected = $pulldown.find("li[data-selected]");
                if ($selected.length) {
                    $selected.click();
                } else {
                    $($pulldown.find("li"))[0].click();
                }
            }

            if (this.searchBoxOptions.is_use && !this.isPopup) {
                $("#keyword_" + self.searchBoxOptions.id_searchbox).on("keypress", function (event) {
                    if (event.keyCode === 13) {
                        self.search();
                    }
                    return event.keyCode !== 13;
                });

                $("#searchbox-submit-" + self.searchBoxOptions.id_searchbox).on("click", function () {
                    self.search();
                });
            }

        },

        /**
         *
         * @param {HTMLElement} member
         * @param {grn.component.member_select_list.MemberSelectList}from
         * @param {grn.component.member_select_list.MemberSelectList}to
         * @returns {HTMLElement}
         */
        modifyMemberDOM: function (member, from, to) {
            var $member = $(member);
            var new_id = $member.attr("id").replace(from.shortListName, to.shortListName)
                .replace(/-(\d)*$/, "");

            return $member.clone(false).attr({
                "id": new_id,
                "class": "selectlist_" + to.shortListName + " selectlist_selected_grn"
            })[0];
        },

        /**
         * @param {grn.component.member_select_list.MemberSelectList}to
         * @param {grn.component.member_select_list.MemberSelectList}from
         */
        addMembers: function (to, from) {
            var self = this;
            self.addingMembers(to, from).done(function () {
                to.viewSelectAllOrClearAllLink();

                if (self.operatorAddName) {
                    var operator_add = self.getOperatorAddInstance(self.operatorAddName);
                    operator_add.addOperators(self.name);
                }
            });
        },

        /**
         * @param name
         * @return {MemberAdd}
         */
        getOperatorAddInstance: function (name) {
            if (this.isPopup) {
                return window.opener.grn.component.operator_add.get_instance(name);
            }
            return grn.component.operator_add.get_instance(name);
        },

        removeMembers: function (from_list) {
            var remove_member_list = from_list.removeSelectedMembers();
            from_list.viewSelectAllOrClearAllLink();

            if (this.operatorAddName) {
                var operator_add = this.getOperatorAddInstance(this.operatorAddName);
                operator_add.removeOperators(remove_member_list, from_list.shortListName);
                operator_add.operator_add.candidateList.viewSelectAllOrClearAllLink();
                operator_add.operator_add.getFirstMemberSelectList().viewSelectAllOrClearAllLink();
            }
        },

        /**
         * @param {grn.component.member_select_list.MemberSelectList}to
         * @param {grn.component.member_select_list.MemberSelectList}from
         * @return {Promise}
         */
        addingMembers: function (to, from) {
            to.spinnerOn();
            var self = this;
            var from_member_list = from.getSelectedList().toArray();
            var to_member_list_values = to.getValues();
            var to_member_list = to.getList();
            var is_include_omitted = to_member_list_values.indexOf("0") >= 0;
            if (is_include_omitted) {
                to.removeMembers();
            }
            var length = from_member_list.length;
            var list_to_add = [];
            for (var i = 0; i < length; i++) {
                var member = from_member_list[i];
                var value = $(member).attr("data-value").split(":")[0];
                if (this.isPopup && to.isCandidateList) {
                    list_to_add.push(this.modifyMemberDOM(member, from, to));
                    continue;
                }
                var is_omitted = (parseInt(value) === grn.component.member_select_list.OMITTED_ID);
                if (is_omitted) {
                    to.removeMembers();
                    list_to_add.push(this.modifyMemberDOM(member, from, to));
                    break;
                }
                var index = to_member_list_values.indexOf(value);
                if (index < 0) {
                    if (this.addOrgWithUsers && $(member).attr("data-type") == "group") {
                        var users_belong_organization = from.getUsersList();
                        $.each(users_belong_organization, function (key, user) {
                            value = $(user).attr("data-value").split(":")[0];
                            index = to_member_list_values.indexOf(value);
                            if (index < 0) {
                                list_to_add.push(self.modifyMemberDOM(user, from, to));
                            } else {
                                $(to_member_list.get(index)).addClass(to.selectedClassName);
                            }
                        });
                        break;
                    } else {
                        list_to_add.push(this.modifyMemberDOM(member, from, to));
                    }
                } else {
                    $(to_member_list.get(index)).addClass(to.selectedClassName);
                }
            }

            var deferred = $.Deferred();
            if (this.isPopup) {
                this._appendMembersFromPopup(to, list_to_add);
                deferred.resolve();
            } else if (length > MAX_MEMBER_LENGTH) {
                setTimeout(function () {
                    self.appendMembers(to, list_to_add);
                    deferred.resolve();
                }, 100);
            } else {
                this.appendMembers(to, list_to_add);
                deferred.resolve();
            }
            return deferred.promise();
        },

        /**
         *
         * @param {grn.component.member_select_list.MemberSelectList}to
         * @param {jQuery|HTMLElement|Array}list_to_add
         */
        appendMembers: function (to, list_to_add) {
            $("#ul_selectlist_" + to.shortListName).append(list_to_add);
            to.spinnerOff();
        },

        /**
         *
         * @param {grn.component.member_select_list.MemberSelectList}to
         * @param {jQuery|HTMLElement|Array}list_to_add
         * @private
         */
        _appendMembersFromPopup: function (to, list_to_add) {
            var parent = window.opener.jQuery("#ul_selectlist_" + to.shortListName);

            if (to.isCandidateList) {
                to.removeMembers();

                var pulldown_menu = window.opener.grn.component.pulldown_menu.pulldown_menu;

                var $pulldown = window.opener.jQuery("#" + to.shortListName + "_pulldown");
                var pulldownItemList = $pulldown.find(".pulldown_menu_grn > ul");

                pulldownItemList.find("li[data-value=popup_user_select]").remove();

                var context = window.opener.grn.component.member_add.get_instance(to.memberAddName);
                pulldown_menu.addItem($pulldown, grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-806"), "popup_user_select", {
                    callback: function (value) {
                        this.changeCategory(value);
                    }.bind(context),
                    select: true
                });
            }

            if (grn.browser.msie) {
                // Avoid: SCRIPT5022 HierarchyRequestError
                var elements = parent.html();
                list_to_add.forEach(function (val) {
                    elements += val.outerHTML;
                });
                parent.html(elements);
            } else {
                parent.append(list_to_add);
            }
            to.spinnerOff();
        },

        /**
         *
         * @param {HTMLElement} category
         */
        changeCategory: function (category) {
            var $pull_down = $("#" + this.candidateListName + "_pulldown");
            grn.component.pulldown_menu.pulldown_menu.removeItemByValue($pull_down, "search");
            var post_data = {
                gid: $(category).attr("data-value"),
                cid: this.candidateListName,
                app_id: this.appId,
                include_org: this.includeOrg,
                access_plugin: this.accessPluginEncoded,
                is_json_required: true,
                show_group_role: this.showGroupRole,
                show_omitted: this.showOmitted
            };
            this.candidateList.spinnerOn();
            var ajaxRequest = new grn.component.ajax.request(
                {
                    url: this.userAddSelectByGroupURL,
                    method: "post",
                    dataType: "json",
                    data: post_data
                });

            ajaxRequest.send().done(function (json_obj) {
                this.candidateList.addMembers(json_obj["users_info"]);
                this.candidateList.viewSelectAllLink();
                this.candidateList.spinnerOff();
                if (grn.component.pubsub) {
                    this.trigger("candidateListChange", json_obj["users_info"]);
                }
            }.bind(this));
        },

        search: function () {
            var keyword = $("#keyword_" + this.searchBoxOptions.id_searchbox).val();
            var search_box = grn.component.search_box.get_instance(this.searchBoxOptions.id_searchbox);
            if (search_box.firstFlag) {
                keyword = '';
            }

            var post_data = {
                "keyword": keyword,
                "search_login_name": "0"
            };

            if (this.isSearching) {
                return;
            }

            if (this.appId) {
                post_data["app_id"] = this.appId;
            }
            if (this.accessPlugin) {
                post_data["plugin_session_name"] = this.pluginSessionName;
                post_data["plugin_data_name"] = this.pluginDataName;
            }

            if (this.searchBoxOptions.append_post_data) {
                $.each(this.searchBoxOptions.append_post_data, function (key, value) {
                    post_data[key] = value;
                })
            }

            var ajaxRequest = new grn.component.ajax.request(
                {
                    url: grn.component.url.page(this.searchBoxOptions.url),
                    method: "post",
                    dataType: "json",
                    data: post_data,
                    grnLoadingIndicator: function (option) {
                        this.isSearching = (option === 'show');
                        if (this.isSearching) {
                            this.candidateList.spinnerOn();
                            return;
                        }

                        this.candidateList.$select_box.focus();
                        this.candidateList.spinnerOff();
                        this.candidateList.viewSelectAllLink();
                    }.bind(this)
                });
            ajaxRequest.send().done(function (json_obj) {
                this.candidateList.addMembers(json_obj["members_info"], this.selectAllUsersInSearch);
                var pulldown_menu = grn.component.pulldown_menu.pulldown_menu;
                var $pulldown = $("#" + this.candidateListName + "_pulldown");
                var is_has_search_result_item = pulldown_menu.isItemHasValue($pulldown, "search");
                if (!is_has_search_result_item) {
                    pulldown_menu.addItem($pulldown, grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-807"), "search", {
                        select: true
                    });
                }
                pulldown_menu.setSelectItemToHead($pulldown.find('dt'), this);
            }.bind(this));
        },

        prepareSubmit: function () {
            var self = this;
            var form = document.forms[this.formName];
            this.memberListNames.forEach(function(list_name) {
                var src = self.memberLists[list_name].getList().toArray();
                var selected_users = form.elements['selected_users_' + list_name];
                var selected_groups = form.elements['selected_groups_' + list_name];
                var selected_users_value = [];
                var selected_groups_value = [];
                var member_types = grn.component.member_select_list.MEMBER_TYPES;
                src.forEach(function (option) {
                    var value = $(option).attr("data-value");
                    var type = $(option).attr("data-type");
                    if (!value) {
                        return;
                    }
                    var co_value = value.split(':');
                    if (co_value.length <= 0) {
                        return;
                    }
                    switch (type) {
                        case member_types.USER:
                        case member_types.OMITTED:
                            if (isFinite(co_value[0]) || co_value[0].match(/g[0-9]+/)) {
                                selected_users_value.push(co_value[0]);
                            }

                            if (co_value.length > 1) {
                                selected_groups_value.push(co_value[1]);
                            }
                            break;
                        case member_types.GROUP:
                            selected_users_value.push(co_value[0]);
                            selected_groups_value.push(co_value[0].substr(1));
                            break;
                        case member_types.ROLE:
                        case member_types.DYNAMIC_ROLE:
                            selected_users_value.push(co_value[0]);
                    }
                });
                selected_groups.value = selected_groups_value.join(":");
                selected_users.value = selected_users_value.join(":");
            });
        },
        /**
         * @return {grn.component.member_select_list.MemberSelectList}
         */
        getFirstMemberSelectList: function () {
            var list_name = this.memberListNames[0];
            return this.memberLists[list_name];
        },

        /**
         * @param {grn.component.member_select_list.MemberSelectList}from
         */
        updateTargetList: function (from) {
            var from_member_list = from.getSelectedList().toArray();
            var length = from_member_list.length;
            var targets_arr = [];
            for (var i = 0; i < length; i++) {
                var member = from_member_list[i];
                targets_arr.push($(member).attr("data-value").split(":")[0])
            }

            var targets_id = targets_arr.join(":");
            var post_data = {
                selected_targets: targets_id,
                app_id: this.appId
            };

            var ajax_request = new grn.component.ajax.request(
                {
                    grnUrl: this.ajaxUrl,
                    method: "post",
                    dataType: "json",
                    data: post_data
                });

            ajax_request.send().done(function (json_obj) {
                var opener = window.opener;
                opener.jQuery("#" + this.name).html(json_obj.content);
                window.close();
            }.bind(this));
        },

        /**
         * Get members list in component
         * @param is_candidate is candidate or not
         * @returns {Array}
         */
        getMembers: function (is_candidate) {
            var member_list = [];
            var member_list_instance = is_candidate ? this.candidateList : this.getFirstMemberSelectList();
            if (member_list_instance.$ul_list) {
                var $members_dom_element = member_list_instance.$ul_list.find("li");
                $members_dom_element.each(function () {
                    var member = {};
                    var value = $(this).attr("data-value").split(":");
                    member["id"] = value[0];
                    if (value[1]) {
                        member["group_id"] = value[1];
                    }
                    if ($(this).attr("data-code")) {
                        member["foreignKey"] = $(this).attr("data-code");
                    }
                    member["displayName"] = $(this).attr("data-name");
                    member["type"] = $(this).attr("data-type");
                    member_list.push(member);
                });
            }
            return member_list;
        }
    };
})(jQuery);
