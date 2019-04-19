import MobilePage from "../../../component/common/ui/base/MobilePage";
import MobileNotification from "../../../component/notification/ui/mobile/MobileNotification";

const DEFAULT_SETTINGS = {
    useHistory: true,
    css: {
        applicationSelect: "js_selected_application",
    },
    unreadMoreURL: grn.component.url.page("notification/mobile/ajax/ajaxGetMoreUnread"),
    readMoreURL: grn.component.url.page("notification/mobile/ajax/ajaxGetMoreReadNotifications"),
    isRead: "1",
    isUnread: "",
    isToMe: "1",
    isAll: "",
};

let $instance;

export default class Index extends MobilePage {

    constructor(settings = {}) {
        super(settings);
        $instance = this;
    }

    static getInstance(){
        return $instance;
    }

    _onRender() {
        this.applicationSelect = this._findByClassName(this.settings.css.applicationSelect);
        this.notificationList = new MobileNotification({
            element: this.settings.element,
            params: this.settings.params,
        });
        this.notificationList.render();
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);

        return settings;
    }

    _bindEvents() {
        this.applicationSelect.on("change", this._applicationSelectOnChange.bind(this));
        this.notificationList.on("refresh", this._handleUpdateHistory.bind(this));
    }

    _applicationSelectOnChange() {
        const selectMenu = grn.component.mobile_select_menu.getInstance(this.settings.selectMenuName);
        this.notificationList.settings.params.moduleId = selectMenu.getSelectedMenuValue();
        this.notificationList.refresh().then(this._handleUpdateHistory.bind(this));
    }

    _updateNotificationURL(state) {
        const post_more_url = state.is_read === this.settings.isRead ? this.settings.readMoreURL : this.settings.unreadMoreURL;
        grn.page.notification.mobile.common.postMoreUrl = post_more_url;
    }

    _handleHistoryOnLoad(event, state) {
        this._updateNotificationURL(state);
    }

    _handleHistoryOnChange(event, state) {
        const {categoryAll, categoryToMe, statusUnread, statusRead} = this.notificationList.settings.buttonValue;
        const category_button_state = state.is_to_me === this.settings.isToMe ? categoryToMe : categoryAll;
        const status_button_state = state.is_read === this.settings.isRead ? statusRead : statusUnread;

        this.notificationList.categoryButtonGroup.setActive(category_button_state);
        this.notificationList.statusButtonGroup.setActive(status_button_state);

        const module_id = state.module_id || "all";
        const selectMenu = grn.component.mobile_select_menu.getInstance(this.settings.selectMenuName);
        selectMenu.setSelectedItemByValue(module_id);

        this.notificationList.settings.params.moduleId = module_id;
        this.notificationList.refresh();

        this._updateNotificationURL(state);
    }

    _handleUpdateHistory() {
        const history_state = this.history.get();

        history_state.is_read = this.notificationList.isRead() ? this.settings.isRead : this.settings.isUnread;
        history_state.is_to_me = this.notificationList.isToMe() ? this.settings.isToMe : this.settings.isAll;

        const selectMenu = grn.component.mobile_select_menu.getInstance(this.settings.selectMenuName);
        history_state.module_id = selectMenu.getSelectedMenuValue();

        this.history.pushState(history_state);

        this._updateNotificationURL(history_state);
    }
}