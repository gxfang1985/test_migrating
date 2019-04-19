import Control from "../../common/ui/base/Control";
import ButtonGroup from "../../common/ui/button/ButtonGroup";
import Locale from "../../common/locale/Locale";

const $ = jQuery;

export default class NotificationListBase extends Control {

    _onRender() {
        this._createCategoryButtonGroup();
        this._createStatusButtonGroup();
    }

    _createCategoryButtonGroup() {
        const total_unread_all = this.settings.params.totalUnreadAll;
        const total_unread_to_me = this.settings.params.totalUnreadToMe;
        const label_all = Locale.getMessage("grn.notification", "GRN_NTFC-200");
        const label_to_me = this._getCategoryLabelToMe(total_unread_to_me);
        const category_data = [
            {
                text: label_all,
                value: this.settings.buttonValue.categoryAll,
                isActive: !this.settings.params.isToMe
            },
            {
                text: label_to_me,
                value: this.settings.buttonValue.categoryToMe,
                isActive: this.settings.params.isToMe
            },
        ];
        const $button_category_group_element = this._findByClassName(this.settings.css.categoryButtonGroup);
        this.categoryButtonGroup = new this.settings.buttonGroupClass();
        this.categoryButtonGroup.render(category_data).appendTo($button_category_group_element);

        this._setCategoryButtonState(total_unread_to_me, this.settings.buttonValue.categoryToMe);
        this._setCategoryButtonState(total_unread_all, this.settings.buttonValue.categoryAll);
    }

    _getCategoryLabelToMe(total_unread_to_me) {
        let label_to_me = Locale.getMessage("grn.notification", "GRN_NTFC-201");
        if (total_unread_to_me > 0) {
            label_to_me += total_unread_to_me > 99 ? "(99+)" : `(${total_unread_to_me})`;
        }
        return label_to_me;
    }

    _createStatusButtonGroup() {
        const label_unread = Locale.getMessage("grn.notification", "GRN_NTFC-202");
        const label_read = Locale.getMessage("grn.notification", "GRN_NTFC-203");

        const status_data = [
            {
                text: label_unread,
                value: this.settings.buttonValue.statusUnread,
                isActive: !this.settings.params.isRead
            },
            {
                text: label_read,
                value: this.settings.buttonValue.statusRead,
                isActive: this.settings.params.isRead
            },
        ];

        const $button_status_group_element = this._findByClassName(this.settings.css.statusButtonGroup);
        this.statusButtonGroup = new this.settings.buttonGroupClass();
        this.statusButtonGroup.render(status_data).appendTo($button_status_group_element);
    }

    _setCategoryButtonState(total_unread, value) {
        const is_bold = total_unread > 0;
        this.categoryButtonGroup.setBold(value, is_bold);
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), {
            buttonGroupClass: ButtonGroup,
            buttonValue: {
                categoryAll: 1,
                categoryToMe: 2,
                statusUnread: 3,
                statusRead: 4
            },
            params: {
                portalId: null,
                portletLayoutId: null,
                isToMe: false,
                isRead: false,
                totalUnreadToMe: 0,
                totalUnreadAll: 0,
            },
            css: {
                filterArea: "js_filter",
                categoryButtonGroup: "js_category",
                statusButtonGroup: "js_status",
                refreshButton: "js_refresh",
                contentArea: "js_content",
                hasUnreadAll: "js_has_unread_all",
            },
        });

        return settings;
    }

    _cacheElements() {
        this.$refreshButton = this._findByClassName(this.settings.css.refreshButton);
        this.$contentArea = this._findByClassName(this.settings.css.contentArea);
    }

    _bindEvents() {
        [this.categoryButtonGroup, this.statusButtonGroup, this.$refreshButton].forEach(($element) => {
            $element.on("click", () => {
                this.refresh().then((data) => this.trigger("refresh", data));
                return false;
            });
        });
        this._elementOn("click", "." + this.settings.css.hasUnreadAll, () => {
            this.categoryButtonGroup.setActive(this.settings.buttonValue.categoryAll);
            this.statusButtonGroup.setActive(this.settings.buttonValue.statusUnread);
            this.refresh().then((data) => this.trigger("refresh", data));
            return false;
        });
    }

    /**
     * Check if current selected status is read
     * @returns {boolean} TRUE if selected status is Read, otherwise is Unread
     */
    isRead() {
        return this.statusButtonGroup.getSelectedValue() === this.settings.buttonValue.statusRead;
    }

    /**
     * Check if current selected category is to me
     * @returns {boolean} TRUE if selected category is To me, otherwise is All
     */
    isToMe() {
        return this.categoryButtonGroup.getSelectedValue() === this.settings.buttonValue.categoryToMe;
    }

    /**
     * Append html to content area
     */
    refresh() {
        return this._fetchNotification().then(this._updateNotificationList.bind(this));
    }

    /**
     * Update category button
     * @param {int} totalUnreadToMe
     * @param {int} totalUnreadAll
     */
    updateCategoryButtons({totalUnreadToMe, totalUnreadAll}) {
        const {categoryToMe, categoryAll} = this.settings.buttonValue;

        const label_to_me = this._getCategoryLabelToMe(totalUnreadToMe);
        this.categoryButtonGroup.setLabel(categoryToMe, label_to_me);

        const is_bold_to_me = !!totalUnreadToMe;
        this.categoryButtonGroup.setBold(categoryToMe, is_bold_to_me);

        const is_bold_all = !!totalUnreadAll;
        this.categoryButtonGroup.setBold(categoryAll, is_bold_all);
    }

    /**
     * Change wrap content class if user switch read status tab
     * @protected
     */
    _updateContentWrapperClass() {

    }

    /**
     * Fetch notification data
     * @returns {null}
     * @protected
     */
    _fetchNotification() {
        return null;
    }

    /**
     * Update notification list
     * @param {{content: string, totalUnreadToMe: int, totalUnreadAll: int}} json_data
     * @protected
     */
    _updateNotificationList(json_data) {

    }
}