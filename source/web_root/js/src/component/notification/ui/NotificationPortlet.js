import HttpRequest from "../../common/ajax/HttpRequest";
import NotificationListBase from "./NotificationListBase";

const $ = jQuery;

export default class NotificationPortlet extends NotificationListBase {

    _getDefaultSettings() {
        const setting = {
            css: {
                contentWrapperRead: "portal_frame_confirmed_notification_grn",
                contentWrapperUnread: "portal_frame_update_grn",
                portletLink: "js_notification_portlet_link",
                selectedItems: "input[name='notification[]']:checked",
                markAsReadButton: "js_button_mark_as_read",
            }
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _onRender() {
        super._onRender();
        this.disableMarkAsRead();
    }

    /**
     * Change wrap content class if user switch read status tab
     * @protected
     */
    _updateContentWrapperClass() {
        if (this.isRead()) {
            this.$contentArea.removeClass(this.settings.css.contentWrapperUnread);
            this.$contentArea.addClass(this.settings.css.contentWrapperRead);
        } else {
            this.$contentArea.removeClass(this.settings.css.contentWrapperRead);
            this.$contentArea.addClass(this.settings.css.contentWrapperUnread);
        }
    }

    /**
     * Fetch notification data
     * @protected
     */
    _fetchNotification() {
        const post_data = {
            portal_id: this.settings.params.portalId,
            portlet_layout_id: this.settings.params.portletLayoutId,
            is_to_me: this.isToMe() === true ? 1 : "",
            read: this.isRead() === true ? 1 : "",
        };

        const request = new HttpRequest({
            grnUrl: "notification/ajax/portlet",
            method: "post",
            dataType: "json",
            data: post_data,
        });
        return request.send();
    }

    /**
     * Update notification list
     * @param {{content: string, totalUnreadToMe: int, totalUnreadAll: int}} json_data
     * @protected
     */
    _updateNotificationList(json_data) {
        this._updateContentWrapperClass();
        const $filter_area = this._findByClassName(this.settings.css.filterArea);
        this.$contentArea.find("tr").not($filter_area).remove();
        $filter_area.after(json_data.content);
        this.$contentArea.find(".list_column").hide().fadeIn();
        const portlet_link = grn.component.url.page("notification/index", {
            is_to_me: this.isToMe() === true ? 1 : "",
            read: this.isRead() === true ? 1 : "",
        });
        this._findByClassName(this.settings.css.portletLink).attr("href", portlet_link);
        this.updateCategoryButtons(json_data);
        this.disableMarkAsRead();
    }

    /**
     * Return selected items
     * @private
     */
    _getSelectedItems() {
        return this._find(this.settings.css.selectedItems);
    }

    _bindEvents() {
        super._bindEvents();
        this.getElement().on("click", this._handleSelectItem.bind(this));
    }

    /**
     * @return {boolean}
     */
    hasSelectedItem() {
        return this._getSelectedItems().length > 0;
    }

    _handleSelectItem() {
        if (this.hasSelectedItem()) {
            this.enableMarkAsRead();
        } else {
            this.disableMarkAsRead();
        }
    }

    enableMarkAsRead() {
        this._findByClassName(this.settings.css.markAsReadButton)
            .removeClass("button_disable_filter_grn")
            .removeAttr("aria-disabled");
    }

    disableMarkAsRead() {
        this._findByClassName(this.settings.css.markAsReadButton)
            .addClass("button_disable_filter_grn")
            .attr("aria-disabled", "true");
    }
}