(function($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.space.todo.todo_incremental_search")) {
        return;
    }

    grn.base.namespace("grn.page.space.todo.todo_incremental_search");

    var default_options = {
        searchFormId: "id_todo_search_form",
        searchBoxTextId: "id_search_box_text",
        searchBoxIconId: "id_search_box_icon",
        pulldownSelection: "id_pulldown_selection",
        pulldownSelectionView: "id_pulldown_selection_view",
        pulldownCandidate: "id_pulldown_candidate",

        searchSelection: "",
        enabledFts: "",
        searchBits: "",
        url: "space/application/todo/ajax/todo_incremental_search",//The url for receives server data,
        sessionManagerUrl: "space/application/todo/ajax/todo_session_manager",//The url for receives server data,
        urlParams: {
            spid:"",
            tid:"",
            s:"",
            search_text:"",
            todo_root_category_id: ""
        },
        useFts: "",
        link: "space/application/todo/index",
        maxListMemberAdded: 20,
        minLength: 1, // The minimum number of characters a user must type before a search is performed.
        timeDelay: 100,//The delay in milliseconds between when a keystroke occurs and when a search is performed.
        container: "cb-user-picker"
    };

    grn.page.space.todo.todo_incremental_search = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, default_options, options);
        this.init();
    };

    var G = grn.page.space.todo.todo_incremental_search;

    G.prototype = {

        SEARCH_TYPE: {
            FTS: "fts",
            USER: "user"
        },

        SEARCH_BITS: {
            INCREMENT: 1,
            USER_SEARCH: 2,
            USER_SEARCH_ALL: 4
        },

        selectedSearchType: null,

        isAutoComplete: false,

        suggestList: null,

        idSelector : {
            idPrefix : "#"
        },

        cssSelector : {
            classPrefix : ".",
            body : "body",
            elementHide: ":visible",
            inputIncrementalSearch : ".js_input_incremental_search",
            inputIncrementalSelectIcon : ".js_input_incremental_select_icon"
        },

        cssClass : {
            inputIncrementalSearch : "js_input_incremental_search",
            inputIncrementalSelectIcon : "js_input_incremental_select_icon"
        },

        KEY_CODE : {
            BACK_SPACE : 8,
            ENTER : 13,
            SPACE : 32,
            ESC : 27,
            DEL : 46,
            END : 35,
            HOME : 36,
            LEFT : 37,
            UP : 38,
            RIGHT : 39,
            DOWN : 40,
            INSERT : 45,
            PAGE_UP : 33,
            PAGE_DOWN : 34,
            CAPS_LOCK : 20
        },

        KEY_WORD : {
            CLICK : "click",
            KEY_DOWN : "keydown",
            KEY_PRESS : "keypress",
            KEY_UP : "keyup",
            MOUSE_UP : "mouseup",
            SELECTED : "selected",
            CUT : "cut",
            UNDEFINED : "undefined",
            WHICH : "which",
            BUTTON : "button",
            EMPTY : ""
        },

        JS_RESOURCES : {
            TODO_SEARCH_FTS : grn.component.i18n.cbMsg("grn.space.todo", "todo_search_fts"),
            TODO_SEARCH_USER : grn.component.i18n.cbMsg("grn.space.todo", "todo_search_user")
        },

        /**
         * The prepend function. It uses to initialize this component.
         */
        init: function () {
            this.createComponent();
            this.cacheElements();

            if( this.options.enabledFts )
            {
                if( this.options.searchSelection === this.SEARCH_TYPE.USER )
                {
                    this.selectedSearchType = this.SEARCH_TYPE.USER;
                    this.$pulldownSelection.html(this.JS_RESOURCES.TODO_SEARCH_USER + "<span class='mLeft3 pulldownbutton_arrow_down_grn'></span>");
                    this.$pulldownCandidate.html(this.JS_RESOURCES.TODO_SEARCH_FTS);
                }
                else
                {
                    this.selectedSearchType = this.SEARCH_TYPE.FTS;
                }
            }
            else
            {
                this.selectedSearchType = this.SEARCH_TYPE.USER;
                this.$pulldownSelection.html(this.JS_RESOURCES.TODO_SEARCH_USER);
            }

            this.suggestList = new grn.component.user_suggest_list({
                url : this.options.url,
                urlParams : this.options.urlParams
            });

            this.suggestList.init();
            this.bindEvents();
        },

        /**
         * The function created the html of component to document. It will be replaced "options.container" on tpl file.
         */
        createComponent: function () {
            var container = $(this.cssSelector.classPrefix + this.options.container);
            container.find(this.idSelector.idPrefix + this.options.searchBoxTextId).addClass(this.cssClass.inputIncrementalSearch);
            container.find(this.idSelector.idPrefix + this.options.searchBoxIconId).addClass(this.cssClass.inputIncrementalSelectIcon);
        },

        /**
         * The function creates variables and cache for this component using
         */
        cacheElements: function () {
            this.$pulldownSelection = $(this.idSelector.idPrefix + this.options.pulldownSelection);
            this.$pulldownSelectionView = $(this.idSelector.idPrefix + this.options.pulldownSelectionView);
            this.$pulldownCandidate = $(this.idSelector.idPrefix + this.options.pulldownCandidate);

            this.$body = $(this.cssSelector.body);
            this.$container = $(this.cssSelector.classPrefix + this.options.container);
            this.$inputControl = this.$container.find(this.cssSelector.inputIncrementalSearch);
            this.$inputControlIcon = this.$container.find(this.cssSelector.inputIncrementalSelectIcon);
        },

        /**
         * The function bind events for this component
         */
        bindEvents: function () {
            var self = this;

            $(document).bind("ajaxSend", function (event, jqXHR) {
                $(window).bind('beforeunload', function () {
                    jqXHR.abort();
                })
            });

            this.$pulldownSelection.on(this.KEY_WORD.CLICK, $.proxy(this._handlePulldownClick, this));
            this.$pulldownCandidate.on(this.KEY_WORD.CLICK, $.proxy(this._handlePulldownChoose, this));

            this.$body.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUp, this));
            this.$inputControl.on(this.KEY_WORD.CUT, $.proxy(this._cutSearchKey, this));

            this.$inputControl.autocomplete({
                source: function (req) {
                    self.suggestList.searchUser(req);
                },
                search : function(event) {
                    if( self.selectedSearchType === self.SEARCH_TYPE.FTS )
                    {
                        return false;
                    }
                    return true;
                },
                minLength: this.options.minLength,
                delay: this.options.timeDelay
            }).on('compositionstart', function(){
                self.isAutoComplete = true;
            });

            this.$inputControl.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleMouseUp, this));
            this.$inputControl.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUpInputControl, this));
            this.$inputControlIcon.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUpInputControlIcon, this));
            this.$body.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleDocumentMouseUp, this));
            this.suggestList.on(this.KEY_WORD.SELECTED, $.proxy(this._selectMemberFromSuggestList, this));

        },

       setSessionInfo: function () {

           var urlParams = this.options.urlParams;
           urlParams["search_selection"] = this.selectedSearchType;

           var request = new grn.component.ajax.request({
               grnUrl: this.options.sessionManagerUrl,
               method: "post",
               data: urlParams
           });
           return request.send().done();
       },

        _handlePulldownClick: function (e) {
            if( this.$pulldownSelection.find("span").hasClass("pulldownbutton_arrow_down_grn") )
            {
                this.$pulldownSelection.find("span").removeClass("pulldownbutton_arrow_down_grn");
                this.$pulldownSelection.find("span").addClass("pulldownbutton_arrow_up_grn");
                this.$pulldownSelectionView.show();
            }
            else if( this.$pulldownSelection.find("span").hasClass("pulldownbutton_arrow_up_grn") )
            {
                this.$pulldownSelection.find("span").removeClass("pulldownbutton_arrow_up_grn");
                this.$pulldownSelection.find("span").addClass("pulldownbutton_arrow_down_grn");
                this.$pulldownSelectionView.hide();
            }
        },

        _handlePulldownChoose: function (e) {
            if( this.selectedSearchType == this.SEARCH_TYPE.FTS )
            {
                this.selectedSearchType = this.SEARCH_TYPE.USER;
                this.$pulldownSelection.html(this.JS_RESOURCES.TODO_SEARCH_USER + "<span class='mLeft3 pulldownbutton_arrow_down_grn'></span>");
                this.$pulldownCandidate.html(this.JS_RESOURCES.TODO_SEARCH_FTS);
            }
            else
            {
                this.selectedSearchType = this.SEARCH_TYPE.FTS;
                this.$pulldownSelection.html(this.JS_RESOURCES.TODO_SEARCH_FTS + "<span class='mLeft3 pulldownbutton_arrow_down_grn'></span>");
                this.$pulldownCandidate.html(this.JS_RESOURCES.TODO_SEARCH_USER);
            }
            this.$inputControl.val(this.KEY_WORD.EMPTY);
            this.$pulldownSelectionView.hide();
            this.setSessionInfo();
        },

        _cutSearchKey: function () {
            var self = this;

            //Using setTimeout with a duration is 0 for immediate execution when cutting value.
            setTimeout(function () {
                if (!self.$inputControl.val().trim()) {
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 0);
        },

        _hideInputControl: function () {
            this.suggestList.isSearched = false;
            this.suggestList.searchKey = null;
            this.suggestList.$suggestList.empty();
            this.suggestList.$containerSuggestedList.hide();
        },

        _handleDocumentMouseUp: function (e) {
            var self = this;
            var targetClass = e.target.className;
            var isRightClick = false;

            if( this.$pulldownSelectionView.is(this.cssSelector.elementHide) && e.target.id != this.options.pulldownSelection )
            {
                if( this.$pulldownSelection.find("span").hasClass("pulldownbutton_arrow_up_grn") )
                {
                    this.$pulldownSelection.find("span").removeClass("pulldownbutton_arrow_up_grn");
                    this.$pulldownSelection.find("span").addClass("pulldownbutton_arrow_down_grn");
                }
                this.$pulldownSelectionView.hide();
            }

            if (targetClass.indexOf(this.cssClass.inputIncrementalSearch) > 0) {
                return;
            }

            if (targetClass.indexOf(this.cssClass.inputIncrementalSelectIcon) > 0 )
            {
                if( this.suggestList.isSelectedMember )
                {
                    return;
                }

                if( !this.$inputControl.hasClass("prefix-grn") &&
                    this.$inputControl.val().trim() !== this.KEY_WORD.EMPTY )
                {
                    this._handleLocationHref();
                }
                return;
            }

            if (this.KEY_WORD.WHICH in e) {
                if (e.which === 3) {
                    isRightClick = true;
                }
            }
            else if (this.KEY_WORD.BUTTON in e) {
                if (e.button === 2) {
                    isRightClick = true;
                }
            }

            if (isRightClick) {
                e.stopImmediatePropagation();
            } else {
                setTimeout(function () {
                    self._hideInputControl();
                }, 10);
            }
        },

        /**
         *<pre> The function fixes for case: drop-down list is displaying and then click 'x' icon of IE input control.
         * When this event is fired after clicking on the clear button the value is not cleared yet. We have to wait for it.
         * </pre>
         * @private
         */
        _handleMouseUp: function () {
            var self = this;
            var oldValue;
            var newValue;

            oldValue = this.$inputControl.val().trim();
            if (oldValue === this.KEY_WORD.EMPTY) {
                return;
            }

            //Using setTimeout with a duration is 1 for delayed execution when the mouse is up.
            setTimeout(function () {
                newValue = self.$inputControl.val().trim();
                if (newValue === self.KEY_WORD.EMPTY) {
                    self.suggestList.searchKey = null;
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 1);
        },

        /**
         *
         * @param {Object} memberSelected
         * @param {Object} memberData
         * @private
         */
        _selectMemberFromSuggestList: function (memberSelected, memberData) {
            if (typeof memberData === this.KEY_WORD.UNDEFINED) {
                return;
            }

            this._forwardUserSearch( memberData._id );
        },

        _handleLocationHref: function ()
        {
            if( this.selectedSearchType === this.SEARCH_TYPE.FTS )
            {
                this._forwardToDoFTS();
            }
            else
            {
                this._forwardUserSearch();
            }
        },

        _forwardToDoFTS: function ()
        {
            if( this.isAutoComplete && ( grn.browser.firefox || grn.browser.msie || grn.browser.safari ) )
            {
                this.isAutoComplete = false;
                return;
            }

            $(this.idSelector.idPrefix + this.options.searchFormId).submit();
        },

        _forwardUserSearch: function ( selected_user_id )
        {
            if( selected_user_id )
            {
                var link = grn.component.url.page(this.options.link) +
                           "br=1&spid=" + this.options.urlParams.spid +
                           "&tid=" + this.options.urlParams.tid +
                           "&uid=" + selected_user_id +
                           "&search_bits=" + this.SEARCH_BITS.INCREMENT;
                window.location.href = link;
            }
            else
            {
                if( this.isAutoComplete && ( grn.browser.firefox || grn.browser.msie || grn.browser.safari ) )
                {
                    this.isAutoComplete = false;
                    return;
                }

                var search_text = $(this.idSelector.idPrefix + this.options.searchBoxTextId).val().trim();
                if( search_text !== this.KEY_WORD.EMPTY )
                {
                    var text_search_link = grn.component.url.page(this.options.link) +
                                           "br=1&spid=" + this.options.urlParams.spid +
                                           "&tid=" + this.options.urlParams.tid +
                                           "&search_text=" + search_text +
                                           "&search_bits=" + this.SEARCH_BITS.USER_SEARCH;
                    window.location.href = text_search_link;
                }
            }
        },

        /**
         * @param {MouseEvent} e
         */
        _handleKeyUpInputControl: function (e) {
            switch (e.keyCode) {
                case this.KEY_CODE.ENTER:
                    if( this.suggestList.isSelectedMember )
                    {
                        return;
                    }
                    this._handleLocationHref();
                    break;
            }
        },

        /**
         * @param {MouseEvent} e
         */
        _handleKeyUpInputControlIcon: function (e) {
            switch (e.keyCode) {
                case this.KEY_CODE.ENTER:
                case this.KEY_CODE.SPACE:
                    if( !this.$inputControl.hasClass("prefix-grn") && this.$inputControl.val().trim() !== this.KEY_WORD.EMPTY )
                    {
                        this._handleLocationHref();
                    }
                    break;
            }
        },

        /**
         * The function handles Key-up of keyboard for executing shown/hide the User/Facility picker.
         * @param {MouseEvent} e
         * @private
         */
        _handleKeyUp: function (e) {
            switch (e.keyCode) {
                case this.KEY_CODE.ESC:
                case this.KEY_CODE.ENTER:
                    this._hideInputControl();
                    break;
                case this.KEY_CODE.LEFT:
                case this.KEY_CODE.RIGHT:
                case this.KEY_CODE.UP:
                case this.KEY_CODE.DOWN:
                case this.KEY_CODE.INSERT:
                case this.KEY_CODE.END:
                case this.KEY_CODE.HOME:
                case this.KEY_CODE.PAGE_UP:
                case this.KEY_CODE.PAGE_DOWN:
                case this.KEY_CODE.CAPS_LOCK:
                    break;
                case this.KEY_CODE.DEL:
                case this.KEY_CODE.BACK_SPACE:
                    if (this.$inputControl.val().trim() === this.KEY_WORD.EMPTY) {
                        this.suggestList.$containerSuggestedList.hide();
                        this.suggestList.$suggestList.empty();
                    }
                    break;
            }
        }
    };
})(jQuery);

