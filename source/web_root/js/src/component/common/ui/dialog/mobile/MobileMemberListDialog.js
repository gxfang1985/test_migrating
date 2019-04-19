import Control from "../../base/Control";
import HttpRequest from "../../../ajax/HttpRequest";

const $ = jQuery;
const instances = {};

const DEFAULT_SETTINGS = {
    element: "#member_list_dialog",
    url: "grn/ajax/member_list_dialog",
    css: {
        dialogMemberList: "js_member_list",
        dialogTitle: "js_dialog_title",
        moreItem: "js_more_item",
        closeButton: "js_close_button",
        spinner: "js_spinner",
    },
    accessPluginEncoded: null,
};

export default class MobileMemberListDialog extends Control {
    constructor(settings = {}) {
        super(settings);

        instances[this.settings.name] = this;
    }

    static getInstance(name) {
        return instances[name];
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _bindEvents() {
        this._elementOn("click", "." + this.settings.css.moreItem, this._loadMore.bind(this));
        this._elementOn("touchstart", "." + this.settings.css.closeButton, this._close.bind(this));
    }

    _close(event) {
        event.preventDefault();
        event.stopPropagation();
        this.$el.popup("close");
    }

    _cacheElements() {
        this.$memberList = this._findByClassName(this.settings.css.dialogMemberList);
        this.$dialogTitle = this._findByClassName(this.settings.css.dialogTitle);
    }

    bindDialogToMembersContainer(container, dialog_selector = ".dialog_link") {
        $(container).on("click", dialog_selector, this._handleMemberLinkOnClick.bind(this));
    }

    _handleMemberLinkOnClick(event) {
        this.anchorId = event.currentTarget.id;
        this.$memberList.empty();
        this._showSpinner();
        this.$el.popup("open");
        this.$el.popup("option", "tolerance", "10");
        this._getMemberList(this.anchorId).then(this._updateMemberList.bind(this));
    }

    _showSpinner() {
        this.$spinner = $(`<div class="mobile_spinner_block_grn js_spinner"><span class="mobile_icon_spinner_grn"></span></div>`);
        this.$memberList.append(this.$spinner);
    }

    _loadMore(event) {
        const want_page = event.currentTarget.dataset.pager;
        this._findByClassName(this.settings.css.moreItem).remove();
        this._showSpinner();
        this._getMemberList(this.anchorId, want_page)
            .then(this._updateMemberList.bind(this));
    }

    _updateMemberList(data) {
        this.$memberList.append(data.content);
        this.$dialogTitle.text(data.title);
        this.$spinner.remove();
    }

    _getMemberList(anchor_id, want_page = 1) {
        const ajax_send_data = {
            is_ajax_mobile: true,
            anchor_id: anchor_id,
            want_page: want_page,
            access_plugin_encoded: this.settings.accessPluginEncoded
        };

        const request = new HttpRequest({
            grnUrl: this.settings.url,
            method: "post",
            dataType: "json",
            grnRedirectOnLoginError: true,
            data: ajax_send_data
        });

        request.on("beforeShowError", () => {
            this.$el.popup("close");
        });

        return request.send();
    }
}