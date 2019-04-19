import Control from "../../../common/ui/base/Control";

const $ = jQuery;

export default class ListMenu extends Control {

    _getDefaultSettings() {
        const setting = {
            element: ".js_notification_list_content",
            enableMarkAsRead: false,
            css: {
                listMenuTopWrapper: "list_menu_top",
                listMenuBottomWrapper: "list_menu_bottom",
                markAsReadButton: "js_button_mark_as_read",
                checkAll: "js_checkall",
            },
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _cacheElements() {
        this.$listMenuTop = this._findByClassName(this.settings.css.listMenuTopWrapper);
        this.$listMenuBottom = this._findByClassName(this.settings.css.listMenuBottomWrapper);
        this.$markAsReadTop = this.$listMenuTop.find("." + this.settings.css.markAsReadButton);
        this.$markAsReadTopButton = this.$markAsReadTop.find("a");
        this.$markAsReadBottom = this.$listMenuBottom.find("." + this.settings.css.markAsReadButton);
        this.$markAsReadBottomButton = this.$markAsReadBottom.find("a");
    }

    _bindEvents() {
        this.$listMenuTop.on("click", "." + this.settings.css.checkAll, this._handleCheckAll.bind(this));
        this.$listMenuBottom.on("click", "." + this.settings.css.checkAll, this._handleCheckAll.bind(this));
        this.$markAsReadTop.on("click", this._handleMarkAsRead.bind(this));
        this.$markAsReadBottom.on("click", this._handleMarkAsRead.bind(this));
    }

    _handleCheckAll() {
        this.trigger("check");
    }

    _handleMarkAsRead() {
        if (this.settings.enableMarkAsRead) {
            this.settings.enableMarkAsRead = false;
            this.trigger("markAsRead");
        }
    }

    enableMarkAsRead() {
        this.$markAsReadTop.removeClass("button_disable_filter_grn");
        this.$markAsReadTopButton
            .removeAttr("aria-disabled")
            .removeAttr("tabindex");
        this.$markAsReadBottom.removeClass("button_disable_filter_grn");
        this.$markAsReadBottomButton
            .removeAttr("aria-disabled")
            .removeAttr("tabindex");
        this.settings.enableMarkAsRead = true;
    }

    disableMarkAsRead() {
        this.$markAsReadTop.addClass("button_disable_filter_grn");
        this.$markAsReadTopButton
            .attr("aria-disabled", "true")
            .attr("tabindex", "-1");
        this.$markAsReadBottom.addClass("button_disable_filter_grn");
        this.$markAsReadBottomButton
            .attr("aria-disabled", "true")
            .attr("tabindex", "-1");
        this.settings.enableMarkAsRead = false;
    }

    /**
     * Update state of List Menu
     *
     * Disable button "Mark as read" by default
     * If Read = true, hide top and bottom menus
     * If Read = false, show top and bottom menus
     *
     * @param {{read: bool}} data
     */
    setState(data) {
        this.disableMarkAsRead();
        if (data.read) {
            this.$listMenuTop.hide();
            this.$listMenuBottom.hide();
        } else {
            this.$listMenuTop.show();
            this.$listMenuBottom.show();
        }
    }
}