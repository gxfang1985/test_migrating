import HttpRequest from "../../../common/ajax/HttpRequest";
import NotificationListBase from "../NotificationListBase";

const $ = jQuery;

export default class NotificationList extends NotificationListBase {

    _getDefaultSettings() {
        const setting = {
            element: "js_notification_list_content",
            css: {
                contentWrapperRead: "notification_list_confirmed_grn",
                contentWrapperUnread: "notification_list_grn",
                listColumn: "list_column",
                selectedItems: "input[name='notification[]']:checked",
                sort: "js_sort",
                listMessage: "list_message_grn",
                listSpinner: "js_notification_list_spinner",
            }
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _bindEvents() {
        [this.categoryButtonGroup, this.statusButtonGroup].forEach(($element) => {
            $element.on("click", () => {
                this.settings.params.pageOffset = 0;
            });
        });

        super._bindEvents();

        this._elementOn("click", "input[name='notification[]']", this._handleSelectItem.bind(this));
        this._elementOn("click", "." + this.settings.css.sort, this._handleSort.bind(this));
    }

    _refreshAndTrigger() {
        this.refresh().then((data) => this.trigger("refresh", data));
    }

    _handleSelectItem() {
        this.trigger("selectItem");
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
        if (this._request) {
            this._request.jqXHR.abort();
        }

        const post_data = {
            is_to_me: this.isToMe() === true ? 1 : 0,
            read: this.isRead() === true ? 1 : 0,
            module_id: this.settings.params.moduleId,
            sp: this.settings.params.pageOffset,
            sort: this.settings.params.sort,
            reverse: this.settings.params.reverse,
        };

        this._request = new HttpRequest({
            grnUrl: "notification/ajax/index",
            grnLoadingIndicator: "." + this.settings.css.listSpinner,
            method: "post",
            dataType: "json",
            data: post_data,
        });
        return this._request.send();
    }

    /**
     * Update notification list
     * @param {{content: string, totalUnreadToMe: int, totalUnreadAll: int, paginationInfo: array}} json_data
     * @protected
     */
    _updateNotificationList(json_data) {
        this._updateContentWrapperClass();

        this._findByClassName(this.settings.css.listMessage).remove();

        let $list_column = this._findByClassName(this.settings.css.listColumn);
        $list_column.replaceWith(json_data.content);

        $list_column = this._findByClassName(this.settings.css.listColumn);
        $list_column.hide().fadeIn();

        this.updateCategoryButtons(json_data);

        return {data: json_data};
    }

    /**
     * Handle sort event
     *
     * @private
     */
    _handleSort(event) {
        this.settings.params.sort = event.currentTarget.dataset.sort;
        this.settings.params.reverse = event.currentTarget.dataset.reverse;
        this.settings.params.pageOffset = 0;
        this._refreshAndTrigger();
    }

    /**
     * Return selected items
     * @private
     */
    _getSelectedItems() {
        return this._find(this.settings.css.selectedItems);
    }

    /**
     * Return the number of selected items
     */
    hasSelectedItem() {
        return this._getSelectedItems().length;
    }

    /**
     * Handle mark selected notifications as read
     * @public
     */
    markAsRead() {
        const notification_ids = this._getSelectedItems().map((index, item) => item.value).get();
        const post_data = {
            notification: notification_ids,
            is_to_me: this.isToMe() === true ? 1 : 0,
            csrf_ticket: grn.data.CSRF_TICKET,
        };

        const request = new HttpRequest({
            grnUrl: "notification/ajax/command_mark_as_read",
            method: "post",
            dataType: "json",
            data: post_data,
        });

        return request.send().done(() => {
            this._refreshAndTrigger();
        });
    }

    /**
     * Handle page is changed
     *
     * @param {int} offset
     */
    changePage(offset) {
        this.settings.params.pageOffset = offset;
        this._refreshAndTrigger();
    }

    /**
     * Handle change application
     * @param {int} moduleId
     */
    changeApplication(moduleId) {
        this.settings.params.moduleId = moduleId;
        this.settings.params.pageOffset = 0;
        this._refreshAndTrigger();
    }

}