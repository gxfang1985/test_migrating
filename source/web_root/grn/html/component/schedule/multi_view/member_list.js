(function () {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.member_list");

    var COLOR_MAX_ID = 19;

    grn.component.schedule.multi_view.member_list = function() {
        this._resolved = false; // determines whether the details data of member list is already loaded
        this._members = [];
        this._login_user = grn.data.login; // this should be set in the external template file
    };

    /**
     * @alias grn.component.schedule.multi_view.member_list
     * @type {grn.component.schedule.multi_view.member_list}
     */
    var G = grn.component.schedule.multi_view.member_list;

    var MEMBER_TYPE = {
        USER: "user",
        ORGANIZATION: "org",
        FACILITY: "facility"
    };
    G.MEMBER_TYPE = MEMBER_TYPE;

    G.isValidMemberType = function(member_type) {
        return MEMBER_TYPE.indexOf(member_type) !== -1;
    };

    G.createFromArray = function (members_array, resolved) {
        var list = new G();

        if (!Array.isArray(members_array)) {
            return list;
        }

        members_array.forEach(function (member) {
            var new_member = new Member(member.id, member.type, member.name, member.selected, member.colorId);

            if (member.url) {
                new_member.url = member.url;
            }

            if(member.user_status){
                new_member.user_status = member.user_status;
            }

            list.add(new_member);
        });

        if (resolved) {
            list.resolved = true;
        }

        return list;
    };

    G.prototype.getMembers = function() {
        return this._members;
    };

    G.prototype.add = function(member) {

        if (this.indexOf(member) !== -1) {
            return false;
        }

        if (!this._isValidColorId(member.colorId)) {
            member.colorId = this._colorIdForNewMember(member);
        }

        this._members.push(member);

        return member;
    };

    G.prototype.remove = function(member) {
        var index = this.indexOf(member);

        if (index === -1) {
            return;
        }

        this._members.splice(index, 1);
    };

    G.prototype.clear = function() {
        this._members = [];
    };

    G.prototype.getById = function(id, type) {
        var index = this.indexOf(new Member(id, type));

        if (index === -1) {
            return;
        }

        return this._members[index];
    };

    G.prototype.indexOf = function(member) {

        for(var i=0; i < this._members.length; i++) {

            var member_local = this._members[i];

            if (member.id.toString() === member_local.id.toString() &&
                member.type === member_local.type) {
                return i;
            }
        }

        return -1;
    };

    G.prototype._colorIdForNewMember = function(member) {
        /**
         * Specification:
         * - For logged-in user, color ID is 0.
         * - For others, color ID is repeating from 1 to COLOR_MAX_ID.
         */

        if (this._isLoginUser(member)) {
            return 0;
        }

        var members_count = this._members.length;
        if (members_count === 0) {
            return 1;
        }

        var last_member = this._members[members_count - 1];

        // find the last item excluding the logged-in user

        if (this._isLoginUser(last_member)) {
            if (members_count === 1) {
                return 1;
            } else {
                last_member = this._members[members_count - 2];
            }
        }

        var last_member_color_id = parseInt(last_member.colorId, 10);
        var next_color_id = last_member_color_id + 1;

        if (next_color_id > COLOR_MAX_ID) {
            next_color_id = next_color_id % COLOR_MAX_ID;
        }

        return next_color_id;
    };

    G.prototype._isValidColorId = function(color_id) {
        color_id = color_id || -1;

        return color_id >= 0 && color_id <= COLOR_MAX_ID;
    };

    G.prototype._isLoginUser = function(member) {
        return member.type === MEMBER_TYPE.USER &&
            member.id === this._login_user.id;
    };

    //-------------------------------------------

    function Member(id, type, name, selected, colorId) {
        this.id = id.toString();
        this.type = type;
        this.name = name || "";
        this.selected = typeof selected === "undefined" ? true : selected;
        this.colorId = typeof colorId === "undefined" ? null : colorId;
    }

    G.Member = Member;

})();

