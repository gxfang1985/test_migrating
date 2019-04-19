(function ($) {
    "use strict";
    grn.base.namespace("grn.component.member_list_dialog");
    var member_list_dialog = grn.component.member_list_dialog;
    var instances = {};
    var default_options = {
        dialog_name: "member_list_dialog",
        url: grn.component.url.page("grn/ajax/member_list_dialog"),
        want_page: 1,
        dialogVersion: 2,
        access_plugin_encoded: "",
        app_id: "",
        closeByBackgroundClick: true,
        auto_bind: true
    };

    /**
     * constructor.
     *
     * @param options
     */
    member_list_dialog.MemberListDialog = function (options) {

        this.options = $.extend({}, default_options, options);

        this.resultArea = "#" + this.options.dialog_name + "_result";
        this.spinnerArea = "#" + this.options.dialog_name + "_spinner";
        this.searchword = "#" + this.options.dialog_name + "_searchword";
        this.searchbutton = "#" + this.options.dialog_name + "_searchbutton";
        this.sub_search_key = "#" + this.options.dialog_name + "_sub_search_key";

        this.top_page_number = "#" + this.options.dialog_name + "_top_page_number";
        this.prev_page_number = "#" + this.options.dialog_name + "_prev_page_number";
        this.next_page_number = "#" + this.options.dialog_name + "_next_page_number";
        this.display_mode = "#" + this.options.dialog_name + "_display_mode";
        this.sub_primary_key = "#" + this.options.dialog_name + "_sub_primary_key";
        this.switch_tab_id = "#" + this.options.dialog_name + "_switch_tab_id";
        this.prev_current_page_number = "#" + this.options.dialog_name + "_prev_current_page_number";
        this.prev_switch_tab_id = "#" + this.options.dialog_name + "_prev_switch_tab_id";
        this.prev_search_word = "#" + this.options.dialog_name + "_prev_search_word";

        this._dialog = new grn.component.WindowSimpleDialog({
            asyncURL: this.options.url,
            asyncParams: {
                'dialog_name': this.options.dialog_name,
                'want_page': this.options.want_page,
                'access_plugin_encoded': this.options.access_plugin_encoded,
                'app_id': this.options.app_id
            },
            version: this.options.dialogVersion,
            closeByBackgroundClick: this.options.closeByBackgroundClick
        });
        this._dialog.on("loaded", this._onLoad.bind(this));

        var dialog = this;

        if (this.options.auto_bind) {
            $(document).ready(function () {
                var $members = $(".span-member-dialog");
                dialog.bind_dialog_to_members($members);
            });
        }

        instances[this.options.dialog_name] = dialog;
    };

    /**
     *
     * @param {string} name
     * @return MemberAdd
     */
    member_list_dialog.get_instance = function (name) {
        return instances[name];
    };

    /**
     * @param name
     * @return MemberListDialog
     */
    member_list_dialog.get_dialog = function (name) {
        var dialog = member_list_dialog.get_instance(name);
        if (dialog === undefined) {
            dialog = new member_list_dialog.MemberListDialog(
                {
                    dialog_name: name,
                    url: grn.component.url.page("space/application/discussion/ajax/notification_user_list_dialog"),
                    app_id: "space",
                    auto_bind: false
                }
            )
        }
        return dialog;
    };

    member_list_dialog.MemberListDialog.prototype = {
        showDialog: function (anchor_id) {

            $(this.resultArea).hide();
            $(this.spinnerArea).show();

            this.options.anchor_id = anchor_id;

            this._dialog.options.asyncParams = {
                'dialog_name': this.options.dialog_name,
                'anchor_id': this.options.anchor_id,
                'want_page': this.options.want_page,
                'access_plugin_encoded': this.options.access_plugin_encoded,
                'app_id': this.options.app_id
            };
            this._dialog.openDialog();
        },

        /**
         * @param $members
         */
        bind_dialog_to_members: function ($members) {
            var self = this;
            $members.each(function (i, elem) {
                $(elem).on("click", function () {
                    self.showDialog($(elem).find(".dialog_link").attr("id"));
                });
            });
        },

        /**
         * Bind dialog to member container
         * @param {object} container Member DOM object container (Ex : $('#container'), $('.container'))
         * @param {string} member_selector Member selector (Ex: .span-member-dialog-mention)
         */
        bindDialogToMembersContainer: function (container, member_selector) {
            var self = this;
            container.on("click", member_selector, function () {
                self.showDialog(this.id);
            });
        },

        _onLoad: function () {
            this._$dialog_container = this._dialog.$container;
            this._$dialog_container.find(".js_top_page_on").on("click", this._toTop.bind(this));
            this._$dialog_container.find(".js_prev_page_on").on("click", this._toPrev.bind(this));
            this._$dialog_container.find(".js_next_page_on").on("click", this._toNext.bind(this));

            this._$dialog_container.find(this.searchword).on("keypress", this._keypressSearch.bind(this));
            this._$dialog_container.find(this.searchbutton).on("click", this._search.bind(this));
            this._$dialog_container.find("a.block_grn").on("click", this._searchDisplayMembers.bind(this));

            var switchTabClick = this._switchTabClick.bind(this);
            this._$dialog_container.find("div.navi_viewchange_grn").find('a').each(function(){
                $(this).on("click", switchTabClick);
            });

            this._dialog._$goBackButton.on("click", this._goBack.bind(this));

            this._$dialog_container.find(this.resultArea + " li:odd").addClass("lineone");
            this._$dialog_container.find(this.resultArea + " li:even").addClass("linetwo");
        },

        _toTop: function () {

            var top_page_number = $(this.top_page_number).val();
            this._to(top_page_number);
        },
        _toPrev: function () {

            var prev_page_number = $(this.prev_page_number).val();
            this._to(prev_page_number);
        },
        _toNext: function () {

            var next_page_number = $(this.next_page_number).val();
            this._to(next_page_number);
        },

        /**
         * @param to_page_number
         * @private
         */
        _to: function (to_page_number) {
            var search_word = $(this.searchword).val();
            var sub_primary_key = $(this.sub_primary_key).val();
            var command_type = 'move_page';
            this._movePageTo(to_page_number, search_word, sub_primary_key, command_type);
        },

        _keypressSearch: function (event) {

            if (event.keyCode === 13) {

                this._search();
            }

        },

        _search: function () {

            var search_word = $(this.searchword).val();
            var sub_primary_key = $(this.sub_primary_key).val();
            var command_type = 'search_include_users';
            this._movePageTo(1, search_word, sub_primary_key, command_type);
        },

        /**
         * @param e
         * @private
         */
        _searchDisplayMembers: function (e) {

            var search_word = '';
            var targetElement = window.event ? window.event.srcElement : e.target;
            var sub_primary_key = $(targetElement).find(this.sub_search_key).val();
            if (sub_primary_key == undefined)
            {
                var self = this;
                $(targetElement).parents("a").each(function(){
                    if (sub_primary_key == undefined) {
                        sub_primary_key = $(this).find(self.sub_search_key).val();
                    }
                });
            }
            $(this.switch_tab_id).val('1');
            var command_type = 'search_sub_members';
            this._movePageTo(1, search_word, sub_primary_key, command_type);
        },

        _goBack: function () {

            var search_word = $(this.prev_search_word).val();
            var sub_primary_key = '';
            var command_type = 'go_back';
            var page_number = $(this.prev_current_page_number).val();
            $(this.switch_tab_id).val($(this.prev_switch_tab_id).val());
            this._movePageTo(page_number, search_word, sub_primary_key, command_type);
        },

        /**
         * @param e
         * @private
         */
        _switchTabClick: function (e) {

            var search_word = '';
            var sub_primary_key = $(this.sub_primary_key).val();
            var targetElement = window.event ? window.event.srcElement : e.target;
            $(this.switch_tab_id).val(targetElement.id);
            var command_type = 'switch_tab';
            this._movePageTo(1, search_word, sub_primary_key, command_type);
        },

        /**
         * @param page_number
         * @param search_word
         * @param sub_primary_key
         * @param command_type : 'move_page' 'search_include_users' 'search_sub_members' 'switch_tab' 'go_back'
         * @private
         */
        _movePageTo: function (page_number, search_word, sub_primary_key ,command_type) {

            var display_mode = $(this.display_mode).val();
            var switch_tab_id = $(this.switch_tab_id).val();
            var prev_switch_tab_id = $(this.prev_switch_tab_id).val();
            var prev_search_word = $(this.prev_search_word).val();

            var prev_current_page_number = $(this.prev_current_page_number).val();
            this._dialog.options.asyncParams = {
                'dialog_name': this.options.dialog_name,
                'anchor_id': this.options.anchor_id,
                'want_page': page_number,
                'search_word': search_word,
                'command_type': command_type,
                'display_mode': display_mode,
                'sub_primary_key': sub_primary_key,
                'switch_tab_id': switch_tab_id,
                'prev_switch_tab_id': prev_switch_tab_id,
                'prev_current_page_number': prev_current_page_number,
                'prev_search_word': prev_search_word,
                'access_plugin_encoded': this.options.access_plugin_encoded,
                'app_id': this.options.app_id
            };

            if( this._dialog._isLoading )
            {
                return ;
            }
            $(this.resultArea).hide();
            $(this.spinnerArea).show();

            this._dialog._isLoading = true;
            this._dialog._loadContent();
        }

    };

})(jQuery);