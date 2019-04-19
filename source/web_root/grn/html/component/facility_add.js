(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.facility_add")) {
        return;
    }
    grn.base.namespace("grn.component.facility_add");
    var facility_add = grn.component.facility_add;
    var instances = {};
    var default_options = {
        facilityListOptions: {},
        candidateListOptions: {},
        categorySelectUrl: "",
        searchUrl: "",
        idSearchBox: "",
        initUsingPurpose: "",
        csrfTicket: ""
    };

    function get_full_list_name(list_name) {
        return "selectlist_" + list_name;
    }

    /**
     *
     * @param name
     * @param form_name
     * @param page_name
     * @param facility_list_name
     * @param candidate_list_Name
     * @param options
     * @constructor
     */
    facility_add.FacilityAdd = function (name, form_name, page_name, facility_list_name, candidate_list_Name, options) {
        options = $.extend({}, default_options, options);
        options.facilityListOptions["isCalendar"] = options.isCalendar;
        options.candidateListOptions["isCalendar"] = options.isCalendar;
        options.candidateListOptions["isFacilityCandidate"] = true;
        this.name = name;
        this.facilityListName = facility_list_name;
        this.fullFacilityListName = get_full_list_name(this.facilityListName);
        this.facilityList = new grn.component.member_select_list.MemberSelectList(this.facilityListName, options.facilityListOptions);
        this.candidateListName = candidate_list_Name;
        this.fullCandidateListName = get_full_list_name(this.candidateListName);
        this.candidateList = new grn.component.member_select_list.MemberSelectList(this.candidateListName, options.candidateListOptions);
        this.formName = form_name;
        this.pageName = page_name;

        this.categoryFacilityURL = options.categorySelectUrl;
        this.searchFacilitiesByKeywordURL = options.searchUrl;
        this.idSearchBox = options.idSearchBox;
        this.initUsingPurpose = options.initUsingPurpose;
        this.csrfTicket = options.csrfTicket;
        this.dropdownInstance = "group-select";
        $(function () {
            facility_add.init(name);
        });
        instances[name] = this;
    };

    /**
     *
     * @param {string} name
     * @return FacilityAdd
     */
    facility_add.get_instance = function (name) {
        return instances[name];
    };

    facility_add.FacilityAdd.prototype = {
        modifyFacilityDOM: function (facility) {
            var return_candidate = $(facility);
            var new_id = return_candidate.attr("id").replace(this.fullCandidateListName, this.fullFacilityListName);
            return return_candidate.clone(false).attr({
                "id": new_id,
                "class": this.fullFacilityListName + " selectlist_selected_grn"
            })[0];
        },
        addFacilities: function () {
            this.facilityList.spinnerOn();
            var selected_candidate_list = this.candidateList.getSelectedList().toArray();
            var selected_list_values = $(this.facilityList.getValues()).toArray();
            var selected_list = this.facilityList.getList();
            var length = selected_candidate_list.length;
            var list_to_add = [];
            for (var i = 0; i < length; i++) {
                var facility = selected_candidate_list[i];
                var value = $(facility).attr("data-value");
                var index = selected_list_values.indexOf(value);
                if (index < 0) {
                    list_to_add.push(this.modifyFacilityDOM(facility));
                }else{
                    $(selected_list.get(index)).addClass(this.facilityList.selectedClassName);
                }
            }
            this._appendFacilities(list_to_add);
            this.onOffExtendedItems();
            this.onOffNetmeetingFacilityItems();
            this.onOffUsingPurpose();
        },
        removeSelectedFacilities: function () {
            this.facilityList.removeSelectedFacilities();
            this.onOffExtendedItems();
            this.onOffNetmeetingFacilityItems();
            this.onOffUsingPurpose();
        },
        _appendFacilities: function (list_to_add) {
            $("#ul_" + this.fullFacilityListName).append(list_to_add);
            this.facilityList.spinnerOff();
        },

        changeCategory: function (facility_group_id) {
            GRN_DropdownMenu.getInstance(this.dropdownInstance).removeSearchLabel();
            var post_data = {
                fagid: facility_group_id,
                page_name: this.pageName,
                is_ancestors_path_string: true
            };
            this.candidateList.spinnerOn();
            var ajaxRequest = new grn.component.ajax.request(
                {
                    url: this.categoryFacilityURL,
                    method: "post",
                    dataType: "json",
                    data: post_data
                });
            if (facility_group_id === 0) {
                $("#facility-group").show();
            } else {
                $("#facility-group").hide();
            }
            ajaxRequest.send().done(function (json_obj) {
                this.candidateList.addFacilities(json_obj, true);
                this.candidateList.viewUnSelectAllLink();
                this.candidateList.spinnerOff();
                this.candidateList.updateAncestorsPath();
            }.bind(this));
        },

        search: function () {
            var keyword = $("#keyword_" + this.idSearchBox).val();
            var search_box = grn.component.search_box.get_instance( this.idSearchBox );
            if (search_box.firstFlag){
                keyword = '';
            }
            var post_data = {
                "search_text": keyword,
                "page_name": this.pageName,
                "csrf_ticket": this.csrfTicket,
                "is_ancestors_path_string": true
            };

            var ajaxRequest = new grn.component.ajax.request(
                {
                    url: this.searchFacilitiesByKeywordURL,
                    method: "post",
                    dataType: "json",
                    data: post_data
                });
            $("#facility-group").show();
            this.candidateList.spinnerOn();
            ajaxRequest.send().done(function (json_obj) {
                var search_label = grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-807");
                GRN_DropdownMenu.getInstance(this.dropdownInstance).prependSearchLabel(search_label);
                this.candidateList.addFacilities(json_obj, true);
                this.candidateList.viewUnSelectAllLink();
                this.candidateList.spinnerOff();
                this.candidateList.updateAncestorsPath();
            }.bind(this));
        },

        prepareSubmit: function () {
            var form = document.forms[this.formName];
            var src = this.facilityList.getList().toArray();
            var selected_users = form.elements['selected_users_' + this.facilityListName];
            var selected_users_value = [];

            src.forEach(function (option) {
                var value = $(option).attr("data-value");
                if (!value) {
                    return;
                }
                if (value.length > 0 && isFinite(value)) {
                    selected_users_value.push(value);
                }
            });
            selected_users.value = selected_users_value.join(":");
        },
        onOffExtendedItems: function () {
            var length = this.facilityList.getList().length;
            if (length > 0) {
                $("#extended_items").show();
            } else {
                $("#extended_items").hide();
            }
        },
        onOffNetmeetingFacilityItems: function () {
            if (typeof( netmeeting_facility_items_OnOff ) === 'function') {
                netmeeting_facility_items_OnOff(this.facilityList.getValues());
            }
        },
        onOffUsingPurpose: function () {
            var selectedItems = this.facilityList.getList();
            var usingPurposeElement = $('#using_purpose_element');

            var usingPurpose = $('#using_purpose');
            var numOfApprovalFacilities = 0;
            var minHeightUsingPurpose = 90; // min-height of using purpose 90px
            for (var i = 0; i < selectedItems.length; i++) {
                if ($(selectedItems[i]).attr("data-approval") === '1') {
                    numOfApprovalFacilities += 1;
                    if (this.initUsingPurpose) {
                        if (usingPurpose.is(":hidden")) {
                            usingPurpose.val(this.initUsingPurpose);
                        }
                    }
                    if (usingPurpose.is(":hidden")) {
                        if (typeof grn.page.schedule.add.defaultHeightPurpose !== 'undefined' && usingPurpose.val() !== '') {
                            usingPurpose.css({"height": grn.page.schedule.add.defaultHeightPurpose});
                        }
                        else {
                            usingPurpose.css({"height": minHeightUsingPurpose});
                        }
                    }
                    usingPurposeElement.show();
                    break;
                }
            }

            if (numOfApprovalFacilities === 0) {
                usingPurpose.val('');
                usingPurposeElement.hide();
                var warning = jQuery('#using_purpose_error');
                warning.hide();
            }
        },

        /**
         * Get Facility list in component
         * @param is_candidate is candidate or not
         * @returns {Array}
         */
        getFacilities: function (is_candidate) {
            var facilities_list_instance = is_candidate ? this.candidateList : this.facilityList;
            var $facility_dom_element = facilities_list_instance.$ul_list.find("li");
            var facility_list = [];
            $facility_dom_element.each(function () {
                var facility = {};
                facility["id"] = $(this).attr("data-value");
                facility["approval"] = $(this).attr("data-approval");
                facility["ancestors"] = $(this).attr("data-ancestors");
                facility["code"] = $(this).attr("data-code");
                facility["name"] = $(this).attr("data-name");
                facility_list.push(facility);
            });
            return facility_list;
        }
    };

    facility_add.init = function (name) {
        var instance = facility_add.get_instance(name);
        $("#btn_add_" + instance.candidateListName).on("click", function () {
            instance.addFacilities();
        });
        $("#btn_rmv_" + instance.candidateListName).on("click", function () {
            instance.removeSelectedFacilities();
        });

        $("#" + instance.facilityListName + "_order_up").on("click", function () {
            instance.facilityList.orderUp();
        });
        $("#" + instance.facilityListName + "_order_down").on("click", function () {
            instance.facilityList.orderDown();
        });

        $("#keyword_" + instance.idSearchBox).on("keypress", function (event) {
            if (event.keyCode === 13) {
                instance.search();
            }
            return event.keyCode !== 13;
        });

        $("#searchbox-submit-" + instance.idSearchBox).on("click", function () {
            instance.search();
        });
        instance.onOffNetmeetingFacilityItems();
    };

})(jQuery);