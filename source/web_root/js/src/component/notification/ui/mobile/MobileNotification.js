import NotificationListBase from "../NotificationListBase";
import MobileButtonGroup from "../../../common/ui/button/mobile/MobileButtonGroup";
import HttpRequest from "../../../common/ajax/HttpRequest";

export default class MobileNotification extends NotificationListBase {

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), {
            buttonGroupClass: MobileButtonGroup,
        });

        return settings;
    }

    /**
     * Fetch notification data
     * @protected
     */
    _fetchNotification() {
        grn.component.mobile_loading.show();

        const post_data = {
            is_read: this.isRead() ? 1 : "",
            is_to_me: this.isToMe() ? 1 : "",
            module_id: this.settings.params.moduleId ? this.settings.params.moduleId : "all",
        };

        const request = new HttpRequest({
            grnUrl: "notification/mobile/ajax/get_notification",
            method: "post",
            dataType: "json",
            data: post_data,
        });
        return request.send();
    }

    /**
     * Update notification list
     * @param {{content: string, total_unread_to_me: int, total_unread_all: int}} json_data
     * @protected
     */
    _updateNotificationList(json_data) {
        this.$contentArea.html(json_data.content);
        this.updateCategoryButtons(json_data);

        this._find("#notification_data_list").trigger("create").listview();
        grn.component.mobile_loading.remove();
    }
}