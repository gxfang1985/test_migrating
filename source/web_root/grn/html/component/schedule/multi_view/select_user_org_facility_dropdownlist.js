/* global GRN_OrganizationItem */

(function ($) {
    "use strict";
    grn.base.namespace("grn.component.schedule.multi_view.select_user_org_facility_dropdownlist");

    var default_options = {
        dropdownId: "group-selectmain",
        selectedMemberId: "selected",
        searchResultId: "search",
        resource: {
            facilityGroupTitle: grn.component.i18n.cbMsg("grn.schedule", "title_facilitygroup"),
            selectedMemberTitle: grn.component.i18n.cbMsg("grn.schedule", "virtual_member"),
            searchResultTitle: grn.component.i18n.cbMsg("grn.schedule", "search_member"),
            selectGroup: grn.component.i18n.cbMsg("grn.schedule", "select_group")
        }
    };

    grn.component.schedule.multi_view.select_user_org_facility_dropdownlist = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, default_options, options);
        this._bindEvents();
    };

    /**
     * @alias grn.component.schedule.multi_view.select_user_org_facility_dropdownlist
     * @type {grn.component.schedule.multi_view.select_user_org_facility_dropdownlist}
     */
    var G = grn.component.schedule.multi_view.select_user_org_facility_dropdownlist;

    G.prototype._bindEvents = function () {
        $(document).on("scheduler.select_user_org_facility_dropdownlist.select",
            $.proxy(this._selectUserOrgFacilityDropdownlistOnSelect, this));
    };

    G.prototype._selectUserOrgFacilityDropdownlistOnSelect = function(ev, data) {
        if(data.target.wrap_id === this.options.dropdownId) {
            this.trigger("select", data);
        }
    };

    G.prototype._addSelectedMember = function () {
        if (this._dropdown.organization.getItem(this.options.selectedMemberId)) {
            this._dropdown.updateTitle(this.options.resource.selectedMemberTitle);
        }
        else {
            this._insertTop(this.options.selectedMemberId, this.options.resource.selectedMemberTitle);
            this._removeItem(this.options.searchResultId);
        }
    };

    G.prototype._addSearchResult = function () {
        if (this._dropdown.organization.getItem(this.options.searchResultId)) {
            this._dropdown.updateTitle(this.options.resource.searchResultTitle);
        }
        else {
            this._insertTop(this.options.searchResultId, this.options.resource.searchResultTitle);
            this._removeItem(this.options.selectedMemberId);
        }
    };

    G.prototype._insertTop = function (gid, title) {
        this._dropdown.organization.items.unshift(
            new GRN_OrganizationItem(gid, title, this._dropdown.organization.callback, true));
        this._dropdown.updateTitle(title);
    };

    G.prototype._removeItem = function (gid) {
        var _item = this._dropdown.organization.getItem(gid);
        if (_item) {
            this._dropdown.organization.items.splice(this._dropdown.organization.items.indexOf(_item), 1);
        }
    };

    G.prototype._redraw = function () {
        this._dropdown.organization.removeDivIframeElement();
        this._dropdown.organization.draw();
        this._dropdown.organization.setSize();
    };

    G.prototype._isFacilityGroup = function (group) {
        return group.match && group.match(/^f/) ||
            typeof group === "object" && group.type === "facility";
    };

    G.prototype.setSelectedGroup = function (gid, select_mode) {
        if (typeof select_mode === "undefined") {
            select_mode = "";
        }

        this._dropdown = GRN_DropdownMenu.getInstance(this.options.dropdownId);
        if (gid === this.options.selectedMemberId) {
            this._addSelectedMember();
            this._dropdown.facility.unhighlightGroup();
        }
        else if (gid === this.options.searchResultId) {
            this._addSearchResult();
        }
        else {
            this._removeItem(this.options.selectedMemberId);
            this._removeItem(this.options.searchResultId);
            this._updateTitle(gid, select_mode);
        }
        this._redraw();
    };

    G.prototype._updateTitle = function(gid, select_mode) {
        var group = null;
        var dropdown_title = "";
        var group_node = "";

        if (this._isFacilityGroup(gid)) {
            if (typeof gid === "object") {
                group = gid;
                group_node = this._getFacilityGroup("f" + group.id, select_mode);
                if (group_node && group_node.extra_param !== "") {
                    // case of selecting all-facilities/often-used/recently-facility-group
                    dropdown_title = group_node.name;
                } else {
                    // case of selecting other facility group
                    dropdown_title = this.options.resource.facilityGroupTitle.replace("&&name&&", group.name);
                }
            } else {
                group_node = this._getFacilityGroup(gid, select_mode);
                dropdown_title = group_node ? group_node.name : "";

                if (gid === "f" && !group_node) {
                    // case of selecting all-facilities, but using all-facilities setting is not enabled
                    dropdown_title = this.options.resource.selectGroup;
                }
            }

            var group_node_id = group_node ? group_node.oid : "";
            this._dropdown.facility.highlightGroup(group_node_id);
        } else {
            var valid_gid = "" + parseInt(gid, 10);
            valid_gid = valid_gid === "NaN" ? gid : valid_gid;
            group = this._dropdown.organization.getItem(valid_gid);
            dropdown_title = group ? group.name : "";
        }

        if (dropdown_title) {
            this._dropdown.updateTitle(dropdown_title);
        }
    };

    G.prototype._getFacilityGroup = function (id, select_mode) {
        var group_id = "";

        if (select_mode || id === "f") {
            // case of selecting all-facilities/often-used/recently-facility-group
            // internal data of facility group drop-down list uses "x" prefix in this case
            group_id = id.replace(/^f/, "x");
        } else {
            // case of selecting other facility group
            group_id = id.replace(/^f/, "");
        }

        return this._dropdown.facility.getItem(group_id, select_mode);
    };

})(jQuery);
