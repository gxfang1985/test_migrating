import Page from "../../component/common/ui/base/Page";
import NotificationList from "../../component/notification/ui/index/NotificationList";
import ListMenu from "../../component/notification/ui/index/ListMenu";
import ApplicationList from "../../component/notification/ui/index/ApplicationList";
import Pagination from "../../component/common/ui/pagination/PairPagination";
import SearchBar from "../../component/notification/ui/index/SearchBar";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    useHistory: true,
    css: {
        element: "js_notification_index",
    }
};

export default class Index extends Page {

    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
    }

    _onRender() {
        super._onRender();
        this._initAppList();
        this._initNotificationList();
        this._initListMenu();
        this._initPagination();
        this._initSearchBar();
    }

    _initAppList() {
        this.$appList = new ApplicationList();
        this.$appList.render();
    }

    _initNotificationList() {
        this.$notificationList = new NotificationList(this.settings);
        this.$notificationList.render();
    }

    _initListMenu() {
        this.$listMenus = new ListMenu();
        this.$listMenus.render();
        this.$listMenus.setState({
            read: this.settings.params.isRead,
        });
        this._bindListMenuEvents();
    }

    _bindListMenuEvents() {
        this.$listMenus.on("check", this._handleSelectItem.bind(this));
        this.$listMenus.on("markAsRead", this._handleMarkAsRead.bind(this));
    }

    _initPagination() {
        this.$pagination = new Pagination(this.settings);
        this.$pagination.render();
        this._bindPaginationEvents();
    }

    _bindPaginationEvents() {
        this.$pagination.on("pageChange", this._handlePaginationChange.bind(this));
    }

    _initSearchBar() {
        this.$searchBar = new SearchBar();
        this.$searchBar.render();
        this._updateSearchBar();
    }

    _bindEvents() {
        this.$appList.on("change", this._changeApplication.bind(this));
        this.$notificationList.on("refresh", this._handleRefreshCompleted.bind(this));
        this.$notificationList.on("selectItem", this._handleSelectItem.bind(this));
    }

    _refreshComponents(data) {
        this._updateSearchBar();
        this.$listMenus.setState({
            read: this.$notificationList.isRead(),
        });
        this.$pagination.setState(data.paginationInfo);
    }

    _handleRefreshCompleted(event, json_data) {
        this._refreshComponents(json_data.data);
        this._handleUpdateHistory();
    }

    _changeApplication(event, {moduleId} = {}) {
        this.$notificationList.changeApplication(moduleId);
    }

    _handleSelectItem() {
        if (this.$notificationList.hasSelectedItem()) {
            this.$listMenus.enableMarkAsRead();
        } else {
            this.$listMenus.disableMarkAsRead();
        }
    }

    /**
     * Handle mark as read event
     * @private
     */
    _handleMarkAsRead() {
        this.$notificationList.markAsRead();
    }

    /**
     * Handle pagination change event
     * @param event
     * @param json_data
     * @private
     */
    _handlePaginationChange(event, json_data) {
        this.$notificationList.changePage(json_data.offset);
    }

    /**
     * Update the parameter and URL of search bar
     * @private
     */
    _updateSearchBar() {
        this.$searchBar.updateSearchBar({
            moduleId: this.$notificationList.settings.params.moduleId,
            read: this.$notificationList.isRead(),
        });
    }

    _handleHistoryOnChange(event, state) {
        const {categoryAll, categoryToMe, statusUnread, statusRead} = this.$notificationList.settings.buttonValue;
        const category_button_state = state.is_to_me === "1" ? categoryToMe : categoryAll;
        const status_button_state = state.read === "1" ? statusRead : statusUnread;
        const module_id = state.module_id || "";
        const page_offset = state.sp || 0;
        const sort = state.sort || "";
        const reverse = state.reverse || "";

        this.$appList.setSelectItem(module_id);
        this.$notificationList.settings.params.moduleId = module_id;
        this.$notificationList.settings.params.pageOffset = page_offset;
        this.$notificationList.settings.params.sort = sort;
        this.$notificationList.settings.params.reverse = reverse;
        this.$notificationList.categoryButtonGroup.setActive(category_button_state);
        this.$notificationList.statusButtonGroup.setActive(status_button_state);
        this.$notificationList.refresh().then((json_data) => this._refreshComponents(json_data.data));
    }

    _handleUpdateHistory() {
        const history_state = this.history.get();
        history_state.read = this.$notificationList.isRead() ? 1 : "";
        history_state.is_to_me = this.$notificationList.isToMe() ? 1 : "";
        history_state.module_id = this.$notificationList.settings.params.moduleId;
        history_state.sp = this.$notificationList.settings.params.pageOffset;
        history_state.sort = this.$notificationList.settings.params.sort;
        history_state.reverse = this.$notificationList.settings.params.reverse;

        this.history.pushState(history_state);
    }
}